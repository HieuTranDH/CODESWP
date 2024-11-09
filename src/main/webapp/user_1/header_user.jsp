<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<header>
    <link rel="stylesheet" href="static/css/index.css">
    <%@include file="/include/nav.jsp" %>

    <div class="popular-movie-slider">
        <img src="${USER.avatar}" class="poster" alt="User Avatar" id="avatarImg" style="cursor: pointer;" data-toggle="modal" data-target="#uploadAvatarModal">

        <!-- Modal Upload Avatar -->
        <div id="uploadAvatarModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="uploadAvatarModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="uploadAvatarModalLabel">Thay đổi Avatar</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="uploadAvatarForm" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="updateAvatar">
                            <div class="form-group">
                                <label for="avatar">Chọn ảnh avatar:</label>
                                <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" required>
                            </div>
                            <img id="previewImg" src="" alt="Preview" style="display: none; max-width: 100%; margin-top: 10px;">
                            <button type="submit" class="btn btn-primary">Tải lên</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="popular-movie-slider-content">
            <p class="release">Hồ sơ</p>
            <h2 class="movie-name">${USER.name}</h2>
            <p class="release">Ngày tham gia: ${USER.registrationDate}</p>
            <ul class="category">
                <li>Điểm thưởng: ${USER.loyaltyPoints}<br></li>
                <li>Địa chỉ: ${USER.location}<br></li>
                <li>Ngày sinh: ${USER.birthdate}<br></li>
            </ul>
            <p class="desc">FCM (FPT Cinema Movie) là một trang web rạp chiếu phim trực tuyến, nơi người dùng có thể tìm kiếm, đặt vé và thưởng thức những bộ phim mới nhất.</p>
            <div class="movie-info">
                <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>Hoạt động cuối: 2 ngày trước</span></i> 
                <i class="fa fa-envelope"> &nbsp;&nbsp;&nbsp;<span>Email: <b>${USER.email}</b></span></i>
            </div>

            <div class="movie-btns">
                <button id="editProfileBtn" class="btn btn-primary"><i class="fa fa-user"></i> &nbsp; Chỉnh sửa hồ sơ</button>

                <!-- Modal Chỉnh sửa hồ sơ -->
                <div id="editProfileModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="editProfileModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editProfileModalLabel">Chỉnh sửa hồ sơ</h5>
                            </div>
                            <div class="modal-body">
                                <form id="editProfileForm" action="${pageContext.request.contextPath}/profile" method="post">
                                    <input type="hidden" name="action" value="updateProfile">
                                    <div class="form-group">
                                        <label for="name">Họ và tên:</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${USER.name}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email:</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${USER.email}" disabled>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Số điện thoại:</label>
                                        <input type="text" class="form-control" id="phone" name="phone" value="${USER.phoneNumber}">
                                    </div>
                                    <div class="form-group">
                                        <label for="location">Địa chỉ:</label>
                                        <input type="text" class="form-control" id="location" name="location" value="${USER.location}">
                                    </div>
                                    <div class="form-group">
                                        <label for="birthdate">Ngày sinh: 
                                            <c:if test="${not empty USER.birthdate}">${USER.birthdate}</c:if>
                                            </label>

                                        <c:choose>
                                            <c:when test="${not empty USER.birthdate}">
                                                <!-- Hiện thị ngày sinh đã có và không cho phép chỉnh sửa -->
                                                <input type="text" class="form-control" id="birthdate" name="birthdate" 
                                                       value="${USER.birthdate}" readonly />
                                                <!-- Gửi giá trị ngày sinh đã có khi form được submit -->
                                                <input type="hidden" name="existingBirthdate" value="${USER.birthdate}" />
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Cho phép nhập ngày sinh mới -->
                                                <input type="date" class="form-control" id="birthdate" name="birthdate" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <button id="editPasswordBtn" class="btn btn-primary" data-toggle="modal" data-target="#changePasswordModal">
                    <i class="fa fa-user"></i> &nbsp; Đổi mật khẩu
                </button>                
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
                                <form id="changePasswordForm" method="post" action="${pageContext.request.contextPath}/profile" onsubmit="return validateForm()">
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
                <button class="read-more"><i class="fa fa-circle"></i> <i class="fa fa-circle"></i> <i class="fa fa-circle"></i>&nbsp; Xem yêu thích</button>
            </div>
        </div>
    </div>
    <div id="toast" class="toast" style="position: absolute; top: 20px; right: 20px; z-index: 1050;">
        <div class="toast-header">
            <strong class="mr-auto">Thông báo</strong>
            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="toast-body">
            <span id="toastMessage"></span>
        </div>
    </div>

    <style>
        .modal-content {
            background-color: #0B0B0B; /* Màu đen obsidian */
            color: white; /* Đổi màu chữ thành trắng */
        }
    </style>

    <script>
        $(document).ready(function () {
            // Khi người dùng nhấn nút chỉnh sửa hồ sơ
            $('#editProfileBtn').on('click', function () {
                $('#editProfileModal').modal('show');
            });

            // Khi người dùng chọn file, hiển thị ảnh xem trước
            $('#avatar').on('change', function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        $('#previewImg').attr('src', e.target.result).show(); // Cập nhật src và hiển thị ảnh
                    }
                    reader.readAsDataURL(file);
                } else {
                    $('#previewImg').hide(); // Ẩn ảnh xem trước nếu không có file
                }
            });
        });




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

</header>