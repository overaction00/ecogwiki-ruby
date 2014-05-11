function loginWithFacebook(response) {
    if (response.status === 'connected') {
        FB.api('/me', function(response) {
            $.ajax({
                type: "POST",
                url: "/sp.sign_in",
                data : {res: response},
                success: function(res) {
                    window.location.reload();
                },
                error: function() {
                    alert('문제발생!');
                }
            });
        });
    }
}

function checkStateAndLogin() {
    FB.getLoginStatus(function(response) {
        loginWithFacebook(response);
    });
}

window.fbAsyncInit = function() {
    FB.init({
        appId      : $("[name=facebook-id]").attr("data-facebook-id"),
        cookie     : true,  // enable cookies to allow the server to access
        // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v2.0' // use version 2.0
    });
};

// Load the SDK asynchronously
$(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(function() {
});

