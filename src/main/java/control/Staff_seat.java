/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import model.DAO.ScreeningRoom_DB;
import model.DAO.Seat_DB;
import model.ScreeningRoom;
import model.Seat;
public class Staff_seat extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Staff_seat</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_seat at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the roomId from the request parameter
        String roomId1 = request.getParameter("value");
        int roomId = Integer.parseInt(roomId1);
        // Optionally, you can store the roomId in the request scope
        request.setAttribute("roomId", roomId);

        // Forward the request to seat.jsp
        request.getRequestDispatcher("/staff/seat.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int roomId = Integer.parseInt(request.getParameter("roomid")); // roomId từ form
        ScreeningRoom scr = ScreeningRoom_DB.getScreeningRoomById(roomId);
        if ("add".equals(action)) {
            String seatNumber = request.getParameter("seatNumber");

            // Kiểm tra và loại bỏ các ký tự không mong muốn nếu có: dấu [ ], dấu nháy đơn ' và dấu cách
            seatNumber = seatNumber.replaceAll("[\\[\\]' ]", "");  // Loại bỏ tất cả dấu [ ] ' và khoảng trắng

            String seatType = request.getParameter("seatType");
            BigDecimal seatPrice = new BigDecimal(request.getParameter("seatPrice"));

            // Tạo đối tượng Seat mới với các tham số phù hợp
            Seat newSeat = new Seat(0, seatNumber, seatType, seatPrice); // Constructor đúng của Seat

            // Thêm ghế vào DB
            boolean success = Seat_DB.addSeatNone(roomId, newSeat); // roomId được truyền vào từ form
            scr.setSeatCapacity(scr.getSeatCapacity() + 1);
            boolean edit = ScreeningRoom_DB.editScreeningRoom(scr);
            if (success) {
                request.setAttribute("message", "Seat added successfully.");
            } else {
                request.setAttribute("message", "Failed to add seat.");
            }

        } else if ("delete".equals(action)) {
            int seatId = Integer.parseInt(request.getParameter("seatId"));

            // Xóa ghế từ DB
            boolean success = Seat_DB.deleteSeat(seatId);
            scr.setSeatCapacity(scr.getSeatCapacity() - 1);
            boolean edit = ScreeningRoom_DB.editScreeningRoom(scr);
            if (success) {
                request.setAttribute("message", "Seat deleted successfully.");
            } else {
                request.setAttribute("message", "Failed to delete seat.");
            }
        }

        
        response.sendRedirect("seat?value=" + roomId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
