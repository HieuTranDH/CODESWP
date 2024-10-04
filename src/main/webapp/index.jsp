<%@include file="include/header.jsp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<section>
    <style>.card {
            background-color: transparent !important;
            box-shadow: none; /* Xóa b? bóng n?u không mu?n */
        }</style>

    <!---movie-ticket-book-->

    <div class="filter-search-box">
        <div class="filters-box">
            <div class="all-filters filters">
                Now Showing<i class="fa fa-angle-down"></i>
            </div> 
        </div>
    </div>
    <!----filter-search-box---->
    <div class="movie-card-section">
        <c:forEach var="movie" items="${movies}">

            <div class="card">
                <img style="object-fit: contain" src="${movie.poster}">

                <div class="card-content">
                    <p class="movie-name">
                        <a href="${pageContext.request.contextPath}/detail?movieId=${movie.movieId}" style="text-decoration: none;    color: inherit;
                           ">${movie.title}</a>
                    </p>

                    <div class="movie-info">
                        <p class="time">Movie Genre: ${movie.genre}</p>
                        <p class="time"><i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>${movie.duration} min</span></i> </p>
                        <p class="time">
                            <i class="fa fa-clock-o">&nbsp;&nbsp;&nbsp;
                                <c:choose>
                                    <c:when test="${movie.status == 'Active'}">
                                        <span style="color: green;">Now Showing</span>
                                    </c:when>
                                    <c:when test="${movie.status == 'Comingsoon'}">
                                        <span style="color: orange;">Coming Soon</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>${movie.status}</span> <!-- N?u không ph?i là 'Active' ho?c 'Comingsoon' thì hi?n th? tr?ng thái g?c -->
                                    </c:otherwise>
                                </c:choose>
                            </i>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <!---movie-card--->
    <div class="show">

        <div class="show-bar">
            <div class="bar"></div>
        </div>
        <button>Show more</button>
    </div>



</section>
<%@include file="include/footer.jsp" %>
