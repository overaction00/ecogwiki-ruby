$(function() {
    $("form .actions .btn-preview").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        $("wikibody_preview")
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
            }
        });
        console.log();
    });
});