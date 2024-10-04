<!doctype html>
<html lang="en">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/dashboards-commerce.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:40:24 GMT -->
    <%@include file="head.jsp" %>
    <body>
        <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar">
            <%@include file="header.jsp" %> 
            <div class="ui-theme-settings">
                <button type="button" id="TooltipDemo" class="btn-open-options btn btn-warning">
                    <i class="fa fa-cog fa-w-16 fa-spin fa-2x"></i>
                </button>
                <div class="theme-settings__inner">
                    <div class="scrollbar-container">
                        <div class="theme-settings__options-wrapper">
                            <h3 class="themeoptions-heading">Layout Options</h3>
                            <div class="p-3">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-header">
                                                        <div class="switch-animate switch-on">
                                                            <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Header</div>
                                                    <div class="widget-subheading">Makes the header top fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-sidebar">
                                                        <div class="switch-animate switch-on">
                                                            <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Sidebar</div>
                                                    <div class="widget-subheading">Makes the sidebar left fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-footer">
                                                        <div class="switch-animate switch-off">
                                                            <input type="checkbox" data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Footer</div>
                                                    <div class="widget-subheading">Makes the app footer bottom fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div> Header Options </div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto btn btn-focus btn-sm switch-header-cs-class" data-class>
                                    Restore Default
                                </button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <h5 class="pb-2">Choose Color Scheme</h5>
                                        <div class="theme-settings-swatches">
                                            <div class="swatch-holder bg-primary switch-header-cs-class" data-class="bg-primary header-text-light"></div>
                                            <div class="swatch-holder bg-secondary switch-header-cs-class" data-class="bg-secondary header-text-light"></div>
                                            <div class="swatch-holder bg-success switch-header-cs-class" data-class="bg-success header-text-light"></div>
                                            <div class="swatch-holder bg-info switch-header-cs-class" data-class="bg-info header-text-light"></div>
                                            <div class="swatch-holder bg-warning switch-header-cs-class" data-class="bg-warning header-text-dark"></div>
                                            <div class="swatch-holder bg-danger switch-header-cs-class" data-class="bg-danger header-text-light"></div>
                                            <div class="swatch-holder bg-light switch-header-cs-class" data-class="bg-light header-text-dark"></div>
                                            <div class="swatch-holder bg-dark switch-header-cs-class" data-class="bg-dark header-text-light"></div>
                                            <div class="swatch-holder bg-focus switch-header-cs-class" data-class="bg-focus header-text-light"></div>
                                            <div class="swatch-holder bg-alternate switch-header-cs-class" data-class="bg-alternate header-text-light"></div>
                                            <div class="divider"></div>
                                            <div class="swatch-holder bg-vicious-stance switch-header-cs-class" data-class="bg-vicious-stance header-text-light"></div>
                                            <div class="swatch-holder bg-midnight-bloom switch-header-cs-class" data-class="bg-midnight-bloom header-text-light"></div>
                                            <div class="swatch-holder bg-night-sky switch-header-cs-class" data-class="bg-night-sky header-text-light"></div>
                                            <div class="swatch-holder bg-slick-carbon switch-header-cs-class" data-class="bg-slick-carbon header-text-light"></div>
                                            <div class="swatch-holder bg-asteroid switch-header-cs-class" data-class="bg-asteroid header-text-light"></div>
                                            <div class="swatch-holder bg-royal switch-header-cs-class" data-class="bg-royal header-text-light"></div>
                                            <div class="swatch-holder bg-warm-flame switch-header-cs-class" data-class="bg-warm-flame header-text-dark"></div>
                                            <div class="swatch-holder bg-night-fade switch-header-cs-class" data-class="bg-night-fade header-text-dark"></div>
                                            <div class="swatch-holder bg-sunny-morning switch-header-cs-class" data-class="bg-sunny-morning header-text-dark"></div>
                                            <div class="swatch-holder bg-tempting-azure switch-header-cs-class" data-class="bg-tempting-azure header-text-dark"></div>
                                            <div class="swatch-holder bg-amy-crisp switch-header-cs-class" data-class="bg-amy-crisp header-text-dark"></div>
                                            <div class="swatch-holder bg-heavy-rain switch-header-cs-class" data-class="bg-heavy-rain header-text-dark"></div>
                                            <div class="swatch-holder bg-mean-fruit switch-header-cs-class" data-class="bg-mean-fruit header-text-dark"></div>
                                            <div class="swatch-holder bg-malibu-beach switch-header-cs-class" data-class="bg-malibu-beach header-text-light"></div>
                                            <div class="swatch-holder bg-deep-blue switch-header-cs-class" data-class="bg-deep-blue header-text-dark"></div>
                                            <div class="swatch-holder bg-ripe-malin switch-header-cs-class" data-class="bg-ripe-malin header-text-light"></div>
                                            <div class="swatch-holder bg-arielle-smile switch-header-cs-class" data-class="bg-arielle-smile header-text-light"></div>
                                            <div class="swatch-holder bg-plum-plate switch-header-cs-class" data-class="bg-plum-plate header-text-light"></div>
                                            <div class="swatch-holder bg-happy-fisher switch-header-cs-class" data-class="bg-happy-fisher header-text-dark"></div>
                                            <div class="swatch-holder bg-happy-itmeo switch-header-cs-class" data-class="bg-happy-itmeo header-text-light"></div>
                                            <div class="swatch-holder bg-mixed-hopes switch-header-cs-class" data-class="bg-mixed-hopes header-text-light"></div>
                                            <div class="swatch-holder bg-strong-bliss switch-header-cs-class" data-class="bg-strong-bliss header-text-light"></div>
                                            <div class="swatch-holder bg-grow-early switch-header-cs-class" data-class="bg-grow-early header-text-light"></div>
                                            <div class="swatch-holder bg-love-kiss switch-header-cs-class" data-class="bg-love-kiss header-text-light"></div>
                                            <div class="swatch-holder bg-premium-dark switch-header-cs-class" data-class="bg-premium-dark header-text-light"></div>
                                            <div class="swatch-holder bg-happy-green switch-header-cs-class" data-class="bg-happy-green header-text-light"></div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div>Sidebar Options</div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto btn btn-focus btn-sm switch-sidebar-cs-class" data-class>
                                    Restore Default
                                </button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">

                                    <li class="list-group-item">
                                        <h5 class="pb-2">Choose Color Scheme</h5>
                                        <div class="theme-settings-swatches">
                                            <div class="swatch-holder bg-primary switch-sidebar-cs-class" data-class="bg-primary sidebar-text-light"></div>
                                            <div class="swatch-holder bg-secondary switch-sidebar-cs-class" data-class="bg-secondary sidebar-text-light"></div>
                                            <div class="swatch-holder bg-success switch-sidebar-cs-class" data-class="bg-success sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-info switch-sidebar-cs-class" data-class="bg-info sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-warning switch-sidebar-cs-class" data-class="bg-warning sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-danger switch-sidebar-cs-class" data-class="bg-danger sidebar-text-light"></div>
                                            <div class="swatch-holder bg-light switch-sidebar-cs-class" data-class="bg-light sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-dark switch-sidebar-cs-class" data-class="bg-dark sidebar-text-light"></div>
                                            <div class="swatch-holder bg-focus switch-sidebar-cs-class" data-class="bg-focus sidebar-text-light"></div>
                                            <div class="swatch-holder bg-alternate switch-sidebar-cs-class" data-class="bg-alternate sidebar-text-light"></div>
                                            <div class="divider"></div>
                                            <div class="swatch-holder bg-vicious-stance switch-sidebar-cs-class" data-class="bg-vicious-stance sidebar-text-light"></div>
                                            <div class="swatch-holder bg-midnight-bloom switch-sidebar-cs-class" data-class="bg-midnight-bloom sidebar-text-light"></div>
                                            <div class="swatch-holder bg-night-sky switch-sidebar-cs-class" data-class="bg-night-sky sidebar-text-light"></div>
                                            <div class="swatch-holder bg-slick-carbon switch-sidebar-cs-class" data-class="bg-slick-carbon sidebar-text-light"></div>
                                            <div class="swatch-holder bg-asteroid switch-sidebar-cs-class" data-class="bg-asteroid sidebar-text-light"></div>
                                            <div class="swatch-holder bg-royal switch-sidebar-cs-class" data-class="bg-royal sidebar-text-light"></div>
                                            <div class="swatch-holder bg-warm-flame switch-sidebar-cs-class" data-class="bg-warm-flame sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-night-fade switch-sidebar-cs-class" data-class="bg-night-fade sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-sunny-morning switch-sidebar-cs-class" data-class="bg-sunny-morning sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-tempting-azure switch-sidebar-cs-class" data-class="bg-tempting-azure sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-amy-crisp switch-sidebar-cs-class" data-class="bg-amy-crisp sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-heavy-rain switch-sidebar-cs-class" data-class="bg-heavy-rain sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-mean-fruit switch-sidebar-cs-class" data-class="bg-mean-fruit sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-malibu-beach switch-sidebar-cs-class" data-class="bg-malibu-beach sidebar-text-light"></div>
                                            <div class="swatch-holder bg-deep-blue switch-sidebar-cs-class" data-class="bg-deep-blue sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-ripe-malin switch-sidebar-cs-class" data-class="bg-ripe-malin sidebar-text-light"></div>
                                            <div class="swatch-holder bg-arielle-smile switch-sidebar-cs-class" data-class="bg-arielle-smile sidebar-text-light"></div>
                                            <div class="swatch-holder bg-plum-plate switch-sidebar-cs-class" data-class="bg-plum-plate sidebar-text-light"></div>
                                            <div class="swatch-holder bg-happy-fisher switch-sidebar-cs-class" data-class="bg-happy-fisher sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-happy-itmeo switch-sidebar-cs-class" data-class="bg-happy-itmeo sidebar-text-light"></div>
                                            <div class="swatch-holder bg-mixed-hopes switch-sidebar-cs-class" data-class="bg-mixed-hopes sidebar-text-light"></div>
                                            <div class="swatch-holder bg-strong-bliss switch-sidebar-cs-class" data-class="bg-strong-bliss sidebar-text-light"></div>
                                            <div class="swatch-holder bg-grow-early switch-sidebar-cs-class" data-class="bg-grow-early sidebar-text-light"></div>
                                            <div class="swatch-holder bg-love-kiss switch-sidebar-cs-class" data-class="bg-love-kiss sidebar-text-light"></div>
                                            <div class="swatch-holder bg-premium-dark switch-sidebar-cs-class" data-class="bg-premium-dark sidebar-text-light"></div>
                                            <div class="swatch-holder bg-happy-green switch-sidebar-cs-class" data-class="bg-happy-green sidebar-text-light"></div>
                                        </div>
                                    </li>


                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div>Main Content Options</div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto active btn btn-focus btn-sm">Restore Default</button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">

                                    <li class="list-group-item">
                                        <h5 class="pb-2">Page Section Tabs</h5>
                                        <div class="theme-settings-swatches">
                                            <div role="group" class="mt-2 btn-group">
                                                <button type="button" class="btn-wide btn-shadow btn-primary btn btn-secondary switch-theme-class" data-class="body-tabs-line"> Line</button>
                                                <button type="button" class="btn-wide btn-shadow btn-primary active btn btn-secondary switch-theme-class" data-class="body-tabs-shadow"> Shadow </button>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <h5 class="pb-2">Light Color Schemes
                                        </h5>
                                        <div class="theme-settings-swatches">
                                            <div role="group" class="mt-2 btn-group">
                                                <button type="button" class="btn-wide btn-shadow btn-primary active btn btn-secondary switch-theme-class" data-class="app-theme-white"> White Theme</button>
                                                <button type="button" class="btn-wide btn-shadow btn-primary btn btn-secondary switch-theme-class" data-class="app-theme-gray"> Gray Theme</button>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
            <div class="app-main">
                <div class="app-sidebar sidebar-shadow">
                    <div class="app-header__logo">
                        <div class="logo-src"></div>
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
                    </div> 
                    <div class="scrollbar-sidebar">
                        <%@include file="menu_slide.jsp" %>
                    </div>
                </div><div class="app-main__outer">
                    <div class="app-main__inner">
                        <div class="app-page-title">
                            <div class="page-title-wrapper">
                                <div class="page-title-heading">
                                    <div class="page-title-icon">
                                        <i class="fas fa-users icon-gradient bg-ripe-malin"></i>
                                    </div>
                                    <div>Staff management
                                        <div class="page-title-subheading">This dashboard was manage staff.</div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        </ul>
                        <div class="tabs-animation">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-header">Staff Users
                                            <div class="btn-actions-pane-right">
                                                <div role="group" class="btn-group-sm btn-group">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">#</th>
                                                        <th>Name</th>
                                                        <th class="text-center">Phone</th>
                                                        <th class="text-center">Cinema</th>
                                                        <th class="text-center">Hire date</th>
                                                        <th class="text-center">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="staff" items="${staffList}" varStatus="status">
                                                        <tr>
                                                            <td class="text-center text-muted">#${status.index + 1}</td>
                                                            <td>
                                                                <div class="widget-content p-0">
                                                                    <div class="widget-content-wrapper">
                                                                        <div class="widget-content-left mr-3">
                                                                            <div class="widget-content-left">
                                                                                <img width="40" class="rounded-circle" src="assets/images/avatars/1.jpg" alt>
                                                                            </div>
                                                                        </div>
                                                                        <div class="widget-content-left flex2">
                                                                            <div class="widget-heading">${staff.name}</div>
                                                                            <div class="widget-subheading opacity-7">${staff.role}</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="text-center">${staff.phoneNumber}</td>
                                                            <td class="text-center">${staff.cinema.name}</td>
                                                            <td class="text-center">${staff.hireDate}</td>
                                                            <td class="text-center">
                                                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#updateStaffModal${staff.staffId}" onclick="setStaffId(${staff.staffId})">Update</button>   
                                                            </td>


                                                        </tr>
                                                    <div class="modal fade" id="updateStaffModal${staff.staffId}" tabindex="-1" role="dialog" aria-labelledby="updateStaffLabel${staff.staffId}" aria-hidden="true">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="updateStaffLabel${staff.staffId}">Update Staff Information</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <form action="${pageContext.request.contextPath}/staff/registerStaffAcount?action=updateProfile" method="post">
                                                                        <input type="hidden" name="staffId" value="${staff.staffId}">

                                                                        <!-- Email (cannot be changed) -->
                                                                        <div class="form-group">
                                                                            <label for="staffEmail${staff.staffId}">Email</label>
                                                                            <input type="email" class="form-control" id="staffEmail${staff.staffId}" name="staffEmail" value="${staff.email}" readonly>
                                                                        </div>

                                                                        <!-- Dropdown for Cinema -->
                                                                        <div class="form-group">
                                                                            <label for="cinemaId${staff.staffId}">Cinema</label>
                                                                            <select class="form-control" id="cinemaId${staff.staffId}" name="cinemaId" required>
                                                                                <c:forEach var="cinema" items="${cinemaList}">
                                                                                    <option value="${cinema.cinemaId}" <c:if test="${cinema.cinemaId == staff.cinemaId}">selected</c:if>>${cinema.name}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>

                                                                        <!-- Phone number (cannot be changed) -->
                                                                        <div class="form-group">
                                                                            <label for="staffPhone${staff.staffId}">Phone Number</label>
                                                                            <input type="phone" class="form-control" id="staffPhone${staff.staffId}" name="staffPhone" value="${staff.phoneNumber}" >
                                                                        </div>

                                                                        <!-- Role -->
                                                                        <div class="form-group">
                                                                            <label for="role${staff.staffId}">Role</label>
                                                                            <input type="text" class="form-control" id="role${staff.staffId}" name="role" value="${staff.role}" readonly>
                                                                            <button type="button" class="btn btn-danger mt-2" id="cancelStaff${staff.staffId}" onclick="cancelStaff(${staff.staffId})">Cancel Staff</button>
                                                                        </div>

                                                                        <!-- Submit Button -->
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            <button type="submit" class="btn btn-primary">Save changes</button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </c:forEach>

                                                </tbody>

                                            </table>
                                        </div>
                                        <div class="d-block text-center card-footer">

                                            <button class="btn-wide btn btn-success">Save</button>
                                            <!-- Button to trigger the modal -->
                                            <button class="btn-wide btn btn-success" data-toggle="modal" data-target="#registerStaffModal">Register Staff</button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%@include file="footer.jsp" %>
                </div>
            </div>
        </div>
        <div class="modal fade" id="registerStaffModal" tabindex="-1" role="dialog" aria-labelledby="registerStaffLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registerStaffLabel">Register Staff</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="${pageContext.request.contextPath}/staff/registerStaffAcount?action=register"  method="post" onsubmit="return validateForm();">
                            <div class="form-group">
                                <label for="staffName">Staff Name</label>
                                <input type="text" class="form-control" id="staffName" name="staffName" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for="staffEmail">Email address</label>
                                <input type="email" class="form-control" id="staffEmail" name="staffEmail" placeholder="Enter email" oninput="showEmailHint()" required>
                                <small id="emailHint" class="form-text text-muted"></small>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password" oninput="showPasswordHint()" required>
                                <small id="passwordHint" class="form-text text-muted"></small>
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="rePassword" placeholder="Confirm password" required>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Register</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>


                            // Check if the message variable is set or not
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


                            function validateForm() {
                                return validateEmail() && validatePassword();
                            }

                            function validateEmail() {
                                var email = document.getElementById("staffEmail").value; // Kh?p v?i ID trong form
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
                                var email = document.getElementById("staffEmail").value; // Kh?p v?i ID trong form
                                var emailHint = document.getElementById("emailHint");
                                var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;

                                if (!emailRegex.test(email)) {
                                    emailHint.textContent = "Email must end with @gmail.com.";
                                } else {
                                    emailHint.textContent = "";
                                }
                            }

                            function validatePassword() {
                                var password = document.getElementById("password").value; // Kh?p v?i ID trong form
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
                                var password = document.getElementById("password").value; // Kh?p v?i ID trong form
                                var passwordHint = document.getElementById("passwordHint");
                                var lowercaseRegex = /[a-z]/;
                                var uppercaseRegex = /[A-Z]/;
                                var digitRegex = /\d/;
                                var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

                                var hintMessage = "";

                                if (!lowercaseRegex.test(password)) {
                                    hintMessage += "Password should contain at least one lowercase letter. <br>";
                                }

                                if (!uppercaseRegex.test(password)) {
                                    hintMessage += "Password should contain at least one uppercase letter. <br>";
                                }

                                if (!digitRegex.test(password)) {
                                    hintMessage += "Password should contain at least one digit. <br>";
                                }

                                if (!specialCharRegex.test(password)) {
                                    hintMessage += "Password should contain at least one special character. <br>";
                                }

                                passwordHint.innerHTML = hintMessage;
                            }
                            function setStaffId(staffId) {
                                $("#updateStaffModal" + staffId).prependTo("body");
                            }
        </script>


        <%@include file="draw_wrapper.jsp" %>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


    </body>
</html>