function isWikipage() {
    var $body = $("body");
    return $body.data("controller") === "home" &&
        $body.data("action") === "page_handler"
}

$(document).ready(function() {
    if (isWikipage()) {
        initWikipage();
    }
});

function initWikipage() {
    connectHashAnchor();
    hljs.initHighlightingOnLoad(); // initialize highlight js
}

function connectHashAnchor() {
    var $headers = $("section.body :header");
    $("a.hash-anchor").each(function (index) {
        $($headers[index]).attr("id", $(this).attr("href").replace("#", ""));
    });
}
