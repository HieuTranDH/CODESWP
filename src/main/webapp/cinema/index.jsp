<%@include file="header_cinema.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section>

    <!---movie-ticket-book-->
    <style>

        .movie-card-section1 {
            background: #111;
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
            background-color: red; 
            color: white; 
        }
        .date-selector button:hover {
            background-color: blue;
            color: white;
        }

        .movie-details {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .movie-poster img {
            width: 150px;
            height: 150px;
            border-radius: 8px;
        }

        .movie-info {
            flex-grow: 1;
            padding-left: 20px;
        }

        .movie-info h1 {
            margin: 0;
            font-size: 30px;
            color: #FFC0CB;
            font-weight: bold;
        }

        .rating {
            background-color: #ffcc00;
            padding: 2px 10px;
            font-size: 18px;
            border-radius: 4px;
        }

        .duration {
            margin-left: 15px;
            color: #ff9900;
            font-size: 15px;
        }

        .movie-info p {
            color: white;
            margin: 10px 0;
        }

        .movie-info ul {
            list-style: none;
            padding: 0;
        }

        .movie-info ul li {
            margin: 5px 0;
            color: white;
        }

        .movie-rating {
            font-size: 24px;
            color: #fff;
            background-color: #ff8800;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-left: 20px;
        }

        .cinema-showtime {
            margin-top: 20px;
        }

        .cinema-showtime h2, .cinema-showtime h3 {
            margin-bottom: 10px;
            font-size: 20px;
            color: white;
        }

        .showtime-selector {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-bottom: 10px;
        }

        .showtime-selector .showtime {
            padding: 10px 15px;
            font-size: 16px;
            background-color: green;
            border-radius: 4px;
            color: white;
        }

        .showtime span {
            display: block;
        }

        .buy-ticket {
            background-color: #ff6600;
            color: white;
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        #noShowtimeNotification {
            color: white;
            font-weight: bold;
        }

        .showtimes {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            margin-top: -17px;
        }

    </style>

    <div class="filter-search-box">
        <div class="filters-box">
            <div class="all-filters filters">
                Booking History
                <i class="fa fa-angle-down"></i>
            </div> 
        </div>
    </div>

    <div class="movie-card-section1">
        <div class="movie-container">
            <div class="date-selector" id="dateSelector"></div>
            <div class="cinema-movie" id="cinemaMovie">
                <c:forEach var="movie" items="${currentlyShowingMovies}">
                    <div style="margin-bottom: 40px">
                        <div class="movie-details" data-title="${movie.title}">
                            <!-- Thông tin phim -->
                            <div class="movie-poster">
                                <img src="${movie.poster}" alt="${movie.title} Poster">
                            </div>

                            <div class="movie-info">
                                <h1>${movie.title}</h1>
                                <span class="rating">G</span> 
                                <span class="duration">${movie.duration} phút</span>
                                <p>${movie.description}</p>
                                <ul style="display: block;">
                                    <li><strong>Release Date:</strong> ${movie.releaseDate}</li>
                                    <li><strong>Genre:</strong> ${movie.genre}</li>
                                </ul>
                            </div>

                            <div class="movie-rating">
                                <span class="rating-circle">${movie.averageRating}</span>
                            </div>
                        </div>
                        <div class="cinema-showtimes">
                            <c:forEach var="cinema" items="${cinemas}">
                                <h2 style="color: white;">${cinema.name}</h2> 
                                <div class="showtimes">
                                    <c:forEach var="screeningRoom" items="${cinema.screeningRooms}">
                                        <c:forEach var="showtime" items="${screeningRoom.showtimes}">
                                            <c:if test="${showtime.movie.movieId == movie.movieId}"> 
                                                <div class="cinema-showtime" data-showtime="${showtime.startTime}">
                                                    <div class="showtime-selector">
                                                        <div class="showtime">
                                                            <a href="<c:choose>
                                                                   <c:when test="${not empty USER}">
                                                                       buyticket?showtimeId=${showtime.showtimeId}
                                                                   </c:when>
                                                                   <c:otherwise>
                                                                       login?value=login
                                                                   </c:otherwise>
                                                               </c:choose>" style="color: inherit;text-decoration: none;">
                                                                <span>${showtime.startTime}</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const dateSelector = document.getElementById('dateSelector');
            const cinemaMovieContainer = document.getElementById('cinemaMovie');

            const today = new Date();
            console.log("Ngày hiện tại (GMT +7): ", today.toLocaleDateString('vi-VN'));

            function formatDate(date) {
                const options = {weekday: 'long', year: 'numeric', month: 'numeric', day: 'numeric'};
                return date.toLocaleDateString('vi-VN', options);
            }

            // Hàm tạo định dạng ngày 'YYYY-MM-DD' tránh sử dụng toISOString() do ảnh hưởng của UTC
            function formatDateToInputValue(date) {
                return date.getFullYear() + '-' + String(date.getMonth() + 1).padStart(2, '0') + '-' + String(date.getDate()).padStart(2, '0');
            }

            for (let i = 0; i < 7; i++) {
                const currentDate = new Date(today);
                currentDate.setDate(today.getDate() + i);

                const button = document.createElement('button');
                button.textContent = formatDate(currentDate);
                button.dataset.date = formatDateToInputValue(currentDate); // Không dùng toISOString()

                if (i === 0) {
                    button.classList.add('selected');
                    filterShowtimesByDate(formatDateToInputValue(currentDate));
                }

                button.addEventListener('click', function () {
                    const selectedDate = this.dataset.date; // Không chuyển đổi thành Date object
                    console.log("Ngày đã chọn (GMT +7): ", selectedDate);
                    filterShowtimesByDate(selectedDate);

                    const buttons = document.querySelectorAll('.date-selector button');
                    buttons.forEach(btn => btn.classList.remove('selected'));

                    this.classList.add('selected');
                });

                dateSelector.appendChild(button);
            }

            function filterShowtimesByDate(selectedDate) {
                const movieDetails = document.querySelectorAll('.movie-details');
                let hasShowtime = false;

                movieDetails.forEach(movie => {
                    const cinemaShowtimes = movie.nextElementSibling; // Lấy phần tử chứa suất chiếu
                    const showtimes = cinemaShowtimes.querySelectorAll('.cinema-showtime');
                    let movieHasShowtime = false;

                    showtimes.forEach(showtime => {
                        if (showtime.dataset.showtime.startsWith(selectedDate)) {
                            showtime.style.display = 'block';
                            movieHasShowtime = true; // Có suất chiếu cho bộ phim này
                            hasShowtime = true; // Có ít nhất một suất chiếu cho ngày đã chọn
                        } else {
                            showtime.style.display = 'none';
                        }
                    });

                    if (movieHasShowtime) {
                        movie.style.display = 'flex'; // Hiển thị thông tin phim
                        cinemaShowtimes.style.display = 'block'; // Hiển thị phần suất chiếu
                    } else {
                        movie.style.display = 'none'; // Ẩn thông tin phim
                        cinemaShowtimes.style.display = 'none'; // Ẩn phần suất chiếu
                    }
                });

                const noShowtimeNotification = document.getElementById('noShowtimeNotification');
                if (!hasShowtime) {
                    if (!noShowtimeNotification) {
                        const notification = document.createElement('div');
                        notification.id = 'noShowtimeNotification';
                        notification.textContent = 'Không có suất chiếu nào cho ngày này.';
                        cinemaMovieContainer.appendChild(notification);
                    }
                } else {
                    if (noShowtimeNotification) {
                        noShowtimeNotification.remove(); // Xóa thông báo nếu có suất chiếu
                    }
                }
            }
        });
    </script>

</section>

<%@include file="/include/footer.jsp" %>