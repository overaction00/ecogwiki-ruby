$(function() {
    var textArea = document.querySelector('.editform textarea');
    var cm = CodeMirror.fromTextArea(textArea, {
        lineNumbers: true,
        autofocus: true,
        mode: "markdown"
    });
    $("form .actions .btn-preview").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        $.ajax({
            type: "GET",
            url: "/sp.markdown",
            data : {text: cm.getDoc().getValue()},
            success: function(html) {
                $("#wikibody_preview").html(html);
            },
            error: function() {
                alert('문제발생!');
            }
        });
    });

    $("form .actions .btn-delete").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        if(!window.confirm('Are you sure?')) return;

        var URL = $("form").attr("action");
        $.ajax({
            type: "DELETE",
            url: URL,
            success: function() {
                window.location = window.location.pathname;
            },
            error: function() {
                alert("삭제하는데 문제발생!");
            }
        });
        console.log();
    });
});