/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cinema;
import static model.DAO.DBinfo.driver;
import model.Movie;
import model.Staff;
import model.Ticket;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author PC
 */
public class Staff_DB implements DBinfo {

    public Staff_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Staff getStaffByEmail(String email) {
        Staff staff = null;
        String query = "SELECT * FROM Staff WHERE email = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int staffId = rs.getInt("staff_id");
                    int cinemaId = rs.getInt("cinema_id");
                    String name = rs.getString("name");
                    String hireDate = rs.getString("hire_date");
                     String disableDate = rs.getString("disabled_date");
                    String staffEmail = rs.getString("email");
                    String phoneNumber = rs.getString("phone_number");
                    String password = rs.getString("password");
                    String role = rs.getString("role");
                    String status = rs.getString("status");

                    // Tạo đối tượng Staff
                    staff = new Staff(staffId, name, staffEmail, phoneNumber, password, role, hireDate,disableDate, cinemaId,status);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return staff;
    }

    public static boolean checkStaffByEmail(String email) {
        String query = "SELECT 1 FROM Staff WHERE email = ?"; // Truy vấn kiểm tra sự tồn tại
        boolean exists = false;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    exists = true;  // Nếu có kết quả, email tồn tại
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return exists; // Trả về kết quả
    }

    public static List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM Staff";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int staffId = rs.getInt("staff_id");
                    int cinemaId = rs.getInt("cinema_id");
                    String name = rs.getString("name");
                    String hireDate = rs.getString("hire_date");
                    String staffEmail = rs.getString("email");
                    String phoneNumber = rs.getString("phone_number");
                    String password = rs.getString("password");
                    String role = rs.getString("role");

                    // Create Staff object and add it to the list
                    Staff staff = new Staff(staffId, name, staffEmail, phoneNumber, password, role, hireDate, cinemaId);
                    staffList.add(staff);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return staffList;
    }

    public static List<Staff> getAllStaffWithCinema() {
    List<Staff> staffList = new ArrayList<>();
    String query = "SELECT s.staff_id, s.cinema_id, s.name AS staff_name, s.hire_date, s.disabled_date ,s.status ,s.email AS staff_email, "
            + "s.phone_number AS staff_phone, s.password, s.role, "
            + "c.name AS cinema_name, c.address AS cinema_address, c.phone_number AS cinema_phone, c.email AS cinema_email, "
            + "c.status AS cinema_status " // Thêm dấu phẩy ở đây
            + "FROM Staff s "
            + "LEFT JOIN Cinema c ON s.cinema_id = c.cinema_id";

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
         PreparedStatement pstmt = con.prepareStatement(query)) {
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int staffId = rs.getInt("staff_id");
                int cinemaId = rs.getInt("cinema_id");
                String staffName = rs.getString("staff_name");
                String hireDate = rs.getString("hire_date");
                String disableDate = rs.getString("disabled_date");
                String staffEmail = rs.getString("staff_email");
                String staffPhone = rs.getString("staff_phone");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                // Cinema details
                String cinemaName = rs.getString("cinema_name");
                String cinemaAddress = rs.getString("cinema_address");
                String cinemaPhone = rs.getString("cinema_phone");
                String cinemaEmail = rs.getString("cinema_email");
                String cinemaStatus = rs.getString("cinema_status");

                // Tạo đối tượng Cinema
                Cinema cinema = new Cinema(cinemaId, cinemaName, cinemaAddress, cinemaPhone, cinemaEmail, cinemaStatus);

                // Tạo đối tượng Staff và thêm vào danh sách
                Staff staff = new Staff(staffId, staffName, staffEmail, staffPhone, password, role, hireDate,disableDate, cinema, status);
                staffList.add(staff);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
    }

    return staffList;
}


    public static boolean addStaff(Staff staff) {
        boolean isAdded = false;
        String query = "INSERT INTO Staff (name, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, staff.getName());
            pstmt.setString(2, staff.getEmail());
            pstmt.setString(3, staff.getPassword());
            pstmt.setString(4, staff.getRole()); // Role should be "Staff"

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true; // Staff successfully added
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return isAdded;
    }

  public static boolean updateStaff(Staff staff) {
    boolean isUpdated = false;
    String query = "UPDATE Staff SET email = ?, phone_number = ?, cinema_id = ?, status = ?, "
                 + "hire_date = CASE WHEN ? = 'Active' THEN GETDATE() ELSE hire_date END, "
                 + "disabled_date = CASE WHEN ? = 'Cancel' THEN GETDATE() WHEN ? = 'Active' THEN NULL ELSE disabled_date END "
                 + "WHERE staff_id = ?";

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
         PreparedStatement pstmt = con.prepareStatement(query)) {

        pstmt.setString(1, staff.getEmail());
        pstmt.setString(2, staff.getPhoneNumber()); // Phone number is optional

        // Nếu cinemaId == 0 thì set NULL vào database, ngược lại set giá trị cinemaId
        if (staff.getCinemaId() == 0) {
            pstmt.setNull(3, java.sql.Types.INTEGER);
        } else {
            pstmt.setInt(3, staff.getCinemaId());
        }

        pstmt.setString(4, staff.getStatus()); // Set status
        
        // Truyền status để quyết định cập nhật hire_date hoặc disabled_date
        pstmt.setString(5, staff.getStatus()); // For hire_date
        pstmt.setString(6, staff.getStatus()); // For disabled_date khi Cancel
        pstmt.setString(7, staff.getStatus()); // For disabled_date khi Active

        pstmt.setInt(8, staff.getStaffId()); // Assuming you have a getStaffId method in your Staff class

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            isUpdated = true; // Staff successfully updated
        }
    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
    }

    return isUpdated;
}
    public static boolean updateStaffInfo(Staff staff) {
        boolean isUpdated = false;
        String query = "UPDATE Staff SET name = ?, phone_number = ? WHERE staff_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, staff.getName());
            pstmt.setString(2, staff.getPhoneNumber()); // Assuming phone number is optional

            // Nếu cinemaId == 0 thì set NULL vào database, ngược lại set giá trị cinemaId
           

            pstmt.setInt(3, staff.getStaffId()); // Assuming you have a getStaffId method in your Staff class

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true; // Staff successfully updated
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return isUpdated;
    }
public static boolean cancelStaff(int staffId) {
    boolean isCancelled = false;
    String query = "UPDATE Staff SET status = 'cancel' WHERE staff_id = ?";

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
         PreparedStatement pstmt = con.prepareStatement(query)) {

        pstmt.setInt(1, staffId); // Sử dụng ID nhân viên

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            isCancelled = true; // Nhân viên đã được cập nhật trạng thái thành công
        }
    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
    }

    return isCancelled;
}
    public static Staff getStaffById(int staffId) {
        Staff staff = null;
        String query = "SELECT * FROM Staff WHERE staff_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, staffId); // Set the staff ID parameter

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int cinemaId = rs.getInt("cinema_id");
                    String name = rs.getString("name");
                    String hireDate = rs.getString("hire_date");
                    String staffEmail = rs.getString("email");
                    String phoneNumber = rs.getString("phone_number");
                    String password = rs.getString("password");
                    String role = rs.getString("role");

                    // Create Staff object
                    staff = new Staff(staffId, name, staffEmail, phoneNumber, password, role, hireDate, cinemaId);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return staff; // Return the Staff object or null if not found
    }

    public static boolean checkCurrentPassword(String email, String currentPassword) {
        String storedPassword = getStoredPassword(email);
        if (storedPassword == null) {
            return false; // Không tìm thấy mật khẩu lưu trữ
        }
        if (storedPassword.equals(currentPassword)) {
            return true; // Trả về true nếu mật khẩu chưa được mã hóa
        }
        return BCrypt.checkpw(currentPassword, storedPassword); // Kiểm tra mật khẩu đã được mã hóa
    }

    private static String getStoredPassword(String email) {
        String query = "SELECT password FROM Staff WHERE email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE, "Error retrieving password for email: " + email, ex);
        }
        return null; // Trả về null nếu có lỗi xảy ra
    }

    public static boolean changePass(String email, String newPassword) {
        String query = "UPDATE Staff SET password = ? WHERE email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            String hashedPassword = hashPassword(newPassword);
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE, "Error updating password for email: " + email, ex);
        }
        return false;
    }

    private static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }
   public static boolean createMovie(Movie movie) {
    String query = "INSERT INTO Movie (title, duration, genre, release_date, description, status, poster, average_rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

        // Gán các tham số vào câu query từ đối tượng movie
        pstmt.setString(1, movie.getTitle());
        pstmt.setInt(2, movie.getDuration());
        pstmt.setString(3, movie.getGenre());
        pstmt.setString(4, movie.getReleaseDate());
        pstmt.setString(5, movie.getDescription());
        pstmt.setString(6, movie.getStatus());
        pstmt.setString(7, movie.getPoster());
        pstmt.setDouble(8, 0.00);

        int rowsInserted = pstmt.executeUpdate();
        return rowsInserted > 0;

    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, "Error inserting movie: " + movie.getTitle(), ex);
    }
    return false;
}
    public static boolean updateMovie(Movie movie) {
    String sql = "UPDATE Movie SET title = ?, duration = ?, genre = ?, status = ?, release_date = ?, description = ?, poster = ? WHERE movie_id = ?";
    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); // Kết nối với database
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        // Thiết lập các giá trị cho câu lệnh SQL
        ps.setString(1, movie.getTitle());
        ps.setInt(2, movie.getDuration());
        ps.setString(3, movie.getGenre());
        ps.setString(4, movie.getStatus());
        ps.setString(5, movie.getReleaseDate()); // Giả định releaseDate là chuỗi ngày (yyyy/MM/dd)
        ps.setString(6, movie.getDescription());
        
        ps.setString(7, movie.getPoster()); // Đường dẫn đến poster
        ps.setInt(8, movie.getMovieId()); // ID của phim cần cập nhật
        
        // Thực thi cập nhật
        int rowsUpdated = ps.executeUpdate();
        
        // Kiểm tra xem cập nhật có thành công không (số hàng bị ảnh hưởng phải lớn hơn 0)
        return rowsUpdated > 0;
        
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
 public static List<Ticket> getTicketDetailsByCinemaId(int cinemaId) {
    String query = "SELECT "
            + "    t.ticket_id AS ticketId, "
            + "    t.status AS ticket_status, "
            + "    t.price AS ticket_price, "
            + "    t.purchase_date AS purchase_date, "
            + "    s.start_time AS showtime_start, "
            + "    c.name AS cinema_name, "
            + "    sr.room_name AS screening_room, "
            + "    m.movie_id AS movieId, "
            + "    m.title AS movie_title, "
            + "    cu.name AS customer_name, "
            + "    r.seat_number AS seat_name " // Tên ghế
            + "FROM "
            + "    Ticket t "
            + "JOIN "
            + "    Showtime s ON t.showtime_id = s.showtime_id " // Kết nối với Showtime
            + "JOIN "
            + "    Movie m ON s.movie_id = m.movie_id " // Kết nối với Movie
            + "JOIN "
            + "    TicketSeat ts ON t.ticket_id = ts.ticket_id " // Kết nối với TicketSeat
            + "JOIN "
            + "    Seat r ON ts.seat_id = r.seat_id " // Kết nối với Seat
            + "JOIN "
            + "    ScreeningRoom sr ON r.room_id = sr.room_id " // Kết nối với ScreeningRoom
            + "JOIN "
            + "    Cinema c ON sr.cinema_id = c.cinema_id " // Kết nối với Cinema
            + "JOIN "
            + "    Customer cu ON t.customer_id = cu.customer_id " // Kết nối với Customer
            + "WHERE "
            + "    c.cinema_id = ? " // Lọc theo cinema_id
            + "ORDER BY "
            + "    t.ticket_id DESC;"; // Sắp xếp theo ticket_id giảm dần

    List<Ticket> ticketDetailsList = new ArrayList<>();
    Map<Integer, Ticket> ticketMap = new HashMap<>(); // Để nhóm ghế theo ticket_id

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
        pstmt.setInt(1, cinemaId); // Thiết lập cinemaId vào truy vấn

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");

                // Kiểm tra xem vé đã tồn tại trong ticketMap chưa
                Ticket ticketDetails = ticketMap.get(ticketId);
                if (ticketDetails == null) {
                    ticketDetails = new Ticket();
                    ticketDetails.setTicketId(ticketId);
                    ticketDetails.setMovieId(rs.getInt("movieId"));
                    ticketDetails.setStatus(rs.getString("ticket_status"));
                    ticketDetails.setPrice(rs.getDouble("ticket_price"));
                    ticketDetails.setPurchaseDate(rs.getString("purchase_date"));
                    ticketDetails.setShowtimeStart(rs.getString("showtime_start"));
                    ticketDetails.setCinemaName(rs.getString("cinema_name"));
                    ticketDetails.setScreeningRoom(rs.getString("screening_room"));
                    ticketDetails.setMovieTitle(rs.getString("movie_title"));
                    ticketDetails.setCustomerName(rs.getString("customer_name"));
                    ticketDetails.setSeatNames(new ArrayList<>()); // Khởi tạo danh sách ghế
                    ticketMap.put(ticketId, ticketDetails); // Lưu vào map
                }

                // Thêm ghế vào danh sách của vé
                ticketDetails.getSeatNames().add(rs.getString("seat_name"));
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE,
                "Error retrieving ticket details for cinema ID: " + cinemaId, ex);
    }

    ticketDetailsList.addAll(ticketMap.values()); // Chuyển đổi từ map sang list
    return ticketDetailsList;
}
 
   public static boolean checkingTicket(int ticketId) {
    String query = "UPDATE Ticket SET status = 'CheckedIn' WHERE ticket_id = ?";
    boolean isUpdated = false;

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
         PreparedStatement pstmt = con.prepareStatement(query)) {
        pstmt.setInt(1, ticketId);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            isUpdated = true; // Cập nhật thành công
        }
    } catch (SQLException ex) {
        Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, null, ex);
    }

    return isUpdated;
}


// Phương thức phụ để lấy thông tin vé theo ID
  public static Ticket searchTicketById(int ticketId) {
    String query = "SELECT t.ticket_id, t.showtime_id, t.price, t.customer_id, t.purchase_date, t.status, "
                 + "m.movie_id, m.title AS movie_title, "
                 + "c.name AS cinema_name, sr.room_name AS screening_room, s.seat_number, cu.name AS customer_name, "
                 + "st.start_time AS showtime_start "
                 + "FROM Ticket t "
                 + "JOIN Showtime st ON t.showtime_id = st.showtime_id "
                 + "JOIN Movie m ON st.movie_id = m.movie_id "
                 + "JOIN ScreeningRoom sr ON st.room_id = sr.room_id "
                 + "JOIN Cinema c ON sr.cinema_id = c.cinema_id "
                 + "JOIN TicketSeat ts ON t.ticket_id = ts.ticket_id "
                 + "JOIN Seat s ON ts.seat_id = s.seat_id "
                 + "JOIN Customer cu ON t.customer_id = cu.customer_id "
                 + "WHERE t.ticket_id = ?";

    Ticket ticket = null;

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement pstmt = con.prepareStatement(query)) {
        pstmt.setInt(1, ticketId);

        try (ResultSet rs = pstmt.executeQuery()) {
            Map<Integer, Ticket> ticketMap = new HashMap<>();

            while (rs.next()) {
                // Lấy dữ liệu từ ResultSet
                int ticketIdFromDB = rs.getInt("ticket_id");
                
                // Kiểm tra xem vé đã tồn tại trong ticketMap chưa
                ticket = ticketMap.get(ticketIdFromDB);
                if (ticket == null) {
                    // Tạo đối tượng Ticket mới nếu chưa có
                    ticket = new Ticket();
                    ticket.setTicketId(ticketIdFromDB);
                    ticket.setShowtimeId(rs.getInt("showtime_id"));
                    ticket.setPrice(rs.getDouble("price"));
                    ticket.setCustomerId(rs.getInt("customer_id"));
                    ticket.setPurchaseDate(rs.getString("purchase_date"));
                    ticket.setStatus(rs.getString("status"));
                    ticket.setMovieId(rs.getInt("movie_id"));
                    ticket.setMovieTitle(rs.getString("movie_title"));
                    ticket.setCinemaName(rs.getString("cinema_name"));
                    ticket.setScreeningRoom(rs.getString("screening_room"));
                    ticket.setCustomerName(rs.getString("customer_name"));
                    ticket.setShowtimeStart(rs.getString("showtime_start"));

                    // Khởi tạo danh sách ghế ngồi
                    ticket.setSeatNames(new ArrayList<>());

                    // Thêm vào map để nhóm các vé cùng ID
                    ticketMap.put(ticketIdFromDB, ticket);
                }

                // Thêm ghế vào danh sách của vé
                String seatName = rs.getString("seat_number");
                ticket.getSeatNames().add(seatName);
            }

            if (!ticketMap.isEmpty()) {
                ticket = ticketMap.values().iterator().next(); // Lấy vé đầu tiên (vì chỉ có 1 vé)
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, "Error searching for ticket by ID: " + ticketId, ex);
    }

    return ticket;
}

    public static boolean deleteMovie(int movieId) {
        String query = "DELETE FROM Movie WHERE movie_id = ?";
        boolean isDeleted = false;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, movieId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff_DB.class.getName()).log(Level.SEVERE, "Error deleting movie with ID: " + movieId, ex);
        }

        return isDeleted;
    }
}
