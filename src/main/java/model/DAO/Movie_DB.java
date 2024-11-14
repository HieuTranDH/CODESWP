
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.driver;
import model.Movie;
import model.MovieRating;
import model.Showtime;

/**
 *
 * @author ThanhDuoc
 */
public class Movie_DB implements DBinfo {

    public Movie_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static List<Movie> getAllMovies() {
        String query = "SELECT movie_id, title, duration, genre, release_date, description, status, poster, average_rating "
                + "FROM Movie "
                + "ORDER BY release_date DESC"; // Sắp xếp theo ngày phát hành gần nhất

        List<Movie> movies = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // Lấy từng giá trị từ ResultSet
                int movieId = rs.getInt("movie_id");
                String title = rs.getString("title");
                int duration = rs.getInt("duration");
                String genre = rs.getString("genre");
                String releaseDate = rs.getString("release_date");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String poster = rs.getString("poster");
                double averageRating = rs.getDouble("average_rating");

                // Tạo đối tượng Movie và thêm vào danh sách
                Movie movie = new Movie(movieId, title, duration, genre, releaseDate, description, status, poster, averageRating);
                movies.add(movie);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error retrieving all movies", ex);
        }
        return movies; // Trả về danh sách các phim
    }

    public static List<Movie> getTop8RecentMovies() {
        String query = "SELECT TOP 8 movie_id, title, duration, genre, release_date, description, status, poster, average_rating "
                + "FROM Movie "
                + "ORDER BY release_date DESC"; // Sắp xếp theo ngày phát hành gần nhất

        List<Movie> recentMovies = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // Lấy từng giá trị từ ResultSet
                int movieId = rs.getInt("movie_id");
                String title = rs.getString("title");
                int duration = rs.getInt("duration");
                String genre = rs.getString("genre");
                String releaseDate = rs.getString("release_date");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String poster = rs.getString("poster");
                double averageRating = rs.getDouble("average_rating");

                // Tạo đối tượng Movie và thêm vào danh sách
                Movie movie = new Movie(movieId, title, duration, genre, releaseDate, description, status, poster, averageRating);
                recentMovies.add(movie);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error retrieving top 8 recent movies", ex);
        }
        return recentMovies; // Trả về danh sách 8 phim gần đây
    }

    public static Movie getMovieById(int movieId) {
        String query = "SELECT m.movie_id, m.title, m.duration, m.genre, m.release_date, "
                + "m.description, m.status, m.poster, COALESCE(AVG(r.rating), 0) AS average_rating "
                + "FROM Movie m "
                + "LEFT JOIN MovieRating r ON m.movie_id = r.movie_id "
                + "WHERE m.movie_id = ? "
                + "GROUP BY m.movie_id, m.title, m.duration, m.genre, m.release_date, "
                + "m.description, m.status, m.poster";

        Movie movie = null;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, movieId); // Thiết lập tham số ID cho câu truy vấn

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Lấy các thông tin của movie từ cơ sở dữ liệu
                    int id = rs.getInt("movie_id");
                    String title = rs.getString("title");
                    int duration = rs.getInt("duration");
                    String genre = rs.getString("genre");
                    String releaseDate = rs.getString("release_date");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String poster = rs.getString("poster");
                    double averageRating = rs.getDouble("average_rating");

                    // Tạo đối tượng Movie
                    movie = new Movie(id, title, duration, genre, releaseDate, description, status, poster, averageRating);

                    // Lấy các đánh giá của phim
                    List<MovieRating> ratings = getRatingsByMovieId(movieId);
                    movie.setRatings(ratings); // Thêm ratings vào movie
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error retrieving movie by ID: " + movieId, ex);
        }
        return movie; // Trả về đối tượng Movie với thông tin và đánh giá
    }

    public static Movie getTopRatedMovie() {
        String query = "SELECT movie_id, title, duration, genre, release_date, description, status, poster, average_rating "
                + "FROM Movie "
                + "WHERE status = 'Active' " // Thêm điều kiện để chỉ lấy phim có status là active
                + "ORDER BY average_rating DESC "
                + "OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY"; // Lấy phim có điểm trung bình cao nhất

        Movie topRatedMovie = null;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                int movieId = rs.getInt("movie_id");
                String title = rs.getString("title");
                int duration = rs.getInt("duration");
                String genre = rs.getString("genre");
                String releaseDate = rs.getString("release_date");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String poster = rs.getString("poster");
                double averageRating = rs.getDouble("average_rating");

                // Tạo đối tượng Movie với tất cả thông tin
                topRatedMovie = new Movie(movieId, title, duration, genre, releaseDate, description, status, poster, averageRating);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return topRatedMovie; // Trả về bộ phim có điểm trung bình cao nhất hoặc null nếu không tìm thấy
    }

    public static double calculateAverageRating(int movieId) {
        String query = "SELECT COALESCE(AVG(r.rating), 0) AS average_rating "
                + "FROM MovieRating r "
                + "WHERE r.movie_id = ?";

        double averageRating = 0;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, movieId); // Thiết lập tham số ID cho câu truy vấn

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    averageRating = rs.getDouble("average_rating");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error calculating average rating for movie ID: " + movieId, ex);
        }

        return averageRating; // Trả về điểm trung bình
    }

    public static void updateAllMoviesAverageRating() {
        String selectQuery = "SELECT movie_id FROM Movie";
        String updateQuery = "UPDATE Movie SET average_rating = ? WHERE movie_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement selectStmt = con.prepareStatement(selectQuery); PreparedStatement updateStmt = con.prepareStatement(updateQuery); ResultSet rs = selectStmt.executeQuery()) {

            while (rs.next()) {
                int movieId = rs.getInt("movie_id");
                double averageRating = calculateAverageRating(movieId); // Sử dụng hàm đã tạo ở trên

                // Cập nhật điểm trung bình vào bảng Movie
                updateStmt.setDouble(1, averageRating);
                updateStmt.setInt(2, movieId);
                updateStmt.executeUpdate();
            }

        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error updating average ratings for all movies", ex);
        }
    }

    public static List<MovieRating> getRatingsByMovieId(int movieId) {
        String query = "SELECT r.rating_id, r.movie_id, r.customer_id, r.rating, r.comment, r.rating_date, c.name AS customer_name "
                + "FROM MovieRating r "
                + "JOIN Customer c ON r.customer_id = c.customer_id "
                + "WHERE r.movie_id = ?";
        List<MovieRating> ratings = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, movieId); // Thiết lập tham số ID cho câu truy vấn

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy các thông tin của đánh giá từ cơ sở dữ liệu
                    int ratingId = rs.getInt("rating_id");
                    int customerId = rs.getInt("customer_id");
                    String customerName = rs.getString("customer_name"); // Lấy tên từ bảng Customer
                    double rating = rs.getDouble("rating");
                    String comment = rs.getString("comment");
                    Date ratingDate = rs.getDate("rating_date");

                    // Tạo đối tượng MovieRating và thêm vào danh sách
                    MovieRating movieRating = new MovieRating(ratingId, movieId, customerId, rating, comment, ratingDate);
                    movieRating.setCustomerName(customerName); // Thêm tên khách hàng vào đối tượng
                    ratings.add(movieRating);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error retrieving ratings for movie ID: " + movieId, ex);
        }

        return ratings; // Trả về danh sách các đánh giá
    }

    public static void insertRating(int movieId, int customerId, float rating, String comment) throws SQLException {
        String query = "INSERT INTO MovieRating (movie_id, customer_id, rating, comment) VALUES (?, ?, ?, ?)";

        // Sử dụng try-with-resources để tự động quản lý tài nguyên
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập các giá trị cho câu lệnh SQL
            pstmt.setInt(1, movieId);
            pstmt.setInt(2, customerId);
            pstmt.setFloat(3, rating);
            pstmt.setString(4, comment);

            // Thực thi câu lệnh
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MovieRating.class.getName()).log(Level.SEVERE, "Error inserting rating", ex);
            throw ex; // Ném lại ngoại lệ để xử lý bên ngoài nếu cần
        }
    }

    public static ArrayList<Movie> getActiveMoviesByStaff(int staffId) {
        // Khởi tạo ArrayList để chứa danh sách các phim
        ArrayList<Movie> movieList = new ArrayList<>();

        // Câu truy vấn SQL để lấy danh sách phim
        String sql = "SELECT m.movie_id, m.title, m.duration, m.genre, m.release_date, "
                + "m.description, m.status, m.poster, m.average_rating, COUNT(t.ticket_id) AS tickets_sold "
                + "FROM Movie m "
                + "JOIN Showtime s ON m.movie_id = s.movie_id "
                + "JOIN ScreeningRoom sr ON s.room_id = sr.room_id "
                + "JOIN Cinema c ON sr.cinema_id = c.cinema_id "
                + "JOIN Staff st ON st.cinema_id = c.cinema_id "
                + "LEFT JOIN Ticket t ON s.showtime_id = t.showtime_id "
                + "WHERE st.staff_id = ? AND m.status = 'Active' "
                + "GROUP BY m.movie_id, m.title, m.duration, m.genre, m.release_date, m.description, m.status, m.poster, m.average_rating "
                + "ORDER BY tickets_sold DESC";

        try (
                // Kết nối cơ sở dữ liệu
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); // Chuẩn bị câu lệnh truy vấn
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            // Gán giá trị staffId vào câu truy vấn
            ps.setInt(1, staffId);

            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua kết quả truy vấn
                while (rs.next()) {
                    // Tạo đối tượng Movie và set các thuộc tính
                    Movie movie = new Movie();
                    movie.setMovieId(rs.getInt("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setReleaseDate(rs.getString("release_date"));
                    movie.setDescription(rs.getString("description"));
                    movie.setStatus(rs.getString("status"));
                    movie.setPoster(rs.getString("poster"));
                    movie.setAverageRating(rs.getDouble("average_rating"));

                    // Thêm movie vào ArrayList
                    movieList.add(movie);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Movie_DB.class.getName()).log(Level.SEVERE, "Error retrieving active movies by staff", ex);
        }

        // Trả về ArrayList các phim
        return movieList;
    }

}
