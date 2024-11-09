<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <body>

        <header>
            <%@include file="nav.jsp" %>
            <div class="popular-movie-slider">
                <img src="${topRatedMovie.poster}" class="poster" style="object-fit: contain">
                <div class="popular-movie-slider-content">
                    <p class="release">${topRatedMovie.releaseDate}</p>
                    <h2 class="movie-name">${topRatedMovie.title}</h2>
                    <ul class="category">
                        <p>${topRatedMovie.genre}</p>
                    </ul>
                    <p class="desc">${topRatedMovie.description}</p>

                    <div class="movie-info">
                        <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>${topRatedMovie.duration} min.</span></i> 
                        <i class="fa fa-volume-up"> &nbsp;&nbsp;&nbsp;<span>Subtitles</span></i>
                        <i class="fa fa-circle"> &nbsp;&nbsp;&nbsp;<span>Average <b>${topRatedMovie.averageRating}</b></span></i>
                    </div>

                    <div class="movie-btns">
                        <!-- Modify button to trigger modal -->
                        <button data-toggle="modal" data-target="#trailerModal"><i class="fa fa-play"></i> &nbsp; Watch trailer</button>
                        <button class="read-more"><i class="fa fa-circle"></i> <i class="fa fa-circle"></i> <i class="fa fa-circle"></i>&nbsp; Read more</button>
                    </div>
                </div>
            </div>

            <!-- Modal for YouTube video -->
            <div class="modal fade" id="trailerModal" tabindex="-1" role="dialog" aria-labelledby="trailerModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="trailerModalLabel">Watch Trailer</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <iframe id="trailerVideo" width="100%" height="315" src="" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <script>
            // Replace with your actual YouTube video URL
            const youtubeVideoUrl = "https://www.youtube.com/watch?v=xWgd2czwMG0";

            // Load the video into the iframe when the modal opens
            $('#trailerModal').on('show.bs.modal', function (event) {
                const modal = $(this);
                modal.find('#trailerVideo').attr('src', youtubeVideoUrl);
            });

            // Stop the video when the modal is closed
            $('#trailerModal').on('hidden.bs.modal', function (event) {
                const modal = $(this);
                modal.find('#trailerVideo').attr('src', '');
            });
        </script>

    </body>
</html>
