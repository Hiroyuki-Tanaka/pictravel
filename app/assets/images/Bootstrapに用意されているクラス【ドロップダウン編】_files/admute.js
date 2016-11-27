(function(fout_params) {
    var params = fout_params,
        admute_host = 'admute.fout.jp',
        question_host = 'enq.fout.jp',
        addEvent = getAddEvent(),
        ad_field = document.getElementById('fout-ad'),
        adinfo_field = document.getElementById('fout-adinfo-wrapper'),
        admute_icon = document.getElementById('fout-admute'),
        selection_field = document.getElementById('fout-admute-selection'),
        question_field = document.getElementById('fout-admute-questionnaire'),
        done_field = document.getElementById('fout-admute-done'),
        admute_link = document.getElementById('fout-admute-mutelink'),
        undo_link = document.getElementById('fout-admute-undo'),
        answers = document.getElementsByName('questionnaire_answer');

    params.media_url = encodeURIComponent(params.media_url);
    params.referrer_url = encodeURIComponent(params.referrer_url);
    params = cleanParams(params);

    addEvent(ad_field, 'mouseover', function() {
        admute_icon.style.display='inline-block';
    });
    addEvent(ad_field, 'mouseout', function(e) {
        onMouseOut(adinfo_field, e, function() {
            admute_icon.style.display='none';
        });
    });
    addEvent(admute_icon, 'click', function() {
        if (selection_field.style.display != 'block')
            selection_field.style.display = 'block';
        else
            selection_field.style.display = 'none';
    });
    addEvent(selection_field, 'mouseout', function(e) {
        onMouseOut(selection_field, e, function() {
            selection_field.style.display = 'none';
        });
    });
    addEvent(admute_link, 'click', function(e) {       
        mute(params, admute_host);
        question_field.style.display = 'block';
        question_field.style.zIndex = '10000';

        if (!e) e = window.event;
        e.cancelBubble = true;
        e.returnValue = false;
        if (e.stopPropagation) {
            e.stopPropagation();
            e.preventDefault();
        }

        return false;
    });
    addEvent(undo_link, 'click', function(e) {
        unmute(params, admute_host);
        question_field.style.display = 'none';
        question_field.style.zIndex = '-10000';
    });

    for (var i = 0; i < answers.length; i++) {
        addEvent(answers[i], 'click', function() {
            var selections = document.getElementsByName('questionnaire_answer'),
                i, n = selections.length;

            for (i = 0; i < n; i++) {
                selections[i].setAttribute('disabled', 'disabled');
            }
            
            answerQuestion(params, question_host);

            question_field.style.display = 'none';
            question_field.style.zIndex = '-10000';
            done_field.style.display = 'block';
            done_field.style.zIndex = '10001';
        });
    }

    function getAddEvent() {
        var addEvent;

        if (document.addEventListener) {
            addEvent = function(node, type, handler){
                node.addEventListener(type, handler, false);
            };
        } else if (document.attachEvent) {
            addEvent = function(node, type, handler){
                node.attachEvent('on' + type, function(evt){
                    handler.call(node, evt);
                });
            };
        } else {
            addEvent = function(node, type, handler){
                var _handler = node['on' + type];
                node['on' + type] = function(evt){
                    if (_handler) {
                        _handler.call(node, evt||window.evt);
                    }
                    handler.call(node, evt);
                };
            };
        }

        return addEvent;
    }

    function onMouseOut(element, event, callback) {
        var _isChildOf = function (parent, child) {
            if (child !== null) {
                while (child.parentNode) {
                    if ((child = child.parentNode) === parent) {
                        return true;
                    }
                }
            }
            return false;
        },
            current_mouse_target = null;

        if (event.toElement) {
            current_mouse_target = event.toElement;
        } else if (event.relatedTarget) {
            current_mouse_target = event.relatedTarget;
        }
        if (!_isChildOf(element, current_mouse_target) && element != current_mouse_target) {
            callback();
        }
    }

    function mute(params, host) {
        var keys = ['bid_code', 'user_id', 'bid_id', 'ad_id', 'spot_id', 'adserver_id',
                    'media_url', 'referrer_url', 'is_mute'],
            i, n = keys.length, queries = [];

        params.is_mute = 1;

        for (i = 0; i < n; i++) {
            queries.push([keys[i], params[keys[i]]].join('='));
        }

        var request_url = [document.location.protocol, '//', host, '/',  params.user_id, '/?', queries.join('&')].join('');
        (new Image()).src = request_url;
    }

    function unmute(params, host) {
        var keys = ['bid_code', 'user_id', 'bid_id', 'ad_id', 'spot_id', 'adserver_id',
                    'media_url', 'referrer_url', 'is_mute'],
            i, n = keys.length, queries = [];

        params.is_mute = 0;

        for (i = 0; i < n; i++) {
            queries.push([keys[i], params[keys[i]]].join('='));
        }

        var request_url = [
            document.location.protocol,
            '//',
            host,
            '/',
            params.user_id,
            '/?',
            queries.join('&')
        ].join('');
        (new Image()).src = request_url;
    }

    function answerQuestion(params, host) {
        var keys = ['bid_code', 'user_id', 'bid_id', 'ad_id', 'spot_id', 'adserver_id',
                    'media_url', 'referrer_url', 'questionnaire_id',
                    'questionnaire_answer'],
            answers = document.getElementsByName('questionnaire_answer'),
            i, keylen = keys.length, anslen = answers.length, queries = [];

        params.questionnaire_id = parseInt(document.getElementById('questionnaire_id')
                                           .getAttribute('value'), 10);
        params.questionnaire_answer = '';

        for (i = 0; i < anslen; i++) {
            if (answers[i].checked) {
                params.questionnaire_answer = parseInt(answers[i].getAttribute('value'), 10);
                break;
            }
        }

        for (i = 0; i < keylen; i++) {
            queries.push([keys[i], params[keys[i]]].join('='));
        }

        var request_url = [
            document.location.protocol,
            '//',
            host,
            '/',
            params.user_id,
            '/?',
            queries.join('&')
        ].join('');
        (new Image()).src = request_url;
    }

    function getQueryParams() {
        var query = window.location.search.substring(1),
            params = query.split('&'),
            result = {},
            i, n = params.length, key, val;

        for (i = 0; i < n; i++) {
            var pos = params[i].indexOf('=');
            if (pos > 0) {
                key = params[i].substring(0, pos);
                val = params[i].substring(pos + 1);
                result[key] = val;
            }
        }

        return result;
    }

    function cleanParams(params) {
        var keys = ['bid_code', 'user_id', 'bid_id', 'ad_id', 'spot_id', 'adserver_id',
                    'media_url', 'referrer_url'],
            checks = {
                bid_code: /^\w+$/,
                user_id: /^\d+$/,
                bid_id: /^\d+$/,
                ad_id: /^\d+$/,
                spot_id: /^\d+$/,
                adserver_id: /^\d+$/,
                media_url: /^[A-Za-z0-9\-_\.!~\*'\(\)%]+$/,
                referrer_url: /^[A-Za-z0-9\-_\.!~\*'\(\)%]+$/
            },
            result = {}, i = 0, key, val;

        for (key = keys[i], val = params[key]; key; key = keys[++i], val = params[key]) {
            if (val && checks[key].test(val)) result[key] = val;
            else result[key] = '';
        }

        return result;
    }
})(window.fout);
