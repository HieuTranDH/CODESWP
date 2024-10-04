/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import model.Movie;
import model.ScreeningRoom;
import model.Showtime;

/**
 *
 * @author PC
 */
public class ScreeningRoom_DB implements DBinfo {

    public ScreeningRoom_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static List<ScreeningRoom> getAllRoomsByCinemaId(int cinemaId) {
        List<ScreeningRoom> rooms = new ArrayList<>();

        String sql = "SELECT r.room_id, r.room_name, r.seat_capacity, "
                + "s.showtime_id, s.start_time, s.end_time, "
                + "m.movie_id, m.title, m.duration, m.genre, m.release_date, m.description, m.status, m.poster, m.average_rating "
                + "FROM ScreeningRoom r "
                + "LEFT JOIN Showtime s ON r.room_id = s.room_id "
                + "LEFT JOIN Movie m ON s.movie_id = m.movie_id "
                + "WHERE r.cinema_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, cinemaId);

            try (ResultSet rs = stmt.executeQuery()) {
                Map<Integer, ScreeningRoom> roomMap = new HashMap<>();  // To keep track of rooms

                while (rs.next()) {
                    int roomId = rs.getInt("room_id");
                    String roomName = rs.getString("room_name");
                    int seatCapacity = rs.getInt("seat_capacity");

                    // Retrieve or create the room
                    ScreeningRoom room = roomMap.get(roomId);
                    if (room == null) {
                        room = new ScreeningRoom(roomId, cinemaId, roomName, seatCapacity);
                        roomMap.put(roomId, room);
                    }

                    // Retrieve showtime if it exists
                    int showtimeId = rs.getInt("showtime_id");
                    if (showtimeId > 0) {
                        String startTime = rs.getString("start_time");
                        String endTime = rs.getString("end_time");

                        // Retrieve movie info
                        int movieId = rs.getInt("movie_id");
                        String title = rs.getString("title");
                        int duration = rs.getInt("duration");
                        String genre = rs.getString("genre");
                        String releaseDate = rs.getString("release_date");
                        String description = rs.getString("description");
                        String status = rs.getString("status");
                        String poster = rs.getString("poster");
                        double averageRating = rs.getDouble("average_rating");

                        // Create movie and showtime objects
                        Movie movie = new Movie(movieId, title, duration, genre, releaseDate, description, status, poster, averageRating);
                        Showtime showtime = new Showtime(movie, showtimeId, startTime, endTime, roomName);

                        // Add the showtime to the room
                        room.addShowtime(showtime);
                    }
                }

                // Add all rooms to the list
                rooms.addAll(roomMap.values());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rooms;
    }

    public boolean addShowTime(Showtime showtime) {
        String sql = "INSERT INTO Showtime (movie_id, room_id, start_time, end_time) VALUES (?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, showtime.getMovieId());
            stmt.setInt(2, showtime.getRoomId());
            stmt.setObject(3, showtime.getStartTime());
            stmt.setObject(4, showtime.getEndTime());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public boolean updateShowtime(Showtime showtime) {
        String sql = "UPDATE Showtime SET movie_id = ?, room_id = ?, start_time = ?, end_time = ? WHERE showtime_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, showtime.getMovieId());
            stmt.setInt(2, showtime.getRoomId());
            stmt.setObject(3, showtime.getStartTime());
            stmt.setObject(4, showtime.getEndTime());
            stmt.setInt(5, showtime.getShowtimeId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public List<Showtime> getShowtimesByRoomAndDate(int roomId, String selectedDate) {
        List<Showtime> showtimes = new ArrayList<>();

        // Chuẩn bị câu lệnh SQL để lấy showtime theo phòng và ngày đã chọn
        String sql = "SELECT * FROM Showtime WHERE room_id = ? AND CONVERT(DATE, start_time)  = ?";

        // Sử dụng try-with-resources để tự động đóng kết nối và PreparedStatement
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, roomId); // Thiết lập ID phòng
            stmt.setString(2, selectedDate); // Thiết lập ngày đã chọn

            ResultSet rs = stmt.executeQuery(); // Thực hiện truy vấn

            // Duyệt qua ResultSet và thêm showtime vào danh sách
            while (rs.next()) {
                Showtime showtime = new Showtime();
                showtime.setShowtimeId(rs.getInt("showtime_id"));
                showtime.setMovieId(rs.getInt("movie_id"));
                showtime.setRoomId(rs.getInt("room_id"));
                showtime.setStartTime(rs.getString("start_time"));
                showtime.setEndTime(rs.getString("end_time"));
                // Thêm các trường khác nếu cần thiết

                showtimes.add(showtime); // Thêm showtime vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có
        }

        return showtimes; // Trả về danh sách showtimes
    }
 public static ArrayList<ScreeningRoom> getAllScreeningRoomByCinemaId(int cinemaId) {
        ArrayList<ScreeningRoom> screeningRooms = new ArrayList<>();
        String query = "SELECT * FROM ScreeningRoom WHERE cinema_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, cinemaId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ScreeningRoom room = new ScreeningRoom();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setCinemaId(rs.getInt("cinema_id"));
                    room.setRoomName(rs.getString("room_name"));
                    room.setSeatCapacity(rs.getInt("seat_capacity"));
                    screeningRooms.add(room);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ScreeningRoom_DB.class.getName()).log(Level.SEVERE, null, e);
        }
        return screeningRooms;
    }

    // Method to add a new screening room
    public static boolean addNewScreeningRoom(ScreeningRoom room) {
        String query = "INSERT INTO ScreeningRoom (cinema_id, room_name, seat_capacity) VALUES (?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, room.getCinemaId());
            pstmt.setString(2, room.getRoomName());
            pstmt.setInt(3, room.getSeatCapacity());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ScreeningRoom_DB.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    // Method to edit/update a screening room
    public static boolean editScreeningRoom(ScreeningRoom room) {
        String query = "UPDATE ScreeningRoom SET room_name = ?, seat_capacity = ? WHERE room_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, room.getRoomName());
            pstmt.setInt(2, room.getSeatCapacity());
            pstmt.setInt(3, room.getRoomId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ScreeningRoom_DB.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    // Method to get a screening room by room_id
    public static ScreeningRoom getScreeningRoomById(int roomId) {
        String query = "SELECT * FROM ScreeningRoom WHERE room_id = ?";
        ScreeningRoom room = null;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, roomId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = new ScreeningRoom();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setCinemaId(rs.getInt("cinema_id"));
                    room.setRoomName(rs.getString("room_name"));
                    room.setSeatCapacity(rs.getInt("seat_capacity"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ScreeningRoom_DB.class.getName()).log(Level.SEVERE, null, e);
        }
        return room;
    }

}
