

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                    <i class="fas fa-film icon-gradient bg-ripe-malin"></i>
                                </div>
                                <div>Movie Dashboard
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
                            </div> </div>
                    </div>
                    <div class="tabs-animation">

                        <div class="text-center mb-3">
                            <h5 class="menu-header-title text-capitalize mb-3 fsize-3">Movie</h5>
                            <div role="group" class="mb-3 btn-group-lg btn-group">
                                <button type="button" class="btn-shadow active btn btn-primary">Hour</button>
                                <button type="button" class="btn-shadow  btn btn-primary">Day</button>
                                <button type="button" class="btn-shadow  btn btn-primary">Week</button>
                                <button type="button" class="btn-shadow  btn btn-primary">Month</button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#createMovieModal">
                            Tạo Phim Mới
                        </button>

                        <!-- Hiển thị danh sách phim -->
                        <div class="row">
                            <c:forEach var="movie" items="${movieList}">
                                <div class="col-sm-12 col-lg-6 col-xl-3" ">
                                    <div class="mb-3 profile-responsive card" style="min-height: 700px">
                                        <div class="poster-wrapper position-relative">
                                            <!-- Sử dụng img-fluid để hình ảnh điều chỉnh tự động -->
                                            <img src="${pageContext.request.contextPath}/${movie.poster}" alt="${movie.title}" style="width: 100%; min-height: 400px;object-fit: contain;">
                                            <!-- Nút update ở góc phải trên cùng -->
                                            <button class="btn btn-warning position-absolute" style="top: 10px; right: 10px;" 
                                                    data-toggle="modal" data-target="#updateMovieModal-${movie.movieId}" onclick="setMovieId(${movie.movieId})">Update</button>
                                        </div>
                                        <div class="p-3">

                                            <h5 class="menu-header-title">${movie.title}</h5>
                                            <h6 class="menu-header-subtitle">Thời gian: ${movie.duration} phút</h6>
                                            <h6 class="menu-header-subtitle">Thể loại: ${movie.genre}</h6>
                                            <h6 class="menu-header-subtitle">Trạng thái: ${movie.status}</h6>
                                            <!-- Hiển thị ngày phát hành -->
                                            <h6 class="menu-header-subtitle">Ngày ra mắt: ${movie.releaseDate}</h6>
                                            <h6 class="menu-header-subtitle">Mô tả: ${movie.description}</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="updateMovieModal-${movie.movieId}" tabindex="-1" aria-labelledby="updateMovieModalLabel-${movie.movieId}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="updateMovieModalLabel-${movie.movieId}">Cập nhật thông tin phim</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="${pageContext.request.contextPath}/staff/movieManagement?action=update" method= "post" enctype="multipart/form-data">
                                                    <input type="hidden" name="movieId" value="${movie.movieId}">
                                                    <div class="form-group">
                                                        <label for="movieTitle-${movie.movieId}">Tên phim</label>
                                                        <input type="text" class="form-control" id="movieTitle-${movie.movieId}" name="title" value="${movie.title}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="movieDuration-${movie.movieId}">Thời gian (phút)</label>
                                                        <input type="number" class="form-control" id="movieDuration-${movie.movieId}" name="duration" value="${movie.duration}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="movieGenre-${movie.movieId}">Thể loại</label>
                                                        <input type="text" class="form-control" id="movieGenre-${movie.movieId}" name="genre" value="${movie.genre}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="movieStatus-${movie.movieId}">Trạng thái</label>
                                                        <select class="form-control" id="movieStatus-${movie.movieId}" name="status" required>
                                                            <option value="Coming soon" ${movie.status == 'Coming soon' ? 'selected' : ''}>Coming soon</option>
                                                            <option value="Active" ${movie.status == 'Active' ? 'selected' : ''}>Active</option>
                                                            <option value="End" ${movie.status == 'End' ? 'selected' : ''}>Showtime expired</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="movieReleaseDate-${movie.movieId}">Ngày ra mắt</label>
                                                        <input type="date" class="form-control" id="movieReleaseDate-${movie.movieId}" name="releaseDate" value="${movie.releaseDate}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="movieDescription-${movie.movieId}">Mô tả</label>
                                                        <textarea class="form-control" id="movieDescription-${movie.movieId}" name="description" rows="3" required>${movie.description}</textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="moviePoster-${movie.movieId}">Chọn lại ảnh poster</label>
                                                        <input type="file" class="form-control-file" id="moviePoster-${movie.movieId}" name="poster">

                                                        <!-- Trường ẩn để giữ giá trị poster cũ -->
                                                        <input type="hidden" name="currentPoster" value="${movie.poster}">
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
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
    <div class="modal fade" id="createMovieModal" tabindex="-1" role="dialog" aria-labelledby="createMovieModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createMovieModalLabel">Tạo Phim Mới</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="createMovieForm" method="post" action="${pageContext.request.contextPath}/staff/movieManagement?action=createMovie" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="title">Tiêu đề:</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>

                        <div class="form-group">
                            <label for="duration">Thời gian:</label>
                            <input type="number" class="form-control" id="duration" name="duration" required>
                        </div>

                        <div class="form-group">
                            <label for="genre">Thể loại:</label>
                            <input type="text" class="form-control" id="genre" name="genre">
                        </div>

                        <div class="form-group">
                            <label for="releaseDate">Ngày phát hành:</label>
                            <input type="date" class="form-control" id="releaseDate" name="releaseDate" required>
                        </div>

                        <div class="form-group">
                            <label for="description">Mô tả:</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="poster">Ảnh bìa:</label>
                            <input type="file" class="form-control-file" id="poster" name="poster" required>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Tạo phim</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>     
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
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

                                                        function setMovieId(movieId) {
                                                            $("#updateMovieModal-" + movieId).prependTo("body");
                                                        }
    </script> 


    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <%@include file="draw_wrapper.jsp" %>