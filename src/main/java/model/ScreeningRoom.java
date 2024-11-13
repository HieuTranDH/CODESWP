package model;

import java.util.ArrayList;
import java.util.List;

public class ScreeningRoom {

    private int roomId;
    private int cinemaId;
    private String roomName;
    private int seatCapacity;
    private List<Showtime> showtimes = new ArrayList<>(); // List of showtimes
    private List<Seat> seats = new ArrayList<>(); // List of seats

    // Default constructor
    public ScreeningRoom() {
    }

    // Constructor with parameters
    public ScreeningRoom(int roomId, String roomName, int seatCapacity) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.seatCapacity = seatCapacity;
    }

    public ScreeningRoom(int roomId, int cinemaId, String roomName, int seatCapacity) {
        this.roomId = roomId;
        this.cinemaId = cinemaId;
        this.roomName = roomName;
        this.seatCapacity = seatCapacity;
    }

    // Method to add a showtime to the screening room
    public void addShowtime(Showtime showtime) {
        showtimes.add(showtime);
    }

    // Method to get a showtime by ID
    public Showtime getShowtimeById(int showtimeId) {
        return showtimes.stream()
                .filter(showtime -> showtime.getShowtimeId() == showtimeId)
                .findFirst()
                .orElse(null);
    }

    // Method to add a seat to screening room
    public void addSeat(Seat seat) {
        seats.add(seat);
    }

    // Method to get a seat by its ID
    public Seat getSeatById(int seatId) {
        return seats.stream()
                .filter(seat -> seat.getSeatId() == seatId)
                .findFirst()
                .orElse(null);
    }

    // Getter and Setter
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getSeatCapacity() {
        return seatCapacity;
    }

    public void setSeatCapacity(int seatCapacity) {
        this.seatCapacity = seatCapacity;
    }

    // Getter for showtimes
    public List<Showtime> getShowtimes() {
        return showtimes;
    }

    // Getter for seats
    public List<Seat> getSeats() {
        return seats;
    }

    @Override
    public String toString() {
        return "ScreeningRoom{" + "roomId=" + roomId + ", cinemaId=" + cinemaId + ", roomName=" + roomName + ", seatCapacity=" + seatCapacity + '}';
    }
    
    
}
