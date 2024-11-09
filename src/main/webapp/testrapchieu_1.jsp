<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .movie-container {
                width: 70%;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .date-selector {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
            }

            .date-selector button {
                background-color: #f4f4f4;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
            }

            .movie-details {
                display: flex;
                align-items: flex-start;
                margin-bottom: 20px;
            }

            .movie-poster img {
                width: 150px;
                height: auto;
                border-radius: 8px;
            }

            .movie-info {
                flex-grow: 1;
                padding-left: 20px;
            }

            .movie-info h1 {
                margin: 0;
                font-size: 24px;
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
                font-size: 18px;
            }

            .movie-info p {
                color: #555;
                margin: 10px 0;
            }

            .movie-info ul {
                list-style: none;
                padding: 0;
                color: #555;
            }

            .movie-info ul li {
                margin: 5px 0;
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

            .rating-circle {
                font-size: 18px;
            }

            .cinema-showtime {
                margin-top: 20px;
            }

            .cinema-showtime h2 {
                margin-bottom: 10px;
                font-size: 20px;
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
                background-color: #f4f4f4;
                border-radius: 4px;
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

        </style>
    </head>
    <body>
        <div class="movie-container">
            <div class="date-selector">
                <button>May 7, 2022</button>
                <button>May 8, 2022</button>
                <button>May 9, 2022</button>
                <button>May 10, 2022</button>
                <button>May 11, 2022</button>
            </div>

            <div class="movie-details">
                <div class="movie-poster">
                    <img src="https://via.placeholder.com/150" alt="Movie Poster">
                </div>

                <div class="movie-info">
                    <h1>The Hurricane Heist</h1>
                    <span class="rating">G</span>
                    <span class="duration">01 hours 30 minutes</span>
                    <p>
                        Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium...
                    </p>
                    <ul>
                        <li><strong>Language:</strong> English</li>
                        <li><strong>Release Date:</strong> April 29, 2022</li>
                        <li><strong>Genre:</strong> Comic, Magic</li>
                        <li><strong>Actor:</strong> Alexander Cattly, Greta Garbo, Humpay Richard</li>
                        <li><strong>Director:</strong> Gally Peckin, Mae West</li>
                    </ul>
                </div>

                <div class="movie-rating">
                    <span class="rating-circle">7.8</span>
                </div>
            </div>

            <!-- Cinema A showtimes -->
            <div class="cinema-showtime">
                <h2>Cinema A</h2>
                <div class="showtime-selector">
                    <div class="showtime">
                        <span>08h00</span>
                    </div>
                    <div class="showtime">
                        <span>12h30</span>
                    </div>
                    <div class="showtime">
                        <span>14h30</span>
                    </div>
                    <div class="showtime">
                        <span>17h50</span>
                    </div>
                    <div class="showtime">
                        <span>22h10</span>
                    </div>
                    <button class="buy-ticket">Buy Ticket</button>
                </div>
            </div>

            <!-- Cinema B showtimes -->
            <div class="cinema-showtime">
                <h2>Cinema B</h2>
                <div class="showtime-selector">
                    <div class="showtime">
                        <span>08h00</span>
                    </div>
                    <div class="showtime">
                        <span>12h30</span>
                    </div>
                    <div class="showtime">
                        <span>14h30</span>
                    </div>
                    <div class="showtime">
                        <span>17h50</span>
                    </div>
                    <div class="showtime">
                        <span>22h10</span>
                    </div>
                    <button class="buy-ticket">Buy Ticket</button>
                </div>
            </div>

            <!-- Add more cinemas if needed in a similar manner -->
        </div>
    </body>
</html>
