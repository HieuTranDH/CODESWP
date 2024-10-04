/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.Movie;
import model.Showtime;


public class MovieShowtime {

    private Movie movie;
    private Showtime showtime;

    public MovieShowtime(Movie movie, Showtime showtime) {
        this.movie = movie;
        this.showtime = showtime;
    }

    // Getters và setters
    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }
}
