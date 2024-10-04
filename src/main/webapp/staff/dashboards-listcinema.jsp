<!doctype html>
<html lang="en">
    <%@ page import="model.DAO.*" %>
    <%@ page import="model.*" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/dashboards-commerce.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:40:24 GMT -->
    <%@include file="head.jsp" %>
    <body>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            // Check if the message variable is set or not
            document.addEventListener("DOMContentLoaded", (event) => {
                var errorMessage = "${message}";
                if (errorMessage != "") {
                    swal({
                        title: "Success!",
                        text: errorMessage,
                        icon: "success",
                        button: "OK!",
                    });
                }
            });
        </script>
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
                                        <i class="fas fa-film icon-gradient bg-ripe-malin"></i>
                                    </div>
                                    <div>Cinema management
                                        <div class="page-title-subheading">This dashboard was manage all Cinema.</div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        </ul>
                        <c:if test="${not empty message}">
                            <%
                                session.removeAttribute("message");
                            %>
                        </c:if>
                        <div class="tabs-animation">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-header">All Cinema
                                            <div class="btn-actions-pane-right">
                                                <div role="group" class="btn-group-sm btn-group">

                                                </div>
                                            </div>
                                        </div>
                                        <c:set var="cinemas" value="${Cinema_DB.getAllCinemas2()}" />
                                        <div class="table-responsive">
                                            <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">Name</th>
                                                        <th class="text-center">Address</th>
                                                        <th class="text-center">Phone Number</th>
                                                        <th class="text-center">Email</th>
                                                        <th class="text-center">Staff</th>
                                                        <th class="text-center">View Analytics</th>
                                                        <th class="text-center">Edit</th>
                                                        <th class="text-center">Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${empty cinemas}">
                                                            <tr>
                                                                <td colspan="7">There are no Cinemas.</td>
                                                            </tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="cinema" items="${cinemas}">
                                                                <c:set var="cinemaid" value="${cinema.cinemaId}" />
                                                                <c:set var="staff" value="${Cinema_DB.getStaffByCinemaID(cinemaid)}" />
                                                                <tr>
                                                                    <td class="text-center">${cinema.name}</td>
                                                                    <td class="text-center">${cinema.address}</td>
                                                                    <td class="text-center">${cinema.phoneNumber}</td>
                                                                    <td class="text-center">${cinema.email}</td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty staff}">
                                                                            <td class="text-center">${staff.name}</td>
                                                                            <td>
                                                                                <form action="${pageContext.request.contextPath}/staff/listcinema" method="post">
                                                                                    <input type="hidden" name="cinemaid" value="${cinemaid}">
                                                                                    <input type="hidden" name="action" value="analytic">
                                                                                    <button type="submit" class="btn rounded w-100 btn-primary">View Analytics</button>
                                                                                </form>

                                                                            </td>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <td class="text-center">Not Yet</td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/staff/registerStaffAcount" class="btn btn-secondary">Add Staff</a>
                                                                            </td>                                                                    </c:otherwise>
                                                                    </c:choose>

                                                                    <td>
                                                                        <input type="hidden" name="name" value="${cinema.cinemaId}">
                                                                        <button type="button" class="btn rounded w-100 btn-secondary" data-toggle="modal" data-target="#editCinema${cinema.cinemaId}">Edit</button>
                                                                    </td>
                                                                    <td>
                                                                        <input type="hidden" name="name" value="${cinema.cinemaId}">
                                                                        <button type="button" class="btn rounded w-100 btn-secondary" data-toggle="modal" data-target="#deleteCinema${cinema.cinemaId}">
                                                                            Delete
                                                                        </button>
                                                                    </td>


                                                                </tr>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>

                                            </table>
                                        </div>
                                        <div class="d-block text-center card-footer">

                                            <div class="d-flex justify-content-end mb-2">
                                                <button type="button" class="btn rounded btn-primary" data-toggle="modal" data-target="#addCinema">Add new Cinema</button>
                                            </div>
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

        <!--Add Cinema-->
        <div class="modal fade" id="addCinema" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add New Cinema</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form id="cinemaForm" action="${pageContext.request.contextPath}/staff/listcinema" method="post" onsubmit="return validateAddCinemaForm()">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="cinemaNameInput">Cinema Name:</label>
                                <input type="text" class="form-control mb-2 rounded" id="cinemaNameInput" name="cinemaName" required>
                            </div>
                            <div class="form-group">
                                <label for="cinemaAddressInput">Cinema Address:</label>
                                <input type="text" class="form-control mb-2 rounded" id="cinemaAddressInput" name="cinemaAddress" required>
                            </div>
                            <div class="form-group">
                                <label for="cinemaPhoneInput">Cinema Phone:</label>
                                <input type="text" class="form-control mb-2 rounded" id="cinemaPhoneInput" name="cinemaPhone" required>
                            </div>
                            <div class="form-group">
                                <label for="cinemaEmailInput">Cinema Email:</label>
                                <input type="email" class="form-control mb-2 rounded" id="cinemaEmailInput" name="cinemaEmail" required>
                            </div>
                            <input type="hidden" name="action" value="add">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn rounded w-100 btn-primary">Add New</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Loop modal to edit Cinema -->
        <c:forEach var="cinema" items="${cinemas}">
            <div class="modal fade" id="editCinema${cinema.cinemaId}" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Cinema #${cinema.cinemaId}</h5>
                            <button class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <form id="cinemaForm${cinema.cinemaId}" action="${pageContext.request.contextPath}/staff/listcinema" method="post" onsubmit="return validateEditForm(${cinema.cinemaId})">
                            <div class="modal-body">
                                <div class="form-group" hidden>
                                    <label for="cinemaIDInput${cinema.cinemaId}">Cinema ID:</label>
                                    <input type="number" class="form-control mb-2 rounded" id="cinemaIDInput${cinema.cinemaId}" name="cinemaID" value="${cinema.cinemaId}" required>
                                </div>
                                <div class="form-group">
                                    <label for="cinemaNameInput${cinema.cinemaId}">Cinema Name:</label>
                                    <input type="text" class="form-control mb-2 rounded" id="cinemaNameInput${cinema.cinemaId}" name="cinemaName" value="${cinema.name}" required>
                                </div>
                                <div class="form-group">
                                    <label for="cinemaAddressInput${cinema.cinemaId}">Cinema Address:</label>
                                    <input type="text" class="form-control mb-2 rounded" id="cinemaAddressInput${cinema.cinemaId}" name="cinemaAddress" value="${cinema.address}" required>
                                </div>
                                <div class="form-group">
                                    <label for="cinemaPhoneInput${cinema.cinemaId}">Cinema Phone:</label>
                                    <input type="text" class="form-control mb-2 rounded" id="cinemaPhoneInput${cinema.cinemaId}" name="cinemaPhone" value="${cinema.phoneNumber}" required>
                                </div>
                                <div class="form-group">
                                    <label for="cinemaEmailInput${cinema.cinemaId}">Cinema Email:</label>
                                    <input type="email" class="form-control mb-2 rounded" id="cinemaEmailInput${cinema.cinemaId}" name="cinemaEmail" value="${cinema.email}" required>
                                </div>
                                <input type="hidden" name="action" value="edit">
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn rounded w-100 btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>



        <!-- Loop modal to delete Promotion -->
        <c:forEach var="cinema" items="${cinemas}">
            <div class="modal fade" id="deleteCinema${cinema.cinemaId}" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form  action="${pageContext.request.contextPath}/staff/listcinema" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Delete Cinema #${cinema.cinemaId}</h5>
                                <button class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!-- Hidden inputs to specify the action and promotion ID -->
                                <input type="hidden" name="action" value="deletecinema">
                                <input type="hidden" name="cinemaId" value="${cinema.cinemaId}">

                                <div class="form-row">
                                    <p>Are you sure you want to delete the cinema "${cinema.name}"?</p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button class="btn rounded w-100 btn-danger" type="submit">Delete</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>

        <script>
            // Validate form before submission
            function validateAddCinemaForm() {
                // Get phone input and email input
                var phone = document.getElementById("cinemaPhoneInput").value;
                var email = document.getElementById("cinemaEmailInput").value;

                // Regular expression for phone number (10-15 digits)
                var phonePattern = /^[0-9]{10,15}$/;
                if (!phonePattern.test(phone)) {
                    alert("Please enter a valid phone number (10-15 digits).");
                    return false; // Prevent form submission
                }

                // Regular expression for validating email
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    alert("Please enter a valid email address.");
                    return false; // Prevent form submission
                }

                return true; // If all validations pass
            }

            function validateEditForm(cinemaId) {
                var phone = document.getElementById("cinemaPhoneInput" + cinemaId).value;
                var email = document.getElementById("cinemaEmailInput" + cinemaId).value;


                var phonePattern = /^[0-9]{10,15}$/;
                if (!phonePattern.test(phone)) {
                    alert("Please enter a valid phone number (10-15 digits).");
                    return false;
                }

                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    alert("Please enter a valid email address.");
                    return false;

                    return true;
                }

        </script>





        <%@include file="draw_wrapper.jsp" %>


    </body>
</html>