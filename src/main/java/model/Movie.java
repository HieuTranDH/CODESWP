
package model;

import java.util.ArrayList;
import java.util.List;


public class Movie {

    private int movieId;
    private String title;
    private int duration;
    private String genre;
    private String releaseDate;
    private String description;
    private String status;
    private String poster;
    private double averageRating;
    private String startTime;
    private List<MovieRating> ratings = new ArrayList<>(); // Khởi tạo danh sách

    // Constructor
    public Movie() {
    }

    public Movie(int movieId, String title, int duration, String genre, String releaseDate, String description, String status, String poster, double averageRating) {
        this.movieId = movieId;
        this.title = title;
        this.duration = duration;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.description = description;
        this.status = status;
        this.poster = poster;
        this.averageRating = averageRating;
    }

    public Movie(String title, int duration, String genre, String releaseDate, String description, String status, String poster,double averageRating) {
        this.title = title;
        this.duration = duration;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.description = description;
        this.status = status;
        this.poster = poster;
        this.averageRating = averageRating;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    // Getters and Setters
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    // Other getters and setters...
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setRatings(List<MovieRating> ratings) {
        this.ratings = ratings;
    }

    public List<MovieRating> getRatings() {
        return ratings;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

}
