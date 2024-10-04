<!doctype html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/dashboards-commerce.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:40:24 GMT -->
    <%@include file="head.jsp" %>
    <body>
        <style>

            .movie-card-section1 {

                padding: 20px 100px;
                display: flex;
                flex-direction: column;
                gap: 18px;
                padding-top: 50px;
                min-height: 100vh;
                box-sizing: border-box;
            }

            .movie-container {
                width: 100%;
                margin: 0 auto;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .date-selector {
                display: flex;
                justify-content: space-around;
                margin-bottom: 40px;
            }

            .date-selector button {
                background-color: #D3D3D3;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 10px;
                transition: background-color 0.3s, color 0.3s;
            }


            .date-selector button.selected {
                background-color: red; /* Đổi màu nền thành đỏ */
                color: white; /* Đổi màu chữ thành trắng (tùy chọn) */
            }
            .date-selector button:hover {
                background-color: blue;
                color: white;
            }


        </style>
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
                                        <i class="pe-7s-graph icon-gradient bg-ripe-malin"></i>
                                    </div>
                                    <div>Show time dashboard
                                        <div class="page-title-subheading">This dashboard was created as an example of the flexibility that Architect offers.</div>
                                    </div>
                                </div>
                                <div class="page-title-actions">
                                    <button type="button" data-toggle="tooltip" title="Example Tooltip" data-placement="bottom" class="btn-shadow mr-3 btn btn-dark">
                                        <i class="fa fa-star"></i>
                                    </button>
                                    <div class="d-inline-block dropdown">
                                        <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn-shadow dropdown-toggle btn btn-info">
                                            <span class="btn-icon-wrapper pr-2 opacity-7">
                                                <i class="fa fa-business-time fa-w-20"></i>
                                            </span>
                                            Buttons
                                        </button>
                                        <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right">
                                            <ul class="nav flex-column">
                                                <li class="nav-item">
                                                    <a class="nav-link">
                                                        <i class="nav-link-icon lnr-inbox"></i>
                                                        <span> Inbox</span>
                                                        <div class="ml-auto badge badge-pill badge-secondary">86</div>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span> Book</span>
                                                        <div class="ml-auto badge badge-pill badge-danger">5</div>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link">
                                                        <i class="nav-link-icon lnr-picture"></i>
                                                        <span> Picture</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a disabled class="nav-link disabled">
                                                        <i class="nav-link-icon lnr-file-empty"></i>
                                                        <span> File Disabled</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                </div> 

                            </div>

                        </div>

                        <div class="movie-card-section1">
                            <div class="movie-container">
                                <div class="date-selector" id="dateSelector"></div> <!-- Nút chọn ngày -->
                                <div class="cinema-room" id="cinemaRoom">
                                    <c:forEach var="room" items="${screeningRoomList}">
                                        <div class="cinema-showtimes" id="room-${room.roomId}">
                                            <h2>${room.roomName}</h2>
                                            <div class="showtimes">
                                                <ul class="showtime-list" data-room-id="${room.roomId}">
                                                    <c:forEach var="showTime" items="${room.showtimes}">
                                                        <li class="showtime-item" data-date="${showTime.startTime}">
                                                            Phim: ${showTime.movie.title} - ${showTime.movie.duration} phút<br>
                                                            Giờ bắt đầu: ${showTime.startTime}<br>
                                                            Giờ kết thúc: ${showTime.endTime}<br>
                                                            <button class="btn btn-warning mb-3" data-toggle="modal" data-target="#updateShowtimeModal-${showTime.showtimeId}" onclick="setShowtime(${showTime.showtimeId})">
                                                                Cập Nhật
                                                            </button>
                                                        </li>
                                                        <!-- Modal cập nhật suất chiếu -->
                                                        <div class="modal fade" id="updateShowtimeModal-${showTime.showtimeId}" tabindex="-1" role="dialog" aria-labelledby="updateShowtimeModalLabel-${showTime.showtimeId}" aria-hidden="true">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="updateShowtimeModalLabel-${showTime.showtimeId}">Cập Nhật Suất Chiếu</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form id="updateShowtimeForm-${showTime.showtimeId}" method="post" action="${pageContext.request.contextPath}/staff/showTimeManagement?action=updateShowtime">
                                                                            <div class="form-group">
                                                                                <label for="movieSelect-${showTime.showtimeId}">Chọn phim:</label>
                                                                                <select class="form-control" id="movieSelect-${showTime.showtimeId}" name="movieId" onchange="updateDurationAndEndTime(${room.roomId})">
                                                                                    <c:forEach var="movie" items="${movieList}">
                                                                                        <option value="${movie.movieId}" data-duration="${movie.duration}" <c:if test="${movie.movieId == showTime.movie.movieId}">selected</c:if>>
                                                                                            ${movie.title} - ${movie.duration} phút
                                                                                        </option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="startTime-${showTime.showtimeId}">Thời gian bắt đầu: </label>
                                                                                <!-- Giá trị giờ bắt đầu đã có trước đó sẽ được hiện -->
                                                                                <input type="time" class="form-control" id="startTime-${showTime.showtimeId}" name="startTime" value="${showTime.startTime}" onchange="calculateEndTime(${room.roomId}, ${showTime.movie.duration})" required>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="endTime-${showTime.showtimeId}">Thời gian kết thúc:</label>
                                                                                <!-- Giá trị giờ kết thúc đã có trước đó sẽ được hiện -->
                                                                                <input type="time" class="form-control" id="endTime-${showTime.showtimeId}" name="endTime" value="${showTime.endTime}">
                                                                            </div>
                                                                            <input type="hidden" name="showtimeId" value="${showTime.showtimeId}">
                                                                            <input type="hidden" name="roomId" value="${room.roomId}">
                                                                            <input type="hidden" name="selectedDate" id="hiddenSelectedDate-${showTime.showtimeId}">
                                                                            <button type="submit" class="btn btn-primary">Cập Nhật suất chiếu</button>
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                                        </form>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </ul>
                                            </div>

                                            <button class="btn btn-primary mb-3 add-showtime-button" data-toggle="modal" data-target="#addShowtimeModal-${room.roomId}" onclick="setRoomId(${room.roomId})">
                                                Thêm suất chiếu
                                            </button>
                                        </div>

                                        <!-- Modal thêm suất chiếu -->
                                        <div class="modal fade" id="addShowtimeModal-${room.roomId}" tabindex="-1" role="dialog" aria-labelledby="addShowtimeModalLabel-${room.roomId}" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="addShowtimeModalLabel-${room.roomId}">Thêm Suất Chiếu</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form id="addShowtimeForm-${room.roomId}" method="post" action="${pageContext.request.contextPath}/staff/showTimeManagement?action=createShowtime">
                                                            <div class="form-group">
                                                                <label for="movieSelect-${room.roomId}">Chọn phim:</label>
                                                                <select id="movieSelect-${room.roomId}" class="form-control" onchange="updateDurationAndEndTime(${room.roomId})" name="movieId">
                                                                    <c:forEach var="movie" items="${movieList}" >
                                                                        <option  value="${movie.movieId}" data-duration="${movie.duration}">
                                                                            ${movie.title} - ${movie.duration} phút
                                                                        </option>

                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="startTime-${room.roomId}">Thời gian bắt đầu:</label>
                                                                <input type="time" class="form-control" id="startTime-${room.roomId}" name="startTime" onchange="calculateEndTime(${room.roomId},${movie.duration})" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="endTime-${room.roomId}">Thời gian kết thúc:</label>
                                                                <input type="time" class="form-control" id="endTime-${room.roomId}" name="endTime" >
                                                            </div>
                                                            <input type="hidden" name="roomId" value="${room.roomId}">

                                                            <!-- Input ẩn để lưu ngày đã chọn -->
                                                            <input type="hidden" name="selectedDate" id="hiddenSelectedDate-${room.roomId}">
                                                            <div class="form-row">
                                                                <button type="submit" class="btn btn-primary">Thêm suất chiếu</button>
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                            </div>
                                                        </form>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>


                        <%@include file="footer.jsp" %>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <script>
                                                                    document.addEventListener('DOMContentLoaded', function () {
                                                                        const dateSelector = document.getElementById('dateSelector');
                                                                        const cinemaRoomContainer = document.getElementById('cinemaRoom');
                                                                        let selectedDate = null; // Variable to store the selected date

                                                                        // Function to set roomId when opening the add showtime modal
                                                                        window.setRoomId = function (roomId) {
                                                                            $("#addShowtimeModal-" + roomId).prependTo("body");

                                                                            // Set the selected date in the hidden input of the add showtime form
                                                                            if (selectedDate) {
                                                                                document.getElementById(`hiddenSelectedDate-` + roomId).value = selectedDate;
                                                                                console.log("Selected date for adding showtime:", selectedDate); // Log the selected date
                                                                            } else {
                                                                                alert("Please select a date before adding a showtime.");
                                                                            }
                                                                        };

                                                                        // Function to set showtimeId when opening the update showtime modal
                                                                        window.setShowtime = function (showtimeId) {
                                                                            $("#updateShowtimeModal-" + showtimeId).prependTo("body");

                                                                            // Set the selected date in the hidden input of the update showtime form
                                                                            if (selectedDate) {
                                                                                document.getElementById(`hiddenSelectedDate-` + showtimeId).value = selectedDate;
                                                                                console.log("Selected date for updating showtime:", selectedDate); // Log the selected date
                                                                            } else {
                                                                                alert("Please select a date before updating a showtime.");
                                                                            }
                                                                        };

                                                                        // Calculate end time based on selected start time and movie duration
                                                                        window.calculateEndTime = function (roomId, duration) {
                                                                            const startTimeInput = document.getElementById(`startTime-` + roomId);
                                                                            const endTimeInput = document.getElementById(`endTime-` + roomId);

                                                                            if (startTimeInput.value) {
                                                                                const startTime = startTimeInput.value.split(':'); // Split hours and minutes

                                                                                // Validate start time
                                                                                if (startTime.length !== 2 || isNaN(startTime[0]) || isNaN(startTime[1])) {
                                                                                    console.error("Start time format is incorrect: ", startTimeInput.value);
                                                                                    return; // Do not calculate if the format is wrong
                                                                                }

                                                                                const startDate = new Date();
                                                                                startDate.setHours(startTime[0], startTime[1], 0);

                                                                                // Calculate end time
                                                                                const endDate = new Date(startDate.getTime() + duration * 60000); // duration in minutes

                                                                                // Set end time in HH:mm format
                                                                                const endHours = endDate.getHours().toString().padStart(2, '0');
                                                                                const endMinutes = endDate.getMinutes().toString().padStart(2, '0');
                                                                                endTimeInput.value = endHours + `:` + endMinutes; // Set value in valid format

                                                                                // Optional: Log the calculated values
                                                                                console.log("Calculated end time:", endTimeInput.value);
                                                                            } else {
                                                                                // Handle case where start time is not provided
                                                                                console.warn("Start time input is empty.");
                                                                                endTimeInput.value = ''; // Reset to an empty value instead of invalid time
                                                                            }
                                                                        };

                                                                        // Format date for display
                                                                        function formatDate(date) {
                                                                            const options = {weekday: 'long', year: 'numeric', month: 'numeric', day: 'numeric'};
                                                                            return date.toLocaleDateString('vi-VN', options);
                                                                        }

                                                                        // Create date selection buttons for the next 7 days
                                                                        const today = new Date();
                                                                        const daysToShow = 7;

                                                                        for (let i = 0; i <= daysToShow; i++) {
                                                                            const currentDate = new Date(today);
                                                                            currentDate.setDate(today.getDate() + i);

                                                                            const button = document.createElement('button');
                                                                            button.textContent = formatDate(currentDate);
                                                                            button.dataset.date = currentDate.toISOString().split('T')[0]; // Store date as yyyy-mm-dd

                                                                            if (i === 0) {
                                                                                button.classList.add('selected');
                                                                                selectedDate = button.dataset.date; // Set the first button as the default selected date
                                                                            }

                                                                            button.addEventListener('click', function () {
                                                                                // Unselect previous button and select the current one
                                                                                dateSelector.querySelectorAll('button').forEach(btn => btn.classList.remove('selected'));
                                                                                this.classList.add('selected');

                                                                                // Update the selected date
                                                                                selectedDate = this.dataset.date;
                                                                                console.log("Selected date: ", selectedDate);

                                                                                // Call function to filter showtimes by selected date
                                                                                filterShowtimesBySelectedDate(selectedDate);
                                                                            });

                                                                            dateSelector.appendChild(button);
                                                                        }

                                                                        if (selectedDate) {
                                                                            filterShowtimesBySelectedDate(selectedDate);
                                                                        }

                                                                        // Function to filter showtimes based on the selected date
                                                                        function filterShowtimesBySelectedDate(selectedDate) {
                                                                            const rooms = cinemaRoomContainer.querySelectorAll('.showtime-list');

                                                                            rooms.forEach(room => {
                                                                                const showtimeItems = room.querySelectorAll('.showtime-item');

                                                                                showtimeItems.forEach(item => {
                                                                                    const showtimeDate = item.dataset.date.split(" ")[0]; // Extract the date part

                                                                                    if (showtimeDate === selectedDate) {
                                                                                        item.style.display = 'block'; // Show if the date matches
                                                                                    } else {
                                                                                        item.style.display = 'none'; // Hide if the date does not match
                                                                                    }
                                                                                });
                                                                            });
                                                                        }

                                                                        // Update end time when a movie is selected
                                                                        window.updateDurationAndEndTime = function (roomId) {
                                                                            const movieSelect = document.getElementById(`movieSelect-` + roomId);
                                                                            const selectedOption = movieSelect.options[movieSelect.selectedIndex];
                                                                            const duration = parseInt(selectedOption.getAttribute('data-duration'));

                                                                            // Reset end time
                                                                            const endTimeInput = document.getElementById(`endTime-` + roomId);
                                                                            endTimeInput.value = ''; // Reset before calculating a new one

                                                                            // Call function to calculate end time if a start time is already selected
                                                                            const startTimeInput = document.getElementById(`startTime-` + roomId);
                                                                            if (startTimeInput.value) {
                                                                                calculateEndTime(roomId, duration); // Call with duration
                                                                            }

                                                                            // Update the hidden input for the selected movie ID
                                                                            const hiddenMovieIdInput = document.getElementById(`selectedMovieId-` + roomId);
                                                                            hiddenMovieIdInput.value = selectedOption.value; // Set the selected movieId
                                                                        };

                                                                        // Assign events to inputs and selects in each room
                                                                        cinemaRoomContainer.querySelectorAll('.showtime-list').forEach(room => {
                                                                            const roomId = room.dataset.roomId; // Get roomId from data attribute

                                                                            const startTimeInput = document.getElementById(`startTime-` + roomId);
                                                                            const movieSelect = document.getElementById(`movieSelect-` + roomId);

                                                                            startTimeInput.addEventListener('change', function () {
                                                                                const selectedOption = movieSelect.options[movieSelect.selectedIndex];
                                                                                const duration = parseInt(selectedOption.getAttribute('data-duration'));
                                                                                calculateEndTime(roomId, duration); // Call with duration
                                                                            });

                                                                            movieSelect.addEventListener('change', function () {
                                                                                updateDurationAndEndTime(roomId);
                                                                            });
                                                                        });
                                                                    });
            </script>


            <%@include file="draw_wrapper.jsp" %>
</html>