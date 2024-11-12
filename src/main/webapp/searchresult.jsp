<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.DAO.*" %>
<%@ page import="model.*" %>
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
<style>
    .container-1 {
        position: absolute;
        top: 120px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 50px;
        font-weight: bold; /* Thay vì font-style: bold */
        color: white;
    }
</style>
<header style="height: 260px">
    <link rel="stylesheet" href="static/css/index.css">
    <%@include file="/include/nav.jsp" %>




</header>
<p class="container-1">Search Results for "<%= request.getParameter("query") %>"</p>
<section>
    <style>
        /* Đảm bảo thân trang có nền mượt mà và màu sắc dễ nhìn */
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
        }

        /* Header */
        header {
            background: url('/path/to/header-image.jpg') no-repeat center center;
            background-size: cover;
            height: 260px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container-1 {
            text-align: center;
            font-size: 40px;
            font-weight: bold;
            color: white;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
            margin: 20px auto; /* Thêm khoảng cách phía dưới */
            max-width: 80%;
        }

        /* Movie List Section */
        .movie-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 20px auto;
            padding: 20px;
            max-width: 1200px;
        }

        .card {
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            width: 300px;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card img {
            width: 100%;
            height: 450px;
            object-fit: cover;
        }

        .card-content {
            padding: 15px;
        }

        .movie-name a {
            font-size: 22px;
            font-weight: bold;
            text-decoration: none;
            color: #333;
            transition: color 0.3s ease;
        }

        .movie-name a:hover {
            color: #007bff;
        }

        .movie-info {
            margin-top: 10px;
            font-size: 16px;
        }

        .movie-info p {
            margin: 5px 0;
        }

        .movie-info i {
            color: #555;
        }

        /* Movie status colors */
        span[style="color: green;"] {
            font-weight: bold;
        }

        span[style="color: orange;"] {
            font-weight: bold;
        }

        /* Not Found Section */
        .not-found {
            text-align: center;
            font-size: 24px;
            color: #ff4d4d;
            padding: 50px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .card {
                width: 100%;
            }

            .container-1 {
                font-size: 30px;
            }
        }

        @media (max-width: 576px) {
            .container-1 {
                font-size: 24px;
            }

            .movie-info {
                font-size: 14px;
            }
        }

    </style>

    <!-- Movie List Section -->
    <div class="movie-list">
        <c:choose>
            <c:when test="${empty movies}">
                <div class="not-found">No movies found</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="movie" items="${movies}">
                    <div class="card">
                        <a href="${pageContext.request.contextPath}/detail?movieId=${movie.movieId}">
                            <img style="object-fit: contain" src="${movie.poster}">
                        </a>

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
                                                <span>${movie.status}</span> <!-- Nếu không phải là 'Active' ho?c 'Comingsoon' thì hi?n th? tr?ng thái g?c -->
                                            </c:otherwise>
                                        </c:choose>
                                    </i>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@include file="include/footer.jsp" %>
