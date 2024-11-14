
package model.DAO;

import java.math.BigDecimal;
import model.MovieShowtime;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Cinema;
import static model.DAO.DBinfo.*;
import model.Movie;
import model.ScreeningRoom;
import model.Seat;
import model.Showtime;
import model.Staff;


public class Cinema_DB {

    public Cinema_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static List<Cinema> getAllCinemasWithShowtimes() {
        String query = "SELECT c.cinema_id, c.name AS cinema_name, c.address AS cinema_address, "
                + "c.phone_number AS cinema_phone, c.email AS cinema_email, "
                + "sr.room_id, sr.room_name, sr.seat_capacity, "
                + "m.movie_id, m.title AS movie_title, m.duration AS movie_duration, "
                + "m.genre AS movie_genre, m.release_date AS movie_release_date, "
                + "m.description, m.status, m.poster, m.average_rating, "
                + "s.showtime_id, s.start_time, s.end_time "
                + "FROM Cinema c "
                + "JOIN ScreeningRoom sr ON c.cinema_id = sr.cinema_id "
                + "JOIN Showtime s ON sr.room_id = s.room_id "
                + "JOIN Movie m ON s.movie_id = m.movie_id "
                + "ORDER BY c.cinema_id, s.start_time";

        List<Cinema> cinemas = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            Cinema currentCinema = null;

            while (rs.next()) {
                // Lấy thông tin Cinema
                int cinemaId = rs.getInt("cinema_id");
                String cinemaName = rs.getString("cinema_name");
                String cinemaAddress = rs.getString("cinema_address");
                String cinemaPhone = rs.getString("cinema_phone");
                String cinemaEmail = rs.getString("cinema_email");

                // Kiểm tra xem Cinema đã tồn tại trong danh sách chưa
                if (currentCinema == null || currentCinema.getCinemaId() != cinemaId) {
                    currentCinema = new Cinema(cinemaId, cinemaName, cinemaAddress, cinemaPhone, cinemaEmail);
                    cinemas.add(currentCinema);
                }

                // Lấy thông tin ScreeningRoom
                int roomId = rs.getInt("room_id");
                String roomName = rs.getString("room_name");
                int seatCapacity = rs.getInt("seat_capacity");

                // Kiểm tra nếu phòng chiếu đã tồn tại trong Cinema
                ScreeningRoom screeningRoom = currentCinema.getScreeningRoomById(roomId);
                if (screeningRoom == null) {
                    screeningRoom = new ScreeningRoom(roomId, roomName, seatCapacity);
                    currentCinema.addScreeningRoom(screeningRoom);
                }

                // Lấy thông tin Movie
                int movieId = rs.getInt("movie_id");
                String movieTitle = rs.getString("movie_title");
                int duration = rs.getInt("movie_duration");
                String genre = rs.getString("movie_genre");
                String releaseDate = rs.getString("movie_release_date");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String poster = rs.getString("poster");

// Kiểm tra nếu poster là null và gán link placeholder
                if (poster == null) {
                    poster = "https://via.placeholder.com/150";
                }

                double averageRating = rs.getDouble("average_rating");

// Tạo đối tượng Movie
                Movie movie = new Movie(movieId, movieTitle, duration, genre, releaseDate, description, status, poster, averageRating);

                // Lấy thông tin Showtime
                int showtimeId = rs.getInt("showtime_id");
                String startTime = rs.getString("start_time");
                String endTime = rs.getString("end_time");

                // Khởi tạo đối tượng Showtime với đối tượng Movie
                Showtime showtime = new Showtime(showtimeId, movie, startTime, endTime, roomName, cinemaName);

                // Thêm Showtime vào ScreeningRoom
                screeningRoom.addShowtime(showtime);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Lỗi khi lấy thông tin rạp chiếu phim và suất chiếu", ex);
        }

        return cinemas; // Trả về danh sách các rạp chiếu với suất chiếu phim
    }

    public static List<Movie> getMoviesCurrentlyShowing(Date selectedDate) {
        String query = "SELECT DISTINCT m.movie_id, m.title AS movie_title, m.duration AS movie_duration, "
                + "m.genre AS movie_genre, m.release_date AS movie_release_date, "
                + "m.description, m.status, m.poster, m.average_rating, s.start_time "
                + "FROM Movie m "
                + "JOIN Showtime s ON m.movie_id = s.movie_id "
                + "WHERE CONVERT(DATE, s.start_time) >= ? " // Lọc suất chiếu theo ngày được chọn
                + "ORDER BY s.start_time";

        List<Movie> movies = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Chuyển java.util.Date thành java.sql.Date để sử dụng trong SQL
            java.sql.Date sqlSelectedDate = new java.sql.Date(selectedDate.getTime());
            pstmt.setDate(1, sqlSelectedDate); // Định dạng ngày thành yyyy-mm-dd và set vào câu truy vấn

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy thông tin Movie
                    int movieId = rs.getInt("movie_id");
                    String movieTitle = rs.getString("movie_title");
                    int duration = rs.getInt("movie_duration");
                    String genre = rs.getString("movie_genre");
                    String releaseDate = rs.getString("movie_release_date");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String poster = rs.getString("poster");

                    // Kiểm tra nếu poster là null và gán link placeholder
                    if (poster == null) {
                        poster = "https://via.placeholder.com/150";
                    }

                    double averageRating = rs.getDouble("average_rating");

                    // Tạo đối tượng Movie và thêm vào danh sách
                    Movie movie = new Movie(movieId, movieTitle, duration, genre, releaseDate, description, status, poster, averageRating);
                    movies.add(movie);

                    // In ra thông tin của bộ phim (log)
                    System.out.println("Movie ID: " + movieId);
                    System.out.println("Title: " + movieTitle);
                    System.out.println("Duration: " + duration + " phút");
                    System.out.println("Genre: " + genre);
                    System.out.println("Release Date: " + releaseDate);
                    System.out.println("Description: " + description);
                    System.out.println("Status: " + status);
                    System.out.println("Poster: " + poster);
                    System.out.println("Average Rating: " + averageRating);
                    System.out.println("-----------------------------");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Lỗi khi lấy thông tin các bộ phim đang chiếu", ex);
        }

        return movies; // Trả về danh sách các bộ phim đang có suất chiếu
    }

    public List<Movie> getShowtimesByDate(String selectedDate) {
        List<Movie> movieShowtimes = new ArrayList<>();
        String query = "SELECT m.title, m.poster, m.duration, m.description, m.releaseDate, m.genre, s.startTime "
                + "FROM movies m "
                + "JOIN showtimes s ON m.movieId = s.movieId "
                + "WHERE DATE(s.startTime) = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setDate(1, java.sql.Date.valueOf(selectedDate)); // Đặt giá trị cho tham số của PreparedStatement

            try (ResultSet rs = pstmt.executeQuery()) { // Thực hiện truy vấn
                while (rs.next()) {
                    Movie movieShowtime = new Movie();
                    movieShowtime.setTitle(rs.getString("title"));
                    movieShowtime.setPoster(rs.getString("poster"));
                    movieShowtime.setDuration(rs.getInt("duration"));
                    movieShowtime.setDescription(rs.getString("description"));
                    movieShowtime.setReleaseDate(rs.getString("releaseDate"));
                    movieShowtime.setGenre(rs.getString("genre"));
                    movieShowtime.setStartTime(rs.getString("startTime"));
                    movieShowtimes.add(movieShowtime);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieShowtimes;
    }

    public static List<Cinema> getAllCinemas() {
        String query = "SELECT cinema_id, name, address, phone_number, email, status FROM Cinema";
        List<Cinema> cinemas = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // Lấy thông tin của từng rạp
                int cinemaId = rs.getInt("cinema_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                String email = rs.getString("email");
                String status = rs.getString("status");

                // Tạo đối tượng Cinema và thêm vào danh sách
                Cinema cinema = new Cinema(cinemaId, name, address, phoneNumber, email, status);
                cinemas.add(cinema);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving cinemas", ex);
        }
        return cinemas; // Trả về danh sách các rạp chiếu
    }
public static List<Cinema> getAvailableCinemas() {
    String query = "SELECT c.cinema_id, c.name, c.address, c.phone_number, c.email " +
                   "FROM Cinema c " +
                   "LEFT JOIN Staff s ON c.cinema_id = s.cinema_id " +
                   "WHERE s.cinema_id IS NULL AND c.status = 'open'"; // Lấy những rạp mà không có nhân viên nào được gán
    List<Cinema> cinemas = new ArrayList<>();

    try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
         PreparedStatement pstmt = con.prepareStatement(query); 
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            // Lấy thông tin của từng rạp
            int cinemaId = rs.getInt("cinema_id");
            String name = rs.getString("name");
            String address = rs.getString("address");
            String phoneNumber = rs.getString("phone_number");
            String email = rs.getString("email");

            // Tạo đối tượng Cinema và thêm vào danh sách
            Cinema cinema = new Cinema(cinemaId, name, address, phoneNumber, email);
            cinemas.add(cinema);
        }
    } catch (SQLException ex) {
        Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving available cinemas", ex);
    }
    return cinemas; // Trả về danh sách các rạp chiếu chưa có nhân viên nào quản lý
}
    public static List<MovieShowtime> getMoviesByCinema(int cinemaId) {
        String query = "SELECT m.movie_id, m.title, m.duration, m.genre, m.release_date, m.description, m.status, m.poster, m.average_rating, "
                + "s.showtime_id, s.start_time, s.end_time, r.room_name "
                + "FROM Movie m "
                + "JOIN Showtime s ON m.movie_id = s.movie_id "
                + "JOIN ScreeningRoom r ON s.room_id = r.room_id "
                + "WHERE r.cinema_id = ? AND m.status = 'Active' "
                + // Lấy phim đang chiếu (Active)
                "ORDER BY s.start_time ASC";

        List<MovieShowtime> movieShowtimes = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, cinemaId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy thông tin của từng bộ phim
                    int movieId = rs.getInt("movie_id");
                    String title = rs.getString("title");
                    int duration = rs.getInt("duration");
                    String genre = rs.getString("genre");
                    String releaseDate = rs.getString("release_date");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String poster = rs.getString("poster");
                    double averageRating = rs.getDouble("average_rating");

                    // Lấy thông tin về showtime
                    int showtimeId = rs.getInt("showtime_id");
                    String startTime = rs.getString("start_time");
                    String endTime = rs.getString("end_time");
                    String roomName = rs.getString("room_name");

                    // Tạo đối tượng Movie và Showtime
                    Movie movie = new Movie(movieId, title, duration, genre, releaseDate, description, status, poster, averageRating);
                    Showtime showtime = new Showtime(showtimeId, movieId, title, startTime, endTime, roomName);

                    // Thêm MovieShowtime vào danh sách
                    MovieShowtime movieShowtime = new MovieShowtime(movie, showtime);
                    movieShowtimes.add(movieShowtime);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving movies by cinema", ex);
        }
        return movieShowtimes; // Trả về danh sách phim và showtime của rạp
    }

    public static Cinema getCinemaByStaffId(int staffId) {
        // Câu truy vấn SQL
        String query = "SELECT c.cinema_id, c.name, c.address, c.phone_number, c.email, c.status "
                + "FROM Cinema c "
                + "JOIN Staff s ON c.cinema_id = s.cinema_id "
                + "WHERE s.staff_id = ?";

        Cinema cinema = null;

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập giá trị staffId vào câu truy vấn
            pstmt.setInt(1, staffId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Lấy thông tin từ ResultSet
                    int cinemaId = rs.getInt("cinema_id");
                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    String email = rs.getString("email");
                    String status = rs.getString("status");

                    // Tạo đối tượng Cinema từ dữ liệu truy vấn
                    cinema = new Cinema(cinemaId, name, address, phoneNumber, email, status);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving cinema by staffId", ex);
        }

        // Trả về đối tượng Cinema hoặc null nếu không tìm thấy
        return cinema;
    }

    public static ArrayList<Cinema> getAllCinemas2() {
        String query = "SELECT cinema_id, name, address, phone_number, email, status FROM Cinema WHERE status = 'open'";
        ArrayList<Cinema> cinemas = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // Lấy thông tin của từng rạp
                int cinemaId = rs.getInt("cinema_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                String email = rs.getString("email");
                String status = rs.getString("status");

                // Tạo đối tượng Cinema và thêm vào ArrayList
                Cinema cinema = new Cinema(cinemaId, name, address, phoneNumber, email, status);
                cinemas.add(cinema);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving cinemas", ex);
        }
        return cinemas; // Trả về ArrayList các rạp chiếu
    }

    public static Staff getStaffByCinemaID(int cinemaId) {
        String query = "SELECT staff_id, name, email, phone_number, password, role, hire_date, cinema_id FROM Staff WHERE cinema_id = ?";
        Staff staff = null;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, cinemaId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Lấy thông tin của nhân viên
                int staffId = rs.getInt("staff_id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phone_number");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String hireDate = rs.getString("hire_date");
                int cinemaID = rs.getInt("cinema_id");

                // Tạo đối tượng Staff
                staff = new Staff(staffId, name, email, phoneNumber, password, role, hireDate, cinemaID);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Staff.class.getName()).log(Level.SEVERE, "Error retrieving staff by cinema ID", ex);
        }

        return staff; // Trả về đối tượng Staff của rạp chiếu
    }

    // Hàm thêm một Cinema vào cơ sở dữ liệu
    public static boolean addCinema(String name, String address, String phoneNumber, String email) {
        String query = "INSERT INTO Cinema (name, address, phone_number, email) VALUES (?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập các giá trị cho câu lệnh SQL
            pstmt.setString(1, name);           // Đặt giá trị cho name
            pstmt.setString(2, address);        // Đặt giá trị cho address
            pstmt.setString(3, phoneNumber);    // Đặt giá trị cho phone_number
            pstmt.setString(4, email);          // Đặt giá trị cho email

            // Thực thi câu lệnh SQL
            int affectedRows = pstmt.executeUpdate();

            // Kiểm tra nếu thêm thành công
            if (affectedRows > 0) {
                return true;  // Trả về true nếu thêm thành công
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error adding cinema", ex);
        }
        return false;  // Trả về false nếu thêm thất bại
    }

    public static List<Seat> getSeatStatusByShowtimeId(int showtimeId) {
        // Câu truy vấn SQL sửa lại để kiểm tra tình trạng ghế từ bảng TicketSeat
        String query = "SELECT "
                + "    s.seat_id, "
                + "    s.seat_number, "
                + "    s.seat_type, "
                + "    CASE "
                + "        WHEN ts.ticket_seat_id IS NOT NULL THEN 'Booked' "
                + "        ELSE 'Available' "
                + "    END AS seat_status, "
                + "    s.seat_price, "
                + "    sr.room_name, "
                + "    st.start_time, "
                + "    st.end_time, "
                + "    m.title AS movie_title, "
                + "    c.name AS cinema_name, "
                + "    c.address AS cinema_address "
                + "FROM "
                + "    Seat s "
                + "JOIN "
                + "    ScreeningRoom sr ON s.room_id = sr.room_id "
                + "JOIN "
                + "    Cinema c ON sr.cinema_id = c.cinema_id "
                + "JOIN "
                + "    Showtime st ON sr.room_id = st.room_id "
                + "LEFT JOIN "
                + "    TicketSeat ts ON s.seat_id = ts.seat_id and ts.showtime_id = st.showtime_id "
                + "LEFT JOIN "
                + "    Ticket t ON ts.ticket_id = t.ticket_id AND t.showtime_id = st.showtime_id "
                + "LEFT JOIN "
                + "    Movie m ON st.movie_id = m.movie_id "
                + "WHERE "
                + "    st.showtime_id = ?"; // Sử dụng tham số

        List<Seat> seatInfoList = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập giá trị showtimeId vào câu truy vấn
            pstmt.setInt(1, showtimeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy thông tin từ ResultSet
                    int seatId = rs.getInt("seat_id");
                    String seatNumber = rs.getString("seat_number");
                    String seatType = rs.getString("seat_type");
                    String seatStatus = rs.getString("seat_status");
                    BigDecimal seatPrice = rs.getBigDecimal("seat_price");
                    String roomName = rs.getString("room_name");
                    Timestamp startTime = rs.getTimestamp("start_time");
                    Timestamp endTime = rs.getTimestamp("end_time");
                    String movieTitle = rs.getString("movie_title");
                    String cinemaName = rs.getString("cinema_name");
                    String cinemaAddress = rs.getString("cinema_address");

                    // Tạo đối tượng SeatInfo từ dữ liệu truy vấn
                    Seat seatInfo = new Seat(seatId, seatNumber, seatType, seatStatus, seatPrice, roomName, startTime, endTime, movieTitle, cinemaName, cinemaAddress);
                    seatInfoList.add(seatInfo);
                }
            }
            System.out.println("Thanh Cong");
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error retrieving seat status by showtimeId", ex);
        }

        // Trả về danh sách thông tin ghế
        return seatInfoList;
    }

    // Hàm lấy Cinema bằng ID từ database
    public static Cinema getCinemaById(int cinemaId) {
        // Câu truy vấn SQL để lấy thông tin cinema
        String query = "SELECT * FROM Cinema WHERE cinema_id = ?";

        // Kết nối tới database
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập giá trị cho câu lệnh truy vấn
            pstmt.setInt(1, cinemaId);

            // Thực thi câu lệnh truy vấn
            try (ResultSet rs = pstmt.executeQuery()) {
                // Nếu tìm thấy cinema với ID tương ứng
                if (rs.next()) {
                    // Tạo đối tượng Cinema từ dữ liệu trả về
                    Cinema cinema = new Cinema();
                    cinema.setCinemaId(rs.getInt("cinema_id"));
                    cinema.setName(rs.getString("name"));
                    cinema.setAddress(rs.getString("address"));
                    cinema.setPhoneNumber(rs.getString("phone_number"));
                    cinema.setEmail(rs.getString("email"));
                    cinema.setStatus(rs.getString("status"));

                    return cinema;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Xử lý ngoại lệ
        }

        // Nếu không tìm thấy cinema, trả về null
        return null;
    }

    // Hàm cập nhật thông tin Cinema
    public boolean updateCinema(Cinema cinema) {
        // Câu truy vấn SQL để cập nhật thông tin rạp chiếu
        String query = "UPDATE Cinema SET name = ?, address = ?, phone_number = ?, email = ?, status = ? WHERE cinema_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập giá trị cho các cột cần cập nhật
            pstmt.setString(1, cinema.getName());
            pstmt.setString(2, cinema.getAddress());
            pstmt.setString(3, cinema.getPhoneNumber());
            pstmt.setString(4, cinema.getEmail());
            pstmt.setString(5, cinema.getStatus());
            pstmt.setInt(6, cinema.getCinemaId());

            // Thực thi câu lệnh update
            int rowsUpdated = pstmt.executeUpdate();

            // Nếu số dòng được cập nhật lớn hơn 0, nghĩa là cập nhật thành công
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Trả về false nếu việc cập nhật thất bại
        return false;
    }

    public boolean areSeatsAvailable(List<Integer> seatIds, int showtimeId) {
        String query = "SELECT seat_id FROM TicketSeat WHERE seat_id IN ("
                + seatIds.stream().map(String::valueOf).collect(Collectors.joining(","))
                + ") AND showtime_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, showtimeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                // Nếu ResultSet có kết quả nghĩa là ghế đó đã được đặt
                if (rs.next()) {
                    return false;  // Ít nhất một ghế đã được đặt
                }
            }
            System.out.println("Duma");
        } catch (SQLException ex) {
            Logger.getLogger(Cinema_DB.class.getName()).log(Level.SEVERE, "Error checking seat availability", ex);
        }

        return true;  // Tất cả ghế còn trống
    }

}
