
package model;


import java.util.ArrayList;
import java.util.List;

public class Cinema {

    private int cinemaId;
    private String name;
    private String address;
    private String phoneNumber;
    private String email;
    private String status;
    private List<ScreeningRoom> screeningRooms = new ArrayList<>(); // Danh sách các phòng chiếu

    // Constructor
    public Cinema() {
    }

    public Cinema(int cinemaId, String name, String address, String phoneNumber, String email) {
        this.cinemaId = cinemaId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    public Cinema(int cinemaId, String name, String address, String phoneNumber, String email, String status) {
        this.cinemaId = cinemaId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.status = status;
    }

    // Getters và Setters
    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Hàm thêm phòng chiếu
    public void addScreeningRoom(ScreeningRoom screeningRoom) {
        screeningRooms.add(screeningRoom);
    }

    // Hàm lấy phòng chiếu theo id
    public ScreeningRoom getScreeningRoomById(int roomId) {
        return screeningRooms.stream()
                .filter(room -> room.getRoomId() == roomId)
                .findFirst()
                .orElse(null);
    }

    // Hàm thêm suất chiếu vào phòng chiếu
    public void addShowtime(int roomId, Showtime showtime) {
        ScreeningRoom room = getScreeningRoomById(roomId);
        if (room != null) {
            room.addShowtime(showtime);
        }
    }

    public List<ScreeningRoom> getScreeningRooms() {
        return screeningRooms;
    }

    public void setScreeningRooms(List<ScreeningRoom> screeningRooms) {
        this.screeningRooms = screeningRooms;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
