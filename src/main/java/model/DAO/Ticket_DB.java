package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Ticket;
import static model.DAO.DBinfo.*;

public class Ticket_DB {

    public Ticket_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Ticket> getAllTickets(int staffId, int month, int year) {
        String query = "SELECT t.ticket_id, t.showtime_id, t.price, t.customer_id, t.purchase_date, "
                + "c.name AS cinema_name, sr.room_name AS screening_room, m.title AS movie_title, "
                + "cu.name AS customer_name, st.start_time, "
                + "se.seat_number AS seat_number "
                + "FROM Ticket t "
                + "JOIN Showtime st ON t.showtime_id = st.showtime_id "
                + "JOIN ScreeningRoom sr ON st.room_id = sr.room_id "
                + "JOIN Cinema c ON sr.cinema_id = c.cinema_id "
                + "JOIN Staff s ON c.cinema_id = s.cinema_id "
                + "JOIN Movie m ON st.movie_id = m.movie_id "
                + "JOIN TicketSeat ts ON t.ticket_id = ts.ticket_id "
                + "JOIN Seat se ON ts.seat_id = se.seat_id "
                + "JOIN Customer cu ON t.customer_id = cu.customer_id "
                + "WHERE s.staff_id = ? "
                + "AND MONTH(t.purchase_date) = ? "
                + "AND YEAR(t.purchase_date) = ?";

        ArrayList<Ticket> tickets = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, staffId);
            pstmt.setInt(2, month);
            pstmt.setInt(3, year);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int ticketId = rs.getInt("ticket_id");
                    int showtimeId = rs.getInt("showtime_id");
                    double price = rs.getDouble("price");
                    int customerId = rs.getInt("customer_id");
                    String purchaseDate = rs.getString("purchase_date");
                    String cinemaName = rs.getString("cinema_name");
                    String screeningRoom = rs.getString("screening_room");
                    String movieTitle = rs.getString("movie_title");
                    String customerName = rs.getString("customer_name");
                    String showtimeStart = rs.getString("start_time");

                    // Khởi tạo danh sách ghế và thêm số ghế vào danh sách
                    List<String> seatNames = new ArrayList<>();
                    seatNames.add(rs.getString("seat_number"));

                    // Kiểm tra nếu vé đã có trong danh sách rồi, nếu có thì thêm số ghế
                    Ticket ticket = tickets.stream()
                            .filter(t -> t.getTicketId() == ticketId)
                            .findFirst()
                            .orElse(null);

                    if (ticket == null) {
                        ticket = new Ticket(ticketId, showtimeId, price, customerId, purchaseDate, cinemaName,
                                screeningRoom, seatNames, movieTitle, customerName, showtimeStart);
                        tickets.add(ticket);
                    } else {
                        // Nếu vé đã có, chỉ cần thêm ghế vào danh sách ghế
                        ticket.getSeatNames().addAll(seatNames);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, "Error retrieving tickets", ex);
        }
        return tickets; // Trả về ArrayList các vé
    }

    public static Map<Integer, int[]> getTicketStatsForYear(int staffId, int year) {
        // Khởi tạo map để lưu số vé bán và doanh thu cho từng tháng (12 tháng)
        Map<Integer, int[]> monthlyStats = new HashMap<>();

        for (int month = 1; month <= 12; month++) {
            String query = "SELECT COUNT(t.ticket_id) AS ticketsSold, SUM(t.price) AS totalRevenue "
                    + "FROM Ticket t "
                    + "JOIN Showtime st ON t.showtime_id = st.showtime_id "
                    + "JOIN ScreeningRoom sr ON st.room_id = sr.room_id "
                    + "JOIN Cinema c ON sr.cinema_id = c.cinema_id "
                    + "JOIN Staff s ON c.cinema_id = s.cinema_id "
                    + "WHERE s.staff_id = ? "
                    + "AND MONTH(t.purchase_date) = ? "
                    + "AND YEAR(t.purchase_date) = ?";

            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

                // Thiết lập giá trị tham số cho câu truy vấn
                pstmt.setInt(1, staffId);
                pstmt.setInt(2, month);
                pstmt.setInt(3, year);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int ticketsSold = rs.getInt("ticketsSold");
                        double totalRevenue = rs.getDouble("totalRevenue");

                        // Lưu số vé bán và doanh thu vào map
                        monthlyStats.put(month, new int[]{ticketsSold, (int) totalRevenue});
                    } else {
                        // Nếu không có dữ liệu, đặt vé bán = 0 và doanh thu = 0
                        monthlyStats.put(month, new int[]{0, 0});
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, "Error retrieving ticket stats", ex);
            }
        }

        return monthlyStats; // Trả về Map chứa số liệu của 12 tháng
    }

    public static int countTicketsByMovie(int movieId) {
        String query = "SELECT COUNT(t.ticket_id) AS ticketsSold "
                + "FROM Ticket t "
                + "JOIN Showtime st ON t.showtime_id = st.showtime_id "
                + "JOIN Movie m ON st.movie_id = m.movie_id "
                + "WHERE m.movie_id = ? AND m.status = 'Active'";

        int ticketsSold = 0;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Thiết lập giá trị tham số cho câu truy vấn
            pstmt.setInt(1, movieId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Lấy số lượng vé bán từ kết quả truy vấn
                    ticketsSold = rs.getInt("ticketsSold");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, "Error counting tickets for movie", ex);
        }

        return ticketsSold; // Trả về số vé đã bán
    }

    public static Integer addTicket(int showtimeId, double price, int customerId, Date purchaseDate,
            Integer promotionId, double discountAmount, Integer comboId,
            String status, List<Integer> seatIds) {

        String ticketQuery = "INSERT INTO Ticket (showtime_id, price, customer_id, purchase_date, promotion_id, discount_amount, combo_id, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        String ticketSeatQuery = "INSERT INTO TicketSeat (ticket_id, seat_id, showtime_id) "
                + "VALUES (?, ?, ?)";

        Integer ticketId = null; // Biến để lưu ticketId vừa được thêm

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmtTicket = con.prepareStatement(ticketQuery, Statement.RETURN_GENERATED_KEYS)) {

            // Thiết lập giá trị tham số cho câu truy vấn Ticket
            pstmtTicket.setInt(1, showtimeId);
            pstmtTicket.setDouble(2, price);
            pstmtTicket.setInt(3, customerId);
            pstmtTicket.setTimestamp(4, new java.sql.Timestamp(purchaseDate.getTime())); // Chuyển đổi Date sang Timestamp
            pstmtTicket.setObject(5, promotionId); // Có thể là NULL
            pstmtTicket.setDouble(6, discountAmount);
            pstmtTicket.setObject(7, comboId); // Có thể là NULL
            pstmtTicket.setString(8, status);

            // Thực hiện truy vấn để thêm Ticket
            int rowsAffectedTicket = pstmtTicket.executeUpdate();

            if (rowsAffectedTicket > 0) {
                // Lấy ID của Ticket vừa thêm
                ResultSet rs = pstmtTicket.getGeneratedKeys();
                if (rs.next()) {
                    ticketId = rs.getInt(1);

                    // Chèn thông tin vào bảng TicketSeat cho từng ghế
                    try (PreparedStatement pstmtTicketSeat = con.prepareStatement(ticketSeatQuery)) {
                        for (Integer seatId : seatIds) {
                            pstmtTicketSeat.setInt(1, ticketId);
                            pstmtTicketSeat.setInt(2, seatId);
                            pstmtTicketSeat.setInt(3, showtimeId);
                            pstmtTicketSeat.addBatch(); // Thêm vào batch
                        }
                        pstmtTicketSeat.executeBatch(); // Thực hiện batch update
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, "Error adding ticket", ex);
        }

        return ticketId; // Trả về ticketId nếu thêm thành công, ngược lại trả về null
    }

    public static boolean deleteTicket(int ticketId) {
        String deleteTicketSeatQuery = "DELETE FROM TicketSeat WHERE ticket_id = ?";
        String deleteTicketQuery = "DELETE FROM Ticket WHERE ticket_id = ?";

        boolean isDeleted = false; // Biến kiểm tra xem việc xóa có thành công hay không

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmtTicketSeat = con.prepareStatement(deleteTicketSeatQuery); PreparedStatement pstmtTicket = con.prepareStatement(deleteTicketQuery)) {

            // Xóa các hàng trong bảng TicketSeat dựa vào ticketId
            pstmtTicketSeat.setInt(1, ticketId);
            int rowsAffectedTicketSeat = pstmtTicketSeat.executeUpdate();

            // Xóa vé trong bảng Ticket dựa vào ticketId
            pstmtTicket.setInt(1, ticketId);
            int rowsAffectedTicket = pstmtTicket.executeUpdate();

            // Nếu cả hai bảng đều bị xóa thành công
            if (rowsAffectedTicketSeat > 0 && rowsAffectedTicket > 0) {
                isDeleted = true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(Ticket_DB.class.getName()).log(Level.SEVERE, "Error deleting ticket", ex);
        }

        return isDeleted; // Trả về true nếu xóa thành công, ngược lại false
    }

}
