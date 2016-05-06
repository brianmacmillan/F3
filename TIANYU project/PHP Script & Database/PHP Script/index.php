<?php  session_start();  ?>
<!DOCTYPE html>
<html class="js before-run" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="freaktemplate.com">
    <meta name="author" content="Redixbit Software technology">
    <title>Login | Admin</title>
    <link rel="apple-touch-icon" href="uploads/logo.png">
    <link rel="shortcut icon" href="uploads/logo.png">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-extend.min.css">
    <link rel="stylesheet" href="assets/css/site.min.css">

    <link rel="stylesheet" href="assets/vendor/animsition/animsition.css">
    <link rel="stylesheet" href="assets/vendor/asscrollable/asScrollable.css">
    <link rel="stylesheet" href="assets/vendor/switchery/switchery.css">
    <link rel="stylesheet" href="assets/vendor/intro-js/introjs.css">
    <link rel="stylesheet" href="assets/vendor/slidepanel/slidePanel.css">
    <link rel="stylesheet" href="assets/vendor/flag-icon-css/flag-icon.css">
    <link rel="stylesheet" href="assets/vendor/formvalidation/formValidation.css">
    <!-- Page -->
    <link rel="stylesheet" href="assets/css/pages/login.css">
    <!-- Fonts -->
    <link rel="stylesheet" href="assets/fonts/web-icons/web-icons.min.css">
    <link rel="stylesheet" href="assets/fonts/brand-icons/brand-icons.min.css">
    <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,300italic'>
    <!--[if lt IE 9]>
    <script src="assets/vendor/html5shiv/html5shiv.min.js"></script>
    <![endif]-->
    <!--[if lt IE 10]>
    <script src="assets/vendor/media-match/media.match.min.js"></script>
    <script src="assets/vendor/respond/respond.min.js"></script>
    <![endif]-->
    <!-- Scripts -->
    <script src="assets/vendor/modernizr/modernizr.js"></script>
    <script src="assets/vendor/breakpoints/breakpoints.js"></script>
    <script>Breakpoints();</script>
</head>
<body class="page-login layout-full">
<!-- Page -->
<div class="page animsition vertical-align text-center" data-animsition-in="fade-in"
     data-animsition-out="fade-out">
    <div class="page-content vertical-align-middle">
        <div class="brand">
            <img class="brand-img" src="uploads/logo.png" alt="...">
            <h2 class="brand-text">Your Company Name Admin</h2>
        </div>
        <p>Login into your account</p>
        <form method="post" class="submitlogin" id="exampleStandardForm" onsubmit="alertmsg()">
            <div class="form-group">
                <label class="sr-only" for="inputEmail">Username</label>
                <input type="text" class="form-control " id="username" name="standard_email" value=""
                       placeholder="Enter Your Username">
            </div>
            <div class="form-group">
                <label class="sr-only" for="inputPassword">Password</label>
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Enter Your Password" value=""
                       required="">
            </div>
            <div id="error" style="color:#f96868;"></div>
            <button type="submit" name="submit" class="btn btn-primary btn-block " id="validateButton2">Sign in</button>

            <div class="form-group clearfix">

                <a class="pull-right" href="forgotpassword.php">Forgot password?</a>
            </div>
        </form>
    </div>
</div>
<script>
    function alertmsg(){
        var username=$("#username").val();
        var password=$("#password").val();
        $.ajax({
            type: "POST",
            url: "include/login.php",
            data: "username="+ username +"&password="+password,
            cache: false,
            beforeSend: function(){ $("#login").val('Connecting...');},
            success: function(data){
                if(data == "logindone")
                {
                    window.location="master.php";
                }
                else
                {
                    document.getElementById("error").innerHTML = "Invalid Username and Password !!! ";
                }
            }
        });
    }
</script>
<script src="assets/vendor/jquery/jquery.js"></script>
<script src="assets/vendor/bootstrap/bootstrap.js"></script>
<script src="assets/vendor/animsition/jquery.animsition.js"></script>
<script src="assets/vendor/asscroll/jquery-asScroll.js"></script>
<script src="assets/vendor/mousewheel/jquery.mousewheel.js"></script>
<script src="assets/vendor/asscrollable/jquery.asScrollable.all.js"></script>
<script src="assets/vendor/ashoverscroll/jquery-asHoverScroll.js"></script>
<script src="assets/vendor/switchery/switchery.min.js"></script>
<script src="assets/vendor/intro-js/intro.js"></script>
<script src="assets/vendor/screenfull/screenfull.js"></script>
<script src="assets/vendor/slidepanel/jquery-slidePanel.js"></script>
<script src="assets/vendor/jquery-placeholder/jquery.placeholder.js"></script>
<!-- Scripts -->
<script src="assets/js/core.js"></script>
<script src="assets/js/site.js"></script>
<script src="assets/js/sections/menu.js"></script>
<script src="assets/js/sections/menubar.js"></script>
<script src="assets/js/sections/sidebar.js"></script>
<script src="assets/js/configs/config-colors.js"></script>
<script src="assets/js/configs/config-tour.js"></script>
<script src="assets/js/components/asscrollable.js"></script>
<script src="assets/js/components/animsition.js"></script>
<script src="assets/js/components/slidepanel.js"></script>
<script src="assets/js/components/switchery.js"></script>
<script src="assets/js/components/jquery-placeholder.js"></script>
<script src="assets/vendor/formvalidation/formValidation.min.js"></script>
<script src="assets/vendor/formvalidation/framework/bootstrap.min.js"></script>
<script>
    (function (document, window, $) {
        'use strict';
        var Site = window.Site;
        $(document).ready(function () {
            Site.run();
        });
    })(document, window, jQuery);
</script>
</body>
<script>
    (function (document, window, $) {
        'use strict';
        var Site = window.Site;
        $(document).ready(function ($) {
            Site.run();
        });
        (function () {
            $('#exampleStandardForm').formValidation({
                framework: "bootstrap",
                button: {
                    selector: '#validateButton2',
                    disabled: 'disabled'
                },
                icon: null,
                fields: {
                    standard_fullName: {
                        validators: {
                            notEmpty: {
                                message: 'The full name is required and cannot be empty'
                            }
                        }
                    },
                    standard_email: {
                        validators: {
                            notEmpty: {
                                message: 'This Username is required and can not be empty!!!'
                            },
                            emailAddress: {
                                message: 'This Username is not valid !!!'
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: 'Password Is Required !!!'
                            }

                        }
                    }

                }
            });
        })();
        (function () {
            $('.summary-errors').hide();

            $('#exampleSummaryForm').formValidation({
                framework: "bootstrap",
                button: {
                    selector: '#validateButton3',
                    disabled: 'disabled'
                },
                icon: null,
                fields: {
                    summary_fullName: {
                        validators: {
                            notEmpty: {
                                message: 'The full name is required and cannot be empty'
                            }
                        }
                    },
                    summary_email: {
                        validators: {
                            notEmpty: {
                                message: 'The email address is required and cannot be empty'
                            },
                            emailAddress: {
                                message: 'The email address is not valid'
                            }
                        }
                    },
                    summary_content: {
                        validators: {
                            notEmpty: {
                                message: 'The content is required and cannot be empty'
                            },
                            stringLength: {
                                max: 500,
                                message: 'The content must be less than 500 characters long'
                            }
                        }
                    }
                }
            })
                .on('success.form.fv', function (e) {

                    $('.summary-errors').html('');
                })

                .on('err.field.fv', function (e, data) {

                    $('.summary-errors').show();
                    var messages = data.fv.getMessages(data.element);
                    $('.summary-errors').find('li[data-field="' + data.field +
                        '"]').remove();
                    for (var i in messages) {

                        $('<li/>')
                            .attr('data-field', data.field)
                            .wrapInner(
                            $('<a/>')
                                .attr('href', 'javascript: void(0);')

                                .html(messages[i])
                                .on('click', function (e) {

                                    data.element.focus();
                                })
                        ).appendTo('.summary-errors > ul');
                    }
                    data.element
                        .data('fv.messages')
                        .find('.help-block[data-fv-for="' + data.field + '"]')
                        .hide();
                })

                .on('success.field.fv', function (e, data) {

                    $('.summary-errors > ul').find('li[data-field="' + data.field +
                        '"]').remove();
                    if ($('#exampleSummaryForm').data('formValidation').isValid()) {
                        $('.summary-errors').hide();
                    }
                });
        })();
    })(document, window, jQuery);
</script>
</html>