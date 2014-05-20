$(document).ready(function() {
    connectHashAnchor();
});

function connectHashAnchor() {
    var $headers = $("section.body :header");
    $("a.hash-anchor").each(function (index) {
        $($headers[index]).attr("id", $(this).attr("href").replace("#", ""));
    });
}