
Here's some attributes:

<script language="JavaScript">
<!--
function autoResize(id){
    var newheight;
    var newwidth;

    if(document.getElementById){
        newheight = document.getElementById(id).contentWindow.document .body.scrollHeight;
        newwidth = document.getElementById(id).contentWindow.document .body.scrollWidth;
    }

    document.getElementById(id).height = (newheight) + "px";
    document.getElementById(id).width = (newwidth) + "px";
}
//-->
</script>

<iframe src="../series_attr.html" name="series attributes" height="700" width="700", id="seriesframe" marginheight="0" frameborder="0" onLoad="autoResize('seriesframe');">You need a Frames Capable browser to view this content.</iframe>

and some more:

<iframe src="../subplot_attr.html" name="subplot attributes" height="700" width="700", id="subplotframe" marginheight="0" frameborder="0" onLoad="autoResize('subplotframe');">You need a Frames Capable browser to view this content.</iframe>

