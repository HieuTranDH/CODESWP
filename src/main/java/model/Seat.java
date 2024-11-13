package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Seat {

    private int seatId;
    private String seatNumber;
    private String seatType;
    private String seatStatus;
    private BigDecimal seatPrice;
    private String roomName;
    private Timestamp startTime;
    private Timestamp endTime;
    private String movieTitle;
    private String cinemaName;
    private String cinemaAddress;

    // Constructor, getters và setters
    public Seat(int seatId, String seatNumber, String seatType, BigDecimal seatPrice) {
        this.seatId = seatId;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.seatPrice = seatPrice;
    }

    public Seat(int seatId, String seatNumber, String seatType, String seatStatus, BigDecimal seatPrice,
            String roomName, Timestamp startTime, Timestamp endTime, String movieTitle,
            String cinemaName, String cinemaAddress) {
        this.seatId = seatId;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.seatStatus = seatStatus;
        this.seatPrice = seatPrice;
        this.roomName = roomName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.movieTitle = movieTitle;
        this.cinemaName = cinemaName;
        this.cinemaAddress = cinemaAddress;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public String getSeatStatus() {
        return seatStatus;
    }

    public void setSeatStatus(String seatStatus) {
        this.seatStatus = seatStatus;
    }

    public BigDecimal getSeatPrice() {
        return seatPrice;
    }

    public void setSeatPrice(BigDecimal seatPrice) {
        this.seatPrice = seatPrice;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public String getCinemaAddress() {
        return cinemaAddress;
    }

    public void setCinemaAddress(String cinemaAddress) {
        this.cinemaAddress = cinemaAddress;
    }

    @Override
    public String toString() {
        return "Seat{" + "seatId=" + seatId + ", seatNumber=" + seatNumber + ", seatType=" + seatType + ", seatStatus=" + seatStatus + ", seatPrice=" + seatPrice + ", roomName=" + roomName + ", startTime=" + startTime + ", endTime=" + endTime + ", movieTitle=" + movieTitle + ", cinemaName=" + cinemaName + ", cinemaAddress=" + cinemaAddress + '}';
    }

}
