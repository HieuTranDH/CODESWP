<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Language" content="en">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Login - ArchitectUI HTML Bootstrap 4 Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
        <meta name="description" content="ArchitectUI HTML Bootstrap 4 Dashboard Template">
        <meta name="msapplication-tap-highlight" content="no">
        <link href="demo.dashboardpack.com/architectui-html-pro/main.d810cf0ae7f39f28f336.css" rel="stylesheet">
    </head>

    <body>
        <script>
            // Check if the message variable is set or not
            document.addEventListener("DOMContentLoaded", (event) => {
                var errorMessage = "${message}";
                // Check if the errorMessage is "Registration Success" or "Password Change Success"
                if ((errorMessage == "Registration Success" || errorMessage == "Đổi mật khẩu thành công.") && errorMessage != "") {
                    swal({
                        title: "Success!",
                        text: errorMessage,
                        icon: "success",
                        button: "OK",
                    });
                } else if (errorMessage != "") {
                    swal({
                        title: "Error!",
                        text: errorMessage,
                        icon: "error",
                        button: "OK",
                    });
                }
            });
        </script>
        
        <div class="app-container app-theme-white body-tabs-shadow">
            <div class="app-container">
                <div class="h-100">
                    <div class="h-100 no-gutters row">
                        <div class="d-none d-lg-block col-lg-4">
                            <div class="slider-light">
                                <div class="slick-slider">
                                    <div>
                                        <div class="position-relative h-100 d-flex justify-content-center align-items-center bg-plum-plate" tabindex="-1">
                                            <div class="slide-img-bg" style="background-image: url('assets/images/originals/city.jpg');"></div>
                                            <div class="slider-content">
                                                <h3>FCM FPT Cinema Movie</h3>
                                                <p>FCM (FPT Cinema Movie) là một trang web rạp chiếu phim trực tuyến, nơi người dùng có thể tìm kiếm, đặt vé và thưởng thức những bộ phim mới nhất.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="position-relative h-100 d-flex justify-content-center align-items-center bg-premium-dark" tabindex="-1">
                                            <div class="slide-img-bg" style="background-image: url('demo.dashboardpack.com/architectui-html-pro/assets/images/originals/citynights.jpg');"></div>
                                            <div class="slider-content">
                                                <h3>Scalable, Modular, Consistent</h3>
                                                <p>Easily exclude the components you don't require. Lightweight, consistent
                                                    Bootstrap based styles across all elements and components
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="position-relative h-100 d-flex justify-content-center align-items-center bg-sunny-morning" tabindex="-1">
                                            <div class="slide-img-bg" style="background-image: url('assets/images/originals/citydark.jpg');"></div>
                                            <div class="slider-content">
                                                <h3>Complex, but lightweight</h3>
                                                <p>We've included a lot of components that cover almost all use cases for any type of application.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="h-100 d-flex bg-white justify-content-center align-items-center col-md-12 col-lg-8">
                            <div class="mx-auto app-login-box col-sm-12 col-md-10 col-lg-9">
                                <h4 class="mb-0">
                                    <span class="d-block">Welcome back,</span>
                                    <span>Please sign in to your account.</span>
                                </h4>
                                <h6 class="mt-3">No account? <a href="${pageContext.request.contextPath}/register" class="text-primary">Sign up now</a></h6>
                                <div class="divider row"></div>
                                <div>
                                    <form name="input" action="login" method="post">
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="exampleEmail" class>Email</label>
                                                    <input type="text" class="form-control rounded" placeholder="Enter email" id="identify" name="identify" value="${cookie.identify.value}" autofocus>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="examplePassword" class>Password</label>
                                                    <input type="password" id="password" name="password" class="rounded form-control" placeholder="Enter password" value="${cookie.password.value}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="position-relative form-check">
                                            <input class="form-check-input primary rounded" type="checkbox" value="true" id="flexCheckChecked" name="rememberMe" <c:if test="${cookie.rememberMe.value eq 'true'}"></c:if>
                                                   <label class="form-check-label text-dark" for="flexCheckChecked">
                                                    Remember me
                                                </label>
                                            </div>
                                            <div class="divider row"></div>
                                            <div class="d-flex align-items-center">
                                                <div class="ml-auto">
                                                    <a href="${pageContext.request.contextPath}/lostaccount" class="btn-lg btn btn-link">Recover Password</a>
                                                <button class="btn btn-primary btn-lg">Login</button>
                                            </div>
                                        </div>
                                    </form>

                                    <%@ include file="googlelogin.jsp" %>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="demo.dashboardpack.com/architectui-html-pro/assets/scripts/main.d810cf0ae7f39f28f336.js"></script>
        <script src="${pageContext.request.contextPath}/static/libs/jquery/dist/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script></body>
</html>