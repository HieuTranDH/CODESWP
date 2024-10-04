package model;

import java.util.ArrayList;
import java.util.List;

public class Ticket {

    private int ticketId;
    private int showtimeId;
    private double price;
    private int customerId;
    private String purchaseDate;
    private String status;
    private int movieId;
    private int comboId;
    private int promotionId;

    // Các thuộc tính mới
    private String cinemaName;        // Tên rạp
    private String screeningRoom;     // Tên phòng chiếu
    private List<String> seatNames;   // Danh sách số ghế
    private String movieTitle;        // Tên phim
    private String customerName;      // Tên khách hàng
    private String showtimeStart;     // Giờ chiếu

    // Constructor mặc định
    public Ticket() {
        this.seatNames = new ArrayList<>(); // Khởi tạo danh sách ghế
    }

    public Ticket(int showtimeId, double price, int customerId, String purchaseDate, String status, int movieId, int comboId, int promotionId, List<String> seatNames) {
        this.showtimeId = showtimeId;
        this.price = price;
        this.customerId = customerId;
        this.purchaseDate = purchaseDate;
        this.status = status;
        this.movieId = movieId;
        this.comboId = comboId;
        this.promotionId = promotionId;
        this.seatNames = seatNames != null ? seatNames : new ArrayList<>(); // Khởi tạo danh sách ghế
    }

    public Ticket(int ticketId, int showtimeId, double price, int customerId, String purchaseDate,
            String cinemaName, String screeningRoom, List<String> seatNames, String movieTitle, String customerName, String showtimeStart) {
        this.ticketId = ticketId;
        this.showtimeId = showtimeId;
        this.price = price;
        this.customerId = customerId;
        this.purchaseDate = purchaseDate;
        this.cinemaName = cinemaName;
        this.screeningRoom = screeningRoom;
        this.seatNames = seatNames != null ? seatNames : new ArrayList<>(); // Khởi tạo danh sách ghế
        this.movieTitle = movieTitle;
        this.customerName = customerName;
        this.showtimeStart = showtimeStart;  // Gán giá trị cho showtimeStart
    }
 

    // Getter và Setter cho seatNames
    public List<String> getSeatNames() {
        return seatNames;
    }

    public void setSeatNames(List<String> seatNames) {
        this.seatNames = seatNames;
    }

    // Các phương thức getter và setter khác
    public int getComboId() {
        return comboId;
    }

    public void setComboId(int comboId) {
        this.comboId = comboId;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public String getScreeningRoom() {
        return screeningRoom;
    }

    public void setScreeningRoom(String screeningRoom) {
        this.screeningRoom = screeningRoom;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getShowtimeStart() {
        return showtimeStart;
    }

    public void setShowtimeStart(String showtimeStart) {
        this.showtimeStart = showtimeStart;
    }
}
