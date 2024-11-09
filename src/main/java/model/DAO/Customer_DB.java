package model.DAO;

import static com.mchange.v2.c3p0.impl.C3P0Defaults.password;
import jakarta.mail.internet.ParseException;
import jakarta.validation.constraints.Null;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import model.Movie;
import model.Ticket;
import org.mindrot.jbcrypt.BCrypt;

public class Customer_DB implements DBinfo {

    public Customer_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
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
        String query = "SELECT password FROM Customer WHERE email = ?";
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

    public static Customer getCustomerByEmail(String email) {
        Customer customer = null;
        String query = "SELECT * FROM Customer WHERE email = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int customerId = rs.getInt("customer_id");
                    String name = rs.getString("name");
                    String customerEmail = rs.getString("email");
                    String phoneNumber = rs.getString("phone_number");
                    String password = rs.getString("password");
                    int loyaltyPoints = rs.getInt("loyalty_points");

                    // Lấy ngày đăng ký và định dạng
                    Date sqlDate = rs.getDate("registration_date");
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                    String registrationDate = formatter.format(sqlDate); // Định dạng lại ngày

                    // Lấy avatar, nếu null thì dùng ảnh mặc định
                    String avatar = rs.getString("avatar");
                    if (avatar == null) {
                        avatar = "https://greekherald.com.au/wp-content/uploads/2020/07/default-avatar.png";
                    }

                    // Lấy ngày sinh và địa điểm
                    Date birthDate = rs.getDate("birth_date");
                    String location = rs.getString("location");

                    // Tạo đối tượng Customer
                    customer = new Customer(customerId, name, customerEmail, phoneNumber, password, loyaltyPoints, registrationDate, avatar, location, birthDate);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return customer;
    }

    public static ArrayList<Customer> getAllCustomers() {
        ArrayList<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customer";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int customerId = rs.getInt("customer_id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phone_number");
                String password = rs.getString("password");
                int loyaltyPoints = rs.getInt("loyalty_points");

                // Lấy ngày đăng ký
                Date sqlDate = rs.getDate("registration_date");
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                String registrationDate = formatter.format(sqlDate); // Định dạng lại ngày

                // Lấy avatar, nếu null thì dùng ảnh mặc định
                String avatar = rs.getString("avatar");
                if (avatar == null) {
                    avatar = "https://greekherald.com.au/wp-content/uploads/2020/07/default-avatar.png";
                }

                // Lấy ngày sinh và địa điểm
                Date birthDate = rs.getDate("birth_date");
                String location = rs.getString("location");

                // Tạo đối tượng Customer
                Customer customer = new Customer(customerId, name, email, phoneNumber, password, loyaltyPoints, registrationDate, avatar, location, birthDate);
                customers.add(customer);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return customers;
    }

    public static void addUser(Customer cus) {
        String insertSQL = "INSERT INTO Customer (name, email, phone_number, password, loyalty_points, registration_date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertSQL)) {

            // Mã hóa mật khẩu
            String hashedPassword = BCrypt.hashpw(cus.getPassword(), BCrypt.gensalt());

            // Thiết lập các tham số cho PreparedStatement
            pstmt.setString(1, cus.getName());
            pstmt.setString(2, cus.getEmail());
            pstmt.setString(3, cus.getPhoneNumber());
            pstmt.setString(4, hashedPassword); // Sử dụng mật khẩu đã mã hóa
            pstmt.setInt(5, cus.getLoyaltyPoints());

            // Lấy ngày hiện tại nếu registrationDate không được chỉ định
            java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());
            pstmt.setDate(6, sqlDate); // Nếu registrationDate là Date

            // Thực thi câu lệnh
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi ra nếu có
        }
    }

    public static void updateCustomerInfo(Customer cus) {
        String updateSQL = "UPDATE Customer SET name = ?, phone_number = ?, location = ?, birth_date = ? WHERE customer_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateSQL)) {

            // Thiết lập các tham số cho PreparedStatement
            pstmt.setString(1, cus.getName());
            pstmt.setString(2, cus.getPhoneNumber());
            pstmt.setString(3, cus.getLocation());

            // Sử dụng trực tiếp ngày sinh kiểu Date
            java.util.Date birthDate = cus.getBirthdate(); // birthdate là kiểu Date
            pstmt.setDate(4, new java.sql.Date(birthDate.getTime())); // Chuyển đổi sang java.sql.Date

            pstmt.setInt(5, cus.getCustomerId());

            // Thực thi câu lệnh
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateAvatar(Customer cus) {
        String updateSQL = "UPDATE Customer SET avatar = ? WHERE customer_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateSQL)) {

            pstmt.setString(1, cus.getAvatar());
            pstmt.setInt(2, cus.getCustomerId());

            // Thực thi câu lệnh
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean changePass(String email, String newPassword) {
        String query = "UPDATE Customer SET password = ? WHERE email = ?";
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

    // Search Method
    public static ArrayList<Movie> searchMovies(String keyword) {
        ArrayList<Movie> movies = new ArrayList<>();
        String query = "SELECT * FROM Movie WHERE title LIKE ? OR genre LIKE ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Gán tham số cho câu truy vấn
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");

            ResultSet rs = pstmt.executeQuery();

            // Lặp qua kết quả trả về
            while (rs.next()) {
                Movie movie = new Movie();

                // Gán giá trị cho các thuộc tính của movie từ kết quả truy vấn
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setDuration(rs.getInt("duration"));
                movie.setGenre(rs.getString("genre"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setDescription(rs.getString("description"));
                movie.setStatus(rs.getString("status"));
                movie.setPoster(rs.getString("poster"));
                movie.setAverageRating(rs.getDouble("average_rating"));

                // Nếu có thêm danh sách ratings, bạn có thể cần một truy vấn khác để lấy dữ liệu ratings cho phim này
                // movie.setRatings(fetchRatingsForMovie(movie.getMovieId()));
                // Thêm đối tượng Movie vào danh sách
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movies;
    }

    public static List<Ticket> getTicketDetails(int customerId) {
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
                + "    t.customer_id = ? " // Lọc theo customer_id
                + "ORDER BY "
                + "    t.ticket_id DESC;"; // Sắp xếp theo ticket_id tăng dần

        List<Ticket> ticketDetailsList = new ArrayList<>();
        Map<Integer, Ticket> ticketMap = new HashMap<>(); // Để nhóm ghế theo ticket_id

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, customerId); // Thiết lập customerId vào truy vấn

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
            Logger.getLogger(Customer_DB.class.getName()).log(Level.SEVERE,
                    "Error retrieving ticket details for customer ID: " + customerId, ex);
        }

        ticketDetailsList.addAll(ticketMap.values()); // Chuyển đổi từ map sang list
        return ticketDetailsList;
    }

}
