<%@include file="include/header.jsp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<section>
    <style>.card {
            background-color: transparent !important;
            box-shadow: none; /* X�a b? b�ng n?u kh�ng mu?n */
        }
        .card:hover {
            transform: scale(1.05);
        }
    </style>


    <div class="filter-search-box">
        <div class="filters-box">
            <div class="all-filters filters" id="nowShowingFilter" onclick="filterMovies('nowShowing')">
                Now Showing <i class="fa fa-angle-down"></i>
            </div>
            <div class="all-filters filters" id="comingSoonFilter" onclick="filterMovies('comingSoon')">
                Coming Soon <i class="fa fa-angle-down"></i>
            </div>
        </div>
    </div>

    <div class="movie-card-section">
        <c:forEach var="movie" items="${movies}">
            <div class="card movie-item" data-status="${movie.status}">
                <a href="${pageContext.request.contextPath}/detail?movieId=${movie.movieId}">
                    <img style="object-fit: contain" src="${movie.poster}">
                </a>

                <div class="card-content">
                    <p class="movie-name">
                        <a href="${pageContext.request.contextPath}/detail?movieId=${movie.movieId}" style="text-decoration: none; color: inherit;">
                            ${movie.title}
                        </a>
                    </p>

                    <div class="movie-info">
                        <p class="time">Movie Genre: ${movie.genre}</p>
                        <p class="time">
                            <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>${movie.duration} min</span></i>
                        </p>
                        <p class="time">
                            <i class="fa fa-clock-o">&nbsp;&nbsp;&nbsp;
                                <c:choose>
                                    <c:when test="${movie.status == 'Active'}">
                                        <span style="color: green;">Now Showing</span>
                                    </c:when>
                                    <c:when test="${movie.status == 'Coming soon'}">
                                        <span style="color: orange;">Coming Soon</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>${movie.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </i>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <script>
        function filterMovies(status) {
            const movieItems = document.querySelectorAll('.movie-item');

            movieItems.forEach(movie => {
                const movieStatus = movie.getAttribute('data-status');
                if (status === 'nowShowing' && movieStatus === 'Active') {
                    movie.style.display = 'block'; // Hi?n th? phim ?ang chi?u
                } else if (status === 'comingSoon' && movieStatus === 'Coming soon') {
                    movie.style.display = 'block'; // Hi?n th? phim s?p chi?u
                } else {
                    movie.style.display = 'none'; // ?n phim kh�ng kh?p
                }
            });
        }
        document.addEventListener('DOMContentLoaded', () => {
            filterMovies('nowShowing');
        });
    </script>




</section>
<%@include file="include/footer.jsp" %>
