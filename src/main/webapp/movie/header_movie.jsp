<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <link rel="stylesheet" href="static/css/index.css">

    <%@include file="/include/nav.jsp" %>

    <div class="popular-movie-slider">
        <img src="${movie.poster}" class="poster">
        <div class="popular-movie-slider-content">
            <p class="release">${movie.releaseDate}</p>
            <h2 class="movie-name">${movie.title}</h2>
            <ul class="category">
                <p>${movie.genre}</p>
            </ul>
            <p class="desc">${movie.description}</p>

            <div class="movie-info">
                <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>${movie.duration} min.</span></i> 
                <i class="fa fa-volume-up"> &nbsp;&nbsp;&nbsp;<span>Subtitles</span></i>
                <i class="fa fa-circle"> &nbsp;&nbsp;&nbsp;<span>Rate <b>${movie.averageRating}</b></span></i>
            </div>

            <div class="movie-btns">
                <!-- Nút Watch Trailer sẽ dẫn tới YouTube -->
                <a href="https://www.youtube.com/watch?v=xWgd2czwMG0" target="_blank" style="text-decoration: none;">
                    <button><i class="fa fa-play"></i> &nbsp; Watch trailer</button>
                </a>
                <button class="read-more"><i class="fa fa-circle"></i> <i class="fa fa-circle"></i> <i class="fa fa-circle"></i>&nbsp; Read more</button>
            </div>
        </div>
    </div>
</header>
