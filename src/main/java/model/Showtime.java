package model;

import java.time.LocalDateTime;

/**
 * Class representing a movie showtime.
 */
public class Showtime {

    private Movie movie;  // Reference to Movie object
    private int showtimeId;
    private String startTime; // Using LocalDateTime to represent date and time
    private String endTime;   // Using LocalDateTime to represent date and time
    private int roomId;
    private String roomName;
    private String cinemaName;
    private int movieId;
    private String movieTitle;

    public Showtime() {
    }

    // Constructor with Movie object
    public Showtime(int showtimeId, String startTime, String endTime) {
        this.showtimeId = showtimeId;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Showtime(int showtimeId, Movie movie, String startTime, String endTime, String roomName, String cinemaName) {
        this.showtimeId = showtimeId;
        this.movie = movie;  // Initialize Movie object
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
        this.cinemaName = cinemaName;
    }

    public Showtime(int showtimeId, int movieId, String movieTitle, String startTime, String endTime, String roomName) {
        this.showtimeId = showtimeId;
        this.movieId = movieId;
        this.movieTitle = movieTitle;
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
    }

    public Showtime(int showtimeId, int movieId, String movieTitle, String startTime, String endTime, String roomName, String cinemaName) {
        this.showtimeId = showtimeId;
        this.movieId = movieId;
        this.movieTitle = movieTitle;
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
        this.cinemaName = cinemaName;
    }

    public Showtime(Movie movie, int showtimeId, String startTime, String endTime, String roomName) {
        this.movie = movie;
        this.showtimeId = showtimeId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.roomName = roomName;
    }

    // Getters and Setters
    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public Movie getMovie() {  // Getter for Movie object
        return movie;
    }

    public void setMovie(Movie movie) {  // Setter for Movie object
        this.movie = movie;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Override
    public String toString() {
        return "Showtime{"
                + "showtimeId=" + showtimeId
                + ", movie=" + movie.getTitle()
                + // Display movie title
                ", startTime='" + startTime + '\''
                + ", endTime='" + endTime + '\''
                + ", roomName='" + roomName + '\''
                + ", cinemaName='" + cinemaName + '\''
                + '}';
    }
}
