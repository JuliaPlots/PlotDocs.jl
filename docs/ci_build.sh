#!/usr/bin/env bash

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

echo '== install dependencies =='
sudo apt -y update
sudo apt -y install \
  texlive-{latex-{base,extra},binaries,pictures,luatex} \
  ttf-mscorefonts-installer \
  poppler-utils \
  ghostscript-x \
  qt5-default \
  pdf2svg \
  gnuplot

echo '== install fonts =='
mkdir -p ~/.fonts
repo="https://github.com/cormullion/juliamono"
ver="$(git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' "$repo.git" | tail -n 1 | awk '{ print $2 }' | sed 's,refs/tags/,,')"
url="$repo/releases/download/$ver/JuliaMono-ttf.tar.gz"
echo "downloading & extract url=$url"
wget -q "$url" -O - | tar -xz -C ~/.fonts
sudo fc-cache -vr
fc-list | grep 'JuliaMono'

echo "== build documentation for $GITHUB_REPOSITORY@$GITHUB_REF =="
export JULIA_DEBUG='Documenter,PlotDocs,DemoCards'
export DOCUMENTER_DEBUG=true  # Democards.jl

export GKSwstype=nul  # Plots.jl/issues/3664
export COLORTERM='truecolor'  # UnicodePlots.jl
export PLOTDOCS_ANSICOLOR=true

julia='xvfb-run julia --color=yes --project=docs'

julia -e '
  using Pkg
  Pkg.add("Conda"); Pkg.build("Conda"; verbose=true)
  Pkg.add("PyCall"); Pkg.build("PyCall"; verbose=true)
  using Conda
  Conda.add("matplotlib"); Conda.add("libstdcxx-ng")
  Conda.list()
'

if [ "$GITHUB_REPOSITORY" == 'JuliaPlots/PlotDocs.jl' ]; then
  $julia -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
  $julia docs/make.jl
elif [ "$GITHUB_REPOSITORY" == 'JuliaPlots/Plots.jl' ]; then
  $julia -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.add(PackageSpec(name="Plots", rev=split(ENV["GITHUB_REF"], "/", limit=3)[3])); Pkg.instantiate()'
  $julia -e 'withenv("GITHUB_REPOSITORY" => "JuliaPlots/PlotDocs.jl") do; include("docs/make.jl"); end'
else
  echo "something is wrong with $GITHUB_REPOSITORY"
  exit 1
fi
