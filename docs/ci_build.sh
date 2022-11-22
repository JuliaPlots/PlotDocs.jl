#!/usr/bin/env bash
set -e

key_unset=false
if [ -z "$DOCUMENTER_KEY" ]; then
  echo '`DOCUMENTER_KEY` is missing'
  key_unset=true
fi

tok_unset=false
if [ -z "$GITHUB_TOKEN" ]; then
  echo '`GITHUB_TOKEN` is missing'
  tok_unset=true
fi

if $key_unset && $tok_unset; then
  echo 'either `GITHUB_TOKEN` or `DOCUMENTER_KEY` must be set for `Documenter` !'
  exit 1
fi

echo '== install system dependencies =='
sudo apt -y update
sudo apt -y install \
  texlive-{latex-{base,extra},binaries,pictures,luatex} \
  ttf-mscorefonts-installer \
  poppler-utils \
  ghostscript-x \
  qt5-default \
  pdf2svg \
  gnuplot \
  g++

echo '== install fonts =='
mkdir -p ~/.fonts
repo="https://github.com/cormullion/juliamono"
ver="$(git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' "$repo.git" | tail -n 1 | awk '{ print $2 }' | sed 's,refs/tags/,,')"
url="$repo/releases/download/$ver/JuliaMono-ttf.tar.gz"
echo "downloading & extract url=$url"
wget -q "$url" -O - | tar -xz -C ~/.fonts
sudo fc-cache -vr
fc-list | grep 'JuliaMono'

echo "== install julia dependencies =="
export JULIA_DEBUG='Documenter,PlotDocs,DemoCards'
export DOCUMENTER_DEBUG=true  # Democards.jl

export GKSwstype=nul  # Plots.jl/issues/3664
export COLORTERM='truecolor'  # UnicodePlots.jl
export PLOTDOCS_ANSICOLOR=true

julia='xvfb-run julia --color=yes --project=docs'

$julia -e '
  using Pkg
  Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()
  Pkg.add("Conda"); Pkg.build("Conda"; verbose=true)
  using Conda; env, rc = Conda.ROOTENV, Conda.conda_rc(Conda.ROOTENV)
  Conda.runconda(`config --set auto_update_conda False --file $rc --force`, env)
  Pkg.add("PyCall"); Pkg.build("PyCall"; verbose=true)
  Conda.add("matplotlib")
  Conda.list()
'

# tentative fix for `pyplot` bug: libstdc++.so.X: version `GLIBCXX_X.X.X' not found ...
# export LD_PRELOAD=$(g++ --print-file-name=libstdc++.so)
export LD_PRELOAD=$($julia -e 'using Conda; joinpath(Conda.ROOTENV, "lib", "libstdc++.so") |> print')
echo $LD_PRELOAD

echo "== build documentation for $GITHUB_REPOSITORY@$GITHUB_REF, triggerd by $GITHUB_ACTOR on $GITHUB_EVENT_NAME =="
if [ "$GITHUB_REPOSITORY" == 'JuliaPlots/PlotDocs.jl' ]; then
  $julia docs/make.jl
elif [ "$GITHUB_REPOSITORY" == 'JuliaPlots/Plots.jl' ]; then
  $julia -e 'using Pkg; Pkg.add(PackageSpec(name="Plots", rev=split(ENV["GITHUB_REF"], "/", limit=3)[3])); Pkg.instantiate()'
  $julia -e 'withenv("GITHUB_REPOSITORY" => "JuliaPlots/PlotDocs.jl") do; include("docs/make.jl"); end'
else
  echo "something is wrong with $GITHUB_REPOSITORY"
  exit 1
fi
