package control;

import com.vnpay.common.ajaxServlet;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Combo;
import model.DAO.Cinema_DB;
import model.DAO.Combo_DB;
import model.DAO.Promotion_DB;
import model.DAO.Ticket_DB;
import model.Promotion;
import model.Seat;
import model.Ticket;


@WebServlet(name = "Customer_buyTicket", urlPatterns = {"/buyticket"})
public class Customer_buyTicket extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập mã ký tự cho phản hồi
        response.setContentType("text/html;charset=UTF-8");

        // Khởi tạo các biến cần thiết
        List<Seat> seats = new ArrayList<>();
        List<Combo> combos = new ArrayList<>();
        List<Promotion> promotions = new ArrayList<>(); // Danh sách khuyến mãi
        HttpSession session = request.getSession();

        // Xóa các thuộc tính liên quan trong session nếu có tồn 
        session.removeAttribute("ticketId");
        session.removeAttribute("totalPrice");

        // Lấy showtimeId từ request
        String showtimeIdParam = request.getParameter("showtimeId");

        // Kiểm tra xem showtimeId có tồn tại và hợp lệ hay không
        if (showtimeIdParam != null) {
            try {
                int showtimeId = Integer.parseInt(showtimeIdParam); // Chuyển đổi thành số nguyên

                Cinema_DB cdb = new Cinema_DB();
                // Gọi phương thức để lấy thông tin ghế dựa trên showtimeId
                seats = cdb.getSeatStatusByShowtimeId(showtimeId);

                Combo_DB comboDB = new Combo_DB();
                combos = comboDB.getAllCombo(); // Giả sử bạn có phương thức này để lấy danh sách combos

                // Lấy danh sách khuyến mãi đang hoạt động
                Promotion_DB promotionDB = new Promotion_DB();
                promotions = promotionDB.getActivePromotions(); // Gọi phương thức để lấy khuyến mãi đang hoạt động

            } catch (NumberFormatException e) {
                Logger.getLogger(Customer_buyTicket.class.getName()).log(Level.WARNING, "Invalid showtimeId format", e);
                request.setAttribute("errorMessage", "Showtime ID không hợp lệ.");
            }
        } else {
            request.setAttribute("errorMessage", "Showtime ID là bắt buộc.");
        }

        request.setAttribute("seats", seats);
        request.setAttribute("combos", combos);  // Thêm danh sách combo vào request
        request.setAttribute("promotions", promotions); // Thêm danh sách khuyến mãi vào request
        request.setAttribute("showtimeId", showtimeIdParam);

        // Chuyển tiếp tới JSP để hiển thị thông tin ghế, combo và khuyến mãii
        RequestDispatcher dispatcher = request.getRequestDispatcher("test.jsp"); // Thay đổi tên tệp JSP theo nhu cầu
        dispatcher.forward(request, response);

        // Xóa thông báo lỗi khỏi session sau  xử lý

        session.removeAttribute("errorMessage");
    }


   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    Integer showtimeId = null;
    Integer customerId = null;
    Integer promotionId = null;
    Integer comboId = null;
    double totalPrice = 0.0;
    List<Integer> selectedSeats = new ArrayList<>();
    HttpSession session = request.getSession();
    session.removeAttribute("ticketId");
    session.removeAttribute("totalPrice");

    try {
        System.out.println("Starting doPost method...");

        // Lấy các tham số từ request
        String showtimeIdParam = request.getParameter("showtimeId");
        String customerIdParam = request.getParameter("customerId");
        String promotionIdParam = request.getParameter("selectedPromotionId"); // Sửa ở đây
        String comboIdParam = request.getParameter("comboId");
        String totalPriceParam = request.getParameter("totalPrice");
        String selectedSeatParam = request.getParameter("selectedSeats");

        // In ra các tham số
        System.out.println("Showtime ID: " + showtimeIdParam);
        System.out.println("Customer ID: " + customerIdParam);
        System.out.println("Promotion ID: " + promotionIdParam); // Kiểm tra ID khuyến mãi
        System.out.println("Combo ID: " + comboIdParam);
        System.out.println("Total Price: " + totalPriceParam);
        System.out.println("Selected Seats: " + selectedSeatParam);

        // Chuyển đổi các tham số đầu vào
        if (showtimeIdParam != null) {
            showtimeId = Integer.parseInt(showtimeIdParam);
            System.out.println("Showtime ID: " + showtimeId);
        }
        if (customerIdParam != null) {
            customerId = Integer.parseInt(customerIdParam);
            System.out.println("Customer ID: " + customerId);
        }
        if (totalPriceParam != null) {
            totalPrice = Double.parseDouble(totalPriceParam);
            System.out.println("Total Price: " + totalPrice);
        }
        if (promotionIdParam != null && !promotionIdParam.isEmpty()) {
            promotionId = Integer.parseInt(promotionIdParam);
            System.out.println("Promotion ID: " + promotionId);
        }
        if (comboIdParam != null && !comboIdParam.isEmpty()) {
            comboId = Integer.parseInt(comboIdParam);
            System.out.println("Combo ID: " + comboId);
        }
        if (selectedSeatParam != null && !selectedSeatParam.isEmpty()) {
            String[] selectedSeatArray = selectedSeatParam.split(",");
            for (String seatParam : selectedSeatArray) {
                selectedSeats.add(Integer.parseInt(seatParam));
            }
            System.out.println("Selected Seats: " + selectedSeats);
        }


        Cinema_DB cdb = new Cinema_DB();
        boolean allSeatsAvailable = cdb.areSeatsAvailable(selectedSeats, showtimeId);
        System.out.println("Seats available: " + allSeatsAvailable);

        if (!allSeatsAvailable) {
            // Nếu một hoặc nhiều ghế đã được đặt, hiển thị thông báo lỗi và dừng quá trình đặt 

            System.out.println("Error: One or more seats are already booked.");
            session.setAttribute("errorMessage", "Một hoặc nhiều ghế đã được đặt. Vui lòng chọn lại ghế khác.");
            response.sendRedirect(request.getContextPath() + "/buyticket?showtimeId=" + showtimeId);
            System.out.println("Redirected to buyticket page due to seat booking issue.");
            return; // Kết thúc hàm nếu ghế đã được đặt
        }


        // Nếu tất cả ghế đều có sẵn, tiếp tục lưu vé
        Date purchaseDate = new Date();
        Ticket_DB ticketDAO = new Ticket_DB();
        Integer ticketId = ticketDAO.addTicket(showtimeId, totalPrice, customerId, purchaseDate,
                promotionId, 0.0, comboId, "NotCheckin", selectedSeats);
        System.out.println("Ticket ID: " + ticketId);


        // Kiểm tra kết quả lưu vé
        if (ticketId == null) {
            System.out.println("Error: Ticket booking failed.");
            request.setAttribute("errorMessage", "Đặt vé không thành công. Vui lòng thử lại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } else {

            // Lưu dữ liệu vào session
            session.setAttribute("ticketId", ticketId);
            session.setAttribute("totalPrice", totalPrice);
            System.out.println("Redirecting to PaymentServlet...");
            // Gọi trực tiếp doPost của PaymentServlet
            ajaxServlet paymentServlet = new ajaxServlet();
            paymentServlet.doPost(request, response);  // Gọi doPost của PaymentServlet

            // Log sau khi gọi doPost
            System.out.println("Called doPost of PaymentServlet.");
        }

    } catch (NumberFormatException e) {
        // Xử lý lỗi nếu dữ liệu đầu vào không hợp lệ
        System.out.println("Error: Invalid input data. " + e.getMessage());
        request.setAttribute("errorMessage", "Thông tin đầu vào không hợp lệ. Vui lòng thử lại.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    } catch (Exception e) {
        // Bắt lỗi chung để biết vấn đề tiềm ẩn
        System.out.println("Error: An unexpected error occurred. " + e.getMessage());
        request.setAttribute("errorMessage", "Có lỗi xảy ra. Vui lòng thử lại.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}

}
