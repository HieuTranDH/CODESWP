<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">

    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/pages-register.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:40:28 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Language" content="en">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Register - ArchitectUI HTML Bootstrap 4 Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
        <meta name="description" content="ArchitectUI HTML Bootstrap 4 Dashboard Template">

        <meta name="msapplication-tap-highlight" content="no">
        <link href="demo.dashboardpack.com/architectui-html-pro/main.d810cf0ae7f39f28f336.css" rel="stylesheet"></head>
    <body>
        <div class="app-container app-theme-white body-tabs-shadow">
            <div class="app-container">
                <div class="h-100">
                    <div class="h-100 no-gutters row">
                        <div class="h-100 d-md-flex d-sm-block bg-white justify-content-center align-items-center col-md-12 col-lg-7">
                            <div class="mx-auto app-login-box col-sm-12 col-md-10 col-lg-9">
                                <h4>
                                    <div>Welcome to FCM FPT Cinema Movie</div>
                                    <span>It only takes a <span class="text-success">few seconds</span> to create your account</span>
                                </h4>
                                <div>
                                    <form name="input" action="register" method="post" onsubmit="return validateForm()">
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="exampleEmail" class><span class="text-danger">*</span> Email</label>
                                                    <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="Enter email" onkeyup="showEmailHint()" required>
                                                    <div id="emailHint" style="color: #666; font-size: 14px; margin-top: 5px;"></div>
                                                </div>
                                            </div>


                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="exampleName" class>Name</label>
                                                    <input type="text" class="form-control rounded" id="userName" name="userName" placeholder="Enter name" required>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="examplePassword" class><span class="text-danger">*</span> Enter Password</label>
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" onkeyup="showPasswordHint()" required>
                                                    <div id="passwordHint" style="color: #666; font-size: 14px; margin-top: 5px;"></div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="position-relative form-group">
                                                    <label for="examplePasswordRep" class><span class="text-danger">*</span> Repeat Password</label>
                                                    <input type="password" class="form-control rounded" id="rePassword" name="rePassword" placeholder="Re-enter
                                                           password" required>                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info">${message}</div>
                                        </c:if>
                                        <div class="mt-4 d-flex align-items-center">
                                            <h5 class="mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login?value=login" class="text-primary">Sign in</a></h5>
                                            <div class="ml-auto">
                                                <button class="btn-wide btn-pill btn-shadow btn-hover-shine btn btn-primary btn-lg">Create Account </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>
                        <div class="d-lg-flex d-xs-none col-lg-5">
                            <div class="slider-light">
                                <div class="slick-slider slick-initialized">
                                    <div>
                                        <div class="position-relative h-100 d-flex justify-content-center align-items-center bg-premium-dark" tabindex="-1">
                                            <div class="slide-img-bg" style="background-image: url('static/images/Cinema _Movie Theatre.jpeg');"></div>
                                            <div class="slider-content">
                                                <h3>FCM FPT Cinema Movie</h3>
                                                <p>FCM (FPT Cinema Movie) là một trang web rạp chiếu phim trực tuyến, nơi người dùng có thể tìm kiếm, đặt vé và thưởng thức những bộ phim mới nhất.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="demo.dashboardpack.com/assets/scripts/main.d810cf0ae7f39f28f336.js"></script></body>
    <script>
                                                        function validateForm() {
                                                            return validateEmail() && validatePassword();
                                                        }

                                                        function validateEmail() {
                                                            var email = document.getElementById("userEmail").value;
                                                            var emailHint = document.getElementById("emailHint");
                                                            var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                                                            var isValid = true;
                                                            var errorMessage = "";

                                                            if (!emailRegex.test(email)) {
                                                                isValid = false;
                                                                errorMessage = "Email must end with @gmail.com.";
                                                            }

                                                            if (!isValid) {
                                                                alert(errorMessage);
                                                                emailHint.textContent = errorMessage;
                                                            } else {
                                                                emailHint.textContent = "";
                                                            }

                                                            return isValid;
                                                        }

                                                        function showEmailHint() {
                                                            var email = document.getElementById("userEmail").value;
                                                            var emailHint = document.getElementById("emailHint");
                                                            var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;

                                                            if (!emailRegex.test(email)) {
                                                                emailHint.textContent = "Email must end with @gmail.com.";
                                                            } else {
                                                                emailHint.textContent = "";
                                                            }
                                                        }

                                                        function validatePassword() {
                                                            var password = document.getElementById("password").value;
                                                            var lowercaseRegex = /[a-z]/;
                                                            var uppercaseRegex = /[A-Z]/;
                                                            var digitRegex = /\d/;
                                                            var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

                                                            var isValid = true;
                                                            var errorMessage = "";

                                                            if (!lowercaseRegex.test(password)) {
                                                                isValid = false;
                                                                errorMessage += "Password must contain at least one lowercase letter.\n";
                                                            }

                                                            if (!uppercaseRegex.test(password)) {
                                                                isValid = false;
                                                                errorMessage += "Password must contain at least one uppercase letter.\n";
                                                            }

                                                            if (!digitRegex.test(password)) {
                                                                isValid = false;
                                                                errorMessage += "Password must contain at least one digit.\n";
                                                            }

                                                            if (!specialCharRegex.test(password)) {
                                                                isValid = false;
                                                                errorMessage += "Password must contain at least one special character.\n";
                                                            }

                                                            if (!isValid) {
                                                                alert(errorMessage);
                                                            }

                                                            return isValid;
                                                        }

                                                        function showPasswordHint() {
                                                            var password = document.getElementById("password").value;
                                                            var passwordHint = document.getElementById("passwordHint");
                                                            var lowercaseRegex = /[a-z]/;
                                                            var uppercaseRegex = /[A-Z]/;
                                                            var digitRegex = /\d/;
                                                            var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

                                                            var hintMessage = "";

                                                            if (!lowercaseRegex.test(password)) {
                                                                hintMessage += "Password should contain at least one lowercase letter. ";
                                                            }

                                                            if (!uppercaseRegex.test(password)) {
                                                                hintMessage += "Password should contain at least one uppercase letter. ";
                                                            }

                                                            if (!digitRegex.test(password)) {
                                                                hintMessage += "Password should contain at least one digit. ";
                                                            }

                                                            if (!specialCharRegex.test(password)) {
                                                                hintMessage += "Password should contain at least one special character. ";
                                                            }

                                                            passwordHint.textContent = hintMessage;
                                                        }
    </script>
    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/pages-register.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:40:28 GMT -->
</html>