/*
 * cookie-parser
 * https://github.com/danjordan/cookie-parser
 *
 * Copyright (c) 2012 Daniel Jordan
 * Licensed under the MIT, GPL licenses.
 */

(function() {

	'use strict';
	
	var attributes = ['name', 'value', 'expires', 'path', 'domain', 'secure', 'httponly'];

    window.cookieparser = function (cookie_string) {
        var cookies = {};
        var params = cookie_string.split('; ');

        params.forEach(function (param) {
            var cookie = {
                options: {}
            };
            param = param.split('=');
            var key = param[0];
            var value = param[1];

            if (attributes.indexOf(key) > 0) {
                if (key === 'expires') {
                    cookie.options[key] = new Date(value);
                } else {
                    cookie.options[key] = value || true;
                }
            } else {
                cookie.name = key;
                cookie.value = value;
            }
            cookies[key] = cookie;
        });
        return cookies
    };
}());