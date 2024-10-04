/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DAO.Staff_DB;
import model.Staff;
import model.Ticket;

/**
 *
 * @author PC
 */
@WebServlet(name = "Staff_ticketManagement", urlPatterns = {"/staff/ticketManagement"})
public class Staff_ticketManagement extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Staff_ticketManagement</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_ticketManagement at " + request.getContextPath() + "</h1>");
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
    // Lấy session và staff từ session
    HttpSession session = request.getSession();
    Staff staff = (Staff) session.getAttribute("Staff");
    
    // Lấy danh sách các vé dựa theo cinemaId
    List<Ticket> tickets = Staff_DB.getTicketDetailsByCinemaId(staff.getCinemaId());
  
   
    request.setAttribute("ticketList", tickets);

    // Kiểm tra xem yêu cầu có phải là AJAX không
    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
        // Trả kết quả cho yêu cầu AJAX (chỉ trả về một phần trang)
        request.getRequestDispatcher("/staff/ticketSearchResult.jsp").forward(request, response);
    } else {
        // Yêu cầu thông thường, tải toàn bộ trang
        request.getRequestDispatcher("/staff/dashboards-ticket.jsp").forward(request, response);
    }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String ticketIdStr = request.getParameter("ticketId");

    if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
        try {
            int ticketId = Integer.parseInt(ticketIdStr);

            // Gọi hàm checkinTicket trong Staff_DB để cập nhật trạng thái vé
            boolean isSuccess = Staff_DB.checkingTicket(ticketId);

            // Kiểm tra kết quả và đặt thông báo tương ứng
            if (isSuccess) {
                 request.getSession().setAttribute("msg", "check-in vé Success!");
            } else {
                request.getSession().setAttribute("msg", "Không thể check-in vé hoặc vé không tồn tại.");
            }

        } catch (NumberFormatException e) {
           request.getSession().setAttribute("msg", "ID vé không hợp lệ.");
        } catch (Exception e) {
            
            request.getSession().setAttribute("msg", "Đã xảy ra lỗi khi xử lý yêu cầu.");
        }
    } else {
        request.getSession().setAttribute("msg", "Vui lòng nhập ID vé.");
    }

    // Forward lại trang quản lý vé
     response.sendRedirect(request.getContextPath() + "/staff/ticketManagement");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
