<?php  session_start(); if(isset($_SESSION['uname'])) { ?>
    <!DOCTYPE html>
    <html class="no-js before-run" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <meta name="description" content="freaktemplate.com">
        <meta name="author" content="Redixbit Software technology">
        <title>Restaurant Admin | Add Food Category</title>
        <link rel="apple-touch-icon" href="uploads/logo.png">
        <link rel="shortcut icon" href="uploads/logo.png">
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
        <link rel="stylesheet" href="assets/fonts/web-icons/web-icons.min.css">
        <link rel="stylesheet" href="assets/fonts/brand-icons/brand-icons.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.wallform.js"></script>
        <style>
            .has-feedback .form-control-feedback {
                right: 15px;
            }
            .summary-errors p,
            .summary-errors ul li a {
                color: inherit;
            }

            .summary-errors ul li a:hover {
                text-decoration: none;
            }

            @media (min-width: 768px) {
                #exampleFullForm .form-horizontal .control-label {
                    text-align: inherit;
                }
            }
        </style>
        <script src="assets/vendor/html5shiv/html5shiv.min.js"></script>


        <!--[if lt IE 10]>
        <script src="assets/vendor/media-match/media.match.min.js"></script>
        <script src="assets/vendor/respond/respond.min.js"></script>
        <![endif]-->

        <!-- Scripts -->
        <script src="assets/vendor/modernizr/modernizr.js"></script>
        <script src="assets/vendor/breakpoints/breakpoints.js"></script>
        <script>
            Breakpoints();
        </script>
    </head>
    <body>

    <?php
    function encrypt_decrypt($action, $string) {
        $output = false;

        $encrypt_method = "AES-256-CBC";
        $secret_key = 'This is my secret key';
        $secret_iv = 'This is my secret iv';

// hash
        $key = hash('sha256', $secret_key);

// iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
        $iv = substr(hash('sha256', $secret_iv), 0, 16);

        if( $action == 'encrypt' ) {
            $output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
            $output = base64_encode($output);
        }
        else if( $action == 'decrypt' ){
            $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
        }

        return $output;
    }
    include'include/config.php';$idd = $_GET['a2NoOTY1OVhIRGd1VThRZ2JXUlk0dz09'];

    $dataid=encrypt_decrypt('decrypt', $idd);
    $query = mysqli_query($con,"select * from tbl_restourant WHERE id = '$dataid' ");
    $res=mysqli_fetch_array($query);
    $lat=$res['latitude'];
    $long=$res['longitude'];
    include'include/header.php';
    include'include/rightside.php';
    include 'include/updaterestaurant.php';
    include'include/footer.php';
    ?>

    <script>
        $(document).ready(function() {
            $('#photoimg').die('click').live('change', function()			{
                $("#imageform").ajaxForm({target: '#preview',
                    beforeSubmit:function(){

                        console.log('ttest');
                        $("#imageloadstatus").show();
                        $("#imageloadbutton").hide();
                    },
                    success:function(){
                        console.log('test');
                        $("#imageloadstatus").hide();
                        $("#imageloadbutton").show();
                    },
                    error:function(){
                        console.log('xtest');
                        $("#imageloadstatus").hide();
                        $("#imageloadbutton").show();
                    } }).submit();
            });
        });
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
    <script src="assets/vendor/formvalidation/formValidation.min.js"></script>
    <script src="assets/vendor/formvalidation/framework/bootstrap.min.js"></script>
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

    <script>
        (function(document, window, $) { 'use strict'; var Site = window.Site;
            $(document).ready(function($) {
                Site.run();
            });
            (function() {
                $('#exampleFullForm').formValidation({
                    framework: "bootstrap",
                    button: {
                        selector: '#validateButton1',
                        disabled: 'disabled'
                    },
                    icon: null,
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                    message: 'The restourant name is required'
                                }

                            }
                        },
                        email: {
                            validators: {
                                notEmpty: {
                                    message: 'The email id is required'
                                },
                                emailAddress: {
                                    message: 'The email address is not valid'
                                }
                            }
                        },
                        password: {
                            validators: {
                                notEmpty: {
                                    message: 'The password is required'
                                },
                                stringLength: {
                                    min: 8
                                }
                            }
                        },

                        zipcode: {
                            validators: {
                                notEmpty:{
                                    message: 'The zipcode is required'
                                },
                                digits : {
                                    message: 'The number is required'
                                }
                            }
                        },

                        mobile: {
                            validators: {
                                notEmpty: {
                                    message: 'The Phone No. is required'
                                },
                                digits : {
                                    message: 'The number is required'
                                }

                            }
                        },

                        birthday: {
                            validators: {
                                notEmpty: {
                                    message: 'The birthday is required'
                                },
                                date: {
                                    format: 'YYYY/MM/DD'
                                }
                            }
                        },
                        latitude: {
                            validators: {
                                notEmpty: {
                                    message: 'The latitude is required'
                                }

                            }
                        },

                        longitude: {
                            validators: {
                                notEmpty: {
                                    message: 'The longitude is required'
                                }


                            }
                        },
                        time: {
                            validators: {
                                notEmpty: {
                                    message: 'The time is required'
                                },
                                time : {
                                    message: 'The number is required'
                                }
                            }
                        },
                        time2: {
                            validators: {
                                notEmpty: {
                                    message: 'The To time is required'
                                },
                                time : {
                                    message: 'The number is required'
                                }
                            }
                        },

                        'photos[]': {
                            validators: {
                                notEmpty: {
                                    message: 'Please Select images ! is required'
                                }
                            }
                        },

                        'thumbs': {
                            validators: {
                                notEmpty: {
                                    message: 'Please Select thumbnail image ! is required'
                                }
                            }
                        },
                        porto_is: {
                            validators: {
                                notEmpty: {
                                    message: 'Please specify at least one'
                                }
                            }
                        },
                        'for[]': {
                            validators: {
                                notEmpty: {
                                    message: 'Please specify at least one'
                                }
                            }
                        },
                        company: {
                            validators: {
                                notEmpty: {
                                    message: 'Please company'
                                }
                            }
                        },
                        browsers: {
                            validators: {
                                notEmpty: {
                                    message: 'Please specify at least one Food type select!'
                                }
                            }
                        }
                    }
                });
            })();
            (function() {
                $('#exampleConstraintsForm, #exampleConstraintsFormTypes').formValidation({
                    framework: "bootstrap",
                    icon: null,
                    fields: {
                        type_email: {
                            validators: {
                                emailAddress: {
                                    message: 'The email address is not valid'
                                }
                            }
                        },
                        type_url: {
                            validators: {
                                url: {
                                    message: 'The url is not valid'
                                }
                            }
                        },
                        type_digits: {
                            validators: {
                                digits: {
                                    message: 'The value is not digits'
                                }
                            }
                        },
                        type_numberic: {
                            validators: {
                                integer: {
                                    message: 'The value is not an number'
                                }
                            }
                        },
                        type_phone: {
                            validators: {
                                phone: {
                                    message: 'The value is not an phone(US)'
                                }
                            }
                        },
                        type_credit_card: {
                            validators: {
                                creditCard: {
                                    message: 'The credit card number is not valid'
                                }
                            }
                        },
                        type_date: {
                            validators: {
                                date: {
                                    format: 'YYYY/MM/DD'
                                }
                            }
                        },
                        type_color: {
                            validators: {
                                color: {
                                    type: ['hex', 'hsl', 'hsla', 'keyword', 'rgb',
                                        'rgba'
                                    ], // The default value for type
                                    message: 'The value is not valid color'
                                }
                            }
                        },
                        type_ip: {
                            validators: {
                                ip: {
                                    ipv4: true,
                                    ipv6: true,
                                    message: 'The value is not valid ip(v4 or v6)'
                                }
                            }
                        }
                    }
                });
            })();
            (function() {
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
                                    message: 'The email address is required and cannot be empty'
                                },
                                emailAddress: {
                                    message: 'The email address is not valid'
                                }
                            }
                        },
                        standard_content: {
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
                });
            })();
            (function() {
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

                    .on('success.form.fv', function(e) {
                        $('.summary-errors').html('');
                    })
                    .on('err.field.fv', function(e, data) {
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
                                    .on('click', function(e) {
                                        // Focus on the invalid field
                                        data.element.focus();
                                    })
                            ).appendTo('.summary-errors > ul');
                        }
                        data.element
                            .data('fv.messages')
                            .find('.help-block[data-fv-for="' + data.field + '"]')
                            .hide();
                    })
                    .on('success.field.fv', function(e, data) {
                        $('.summary-errors > ul').find('li[data-field="' + data.field +
                            '"]').remove();
                        if ($('#exampleSummaryForm').data('formValidation').isValid()) {
                            $('.summary-errors').hide();
                        }
                    });
            })();
        })(document, window, jQuery);
    </script>
    </body>
    </html>
    <?php }  else { ?><script>window.location='index.php';</script><?php } ?>