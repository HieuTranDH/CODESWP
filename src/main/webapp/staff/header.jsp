<%-- 
    Document   : header
    Created on : Sep 24, 2024, 10:41:50 AM
    Author     : ThanhDuoc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.DAO.*" %>
<%@ page import="model.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="app-header header-shadow">
    <div class="app-header__logo">
        <div class="header__pane ml-auto">
            <div>
                <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
                </button>
            </div>
        </div>
    </div>
    <div class="app-header__mobile-menu">
        <div>
            <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                </span>
            </button>
        </div>
    </div>
    <div class="app-header__menu">
        <span>
            <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                <span class="btn-icon-wrapper">
                    <i class="fa fa-ellipsis-v fa-w-6"></i>
                </span>
            </button>
        </span>
    </div> <div class="app-header__content">
        <div class="app-header-left">
            <div class="search-wrapper">
                <div class="input-holder">
                    <input type="text" class="search-input" placeholder="Type to search">
                    <button class="search-icon"><span></span></button>
                </div>
                <button class="close"></button>
            </div>
        </div>
        <div style="font-size: 24px; font-weight: bold; color: black;">
            FCM Cinema
        </div>
        <div class="app-header-right">
            <div class="header-btn-lg pr-0">
                <div class="widget-content p-0">
                    <div class="widget-content-wrapper">
                        <div class="widget-content-left">
                            <div class="btn-group">
                                <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="p-0 btn">
                                    <img width="42" class="rounded-circle" src="assets/images/avatars/1.jpg" alt>
                                    <i class="fa fa-angle-down ml-2 opacity-8"></i>
                                </a>
                                <div tabindex="-1" role="menu" aria-hidden="true" class="rm-pointers dropdown-menu-lg dropdown-menu dropdown-menu-right">
                                    <div class="dropdown-menu-header">
                                        <div class="dropdown-menu-header-inner bg-info">
                                            <div class="menu-header-image opacity-2" style="background-image: url('assets/images/dropdown-header/city3.jpg');"></div>
                                            <div class="menu-header-content text-left">
                                                <div class="widget-content p-0">
                                                    <div class="widget-content-wrapper">
                                                        <div class="widget-content-left mr-3">
                                                            <img width="42" class="rounded-circle" src="assets/images/avatars/1.jpg" alt>
                                                        </div>
                                                        <div class="widget-content-left">
                                                            <c:choose>
                                                                <c:when test="${not empty Staff}">
                                                                    <div class="widget-heading">${Staff.name}</div>
                                                                    <div class="widget-subheading opacity-8">Staff</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="widget-heading">${Admin.name}</div>
                                                                    <div class="widget-subheading opacity-8">Admin</div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="widget-content-right mr-2">
                                                            <button  onclick="window.location.href = '${pageContext.request.contextPath}/logout';" class="btn-pill btn-shadow btn-shine btn btn-focus">Logout</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="scroll-area-xs" style="height: 30px;">
                                        <div class="scrollbar-container ps">
                                            <ul class="nav flex-column">
                                                <li class="nav-item-header nav-item">Activity</li>
                                                <li class="nav-item">
                                                    <a href="javascript:void(0);" class="nav-link">Chat
                                                        <div class="ml-auto badge badge-pill badge-info">8</div>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="javascript:void(0);" class="nav-link" data-toggle="modal" data-target="#changePasswordModal">Change Password</a>

                                                    <!-- Modal -->



                                                </li>
                                                <li class="nav-item-header nav-item">My Account
                                                </li>
                                                <li class="nav-item">
                                                    <a href="javascript:void(0);" class="nav-link">Settings
                                                        <div class="ml-auto badge badge-success">New</div>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="javascript:void(0);" class="nav-link">Messages
                                                        <div class="ml-auto badge badge-warning">512</div>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="javascript:void(0);" class="nav-link">Logs</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <ul class="nav flex-column">
                                        <li class="nav-item-divider mb-0 nav-item"></li>
                                    </ul>
                                    <div class="grid-menu grid-menu-2col">
                                        <div class="no-gutters row">
                                            <div class="col-sm-6">
                                                <button class="btn-icon-vertical btn-transition btn-transition-alt pt-2 pb-2 btn btn-outline-warning"
                                                        data-toggle="modal" data-target="#changePasswordModal">
                                                    <!-- Icon Font Awesome 'key' cho thay đổi mật khẩu -->
                                                    <i class="fa fa-key icon-gradient bg-amy-crisp btn-icon-wrapper mb-2"></i> Change Pass
                                                </button>
                                            </div>
                                            <div class="col-sm-6">
                                                <button class="btn-icon-vertical btn-transition btn-transition-alt pt-2 pb-2 btn btn-outline-danger">
                                                    <!-- Changed icon to Font Awesome 'info-circle' icon for viewing information -->
                                                    <i class="fa fa-info-circle icon-gradient bg-love-kiss btn-icon-wrapper mb-2"></i>
                                                    <b>View Information</b>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <ul class="nav flex-column">
                                        <li class="nav-item-divider nav-item">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="widget-content-left  ml-3 header-user-info">
                            <c:choose>
                                <c:when test="${not empty Staff}">
                                    <div class="widget-heading">${Staff.name}</div>
                                    <div class="widget-subheading opacity-8">Staff</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="widget-heading">${Admin.name}</div>
                                    <div class="widget-subheading opacity-8">Admin</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div> 
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">Đổi Mật Khẩu</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="passwordChangeMessage" class="mt-2"></div> <!-- Thông báo sẽ hiển thị ở đây -->
                <form id="changePasswordForm" method="post" action="${pageContext.request.contextPath}/staff/dashboard" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="form-group">
                        <label for="currentPassword">Mật khẩu hiện tại:</label>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">Mật khẩu mới:</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" oninput="showPasswordHint()" required>
                        <small id="passwordHint" class="form-text text-muted"></small>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function validateForm() {
        return validatePassword();
    }

    function validatePassword() {
        var newPassword = document.getElementById("newPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordHint = document.getElementById("passwordHint");

        var lowercaseRegex = /[a-z]/;
        var uppercaseRegex = /[A-Z]/;
        var digitRegex = /\d/;
        var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

        var isValid = true;
        var errorMessage = "";

        if (!lowercaseRegex.test(newPassword)) {
            isValid = false;
            errorMessage += "Mật khẩu phải có ít nhất một chữ thường.\n";
        }

        if (!uppercaseRegex.test(newPassword)) {
            isValid = false;
            errorMessage += "Mật khẩu phải có ít nhất một chữ hoa.\n";
        }

        if (!digitRegex.test(newPassword)) {
            isValid = false;
            errorMessage += "Mật khẩu phải có ít nhất một chữ số.\n";
        }

        if (!specialCharRegex.test(newPassword)) {
            isValid = false;
            errorMessage += "Mật khẩu phải có ít nhất một ký tự đặc biệt.\n";
        }

        if (newPassword !== confirmPassword) {
            isValid = false;
            errorMessage += "Mật khẩu xác nhận không khớp.\n";
        }

        if (!isValid) {
            alert(errorMessage);
        }

        return isValid;
    }

    function showPasswordHint() {
        var newPassword = document.getElementById("newPassword").value;
        var passwordHint = document.getElementById("passwordHint");

        var lowercaseRegex = /[a-z]/;
        var uppercaseRegex = /[A-Z]/;
        var digitRegex = /\d/;
        var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

        var hintMessage = "";

        if (!lowercaseRegex.test(newPassword)) {
            hintMessage += "Mật khẩu cần ít nhất một chữ thường.<br>";
        }

        if (!uppercaseRegex.test(newPassword)) {
            hintMessage += "Mật khẩu cần ít nhất một chữ hoa.<br>";
        }

        if (!digitRegex.test(newPassword)) {
            hintMessage += "Mật khẩu cần ít nhất một chữ số.<br>";
        }

        if (!specialCharRegex.test(newPassword)) {
            hintMessage += "Mật khẩu cần ít nhất một ký tự đặc biệt.<br>";
        }

        passwordHint.innerHTML = hintMessage;
    }

    document.addEventListener("DOMContentLoaded", function (event) {
        // Ensure your DOM is fully loaded before executing any code
        var msg = "${sessionScope.msg}";
        console.log("Message from session:", msg);
        // Ki?m tra n?u msg không r?ng, hi?n th? thông báo
        if (msg !== null && msg !== "") {
            swal({
                title: msg.includes("Success") ? "Success" : "Error",
                text: msg,
                icon: msg.includes("Success") ? "success" : "error",
                button: "OK!"
            });
            // Xóa msg sau khi hi?n th? ?? tránh hi?n th? l?i khi t?i l?i trang
    <% session.removeAttribute("msg"); %>
        }
    });

</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
