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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DAO.Staff_DB;
import model.Staff;
import model.Ticket;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author PC
 */
@WebServlet(name = "Staff_searchTicket", urlPatterns = {"/staff/searchTicket"})
public class Staff_searchTicket extends HttpServlet {

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
            out.println("<title>Servlet Staff_searchTicket</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_searchTicket at " + request.getContextPath() + "</h1>");
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
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Lấy ticketId từ request
    String ticketIdStr = request.getParameter("ticketId");

    try {
        if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
            // Tìm vé theo ticketId
            int ticketId = Integer.parseInt(ticketIdStr);
            Ticket ticket = Staff_DB.searchTicketById(ticketId);

            if (ticket != null) {
                // Tạo đối tượng JSON cho vé tìm được
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("ticketId", ticket.getTicketId());
                jsonResponse.put("showtimeId", ticket.getShowtimeId());
                jsonResponse.put("price", ticket.getPrice());
                jsonResponse.put("customerId", ticket.getCustomerId());
                jsonResponse.put("purchaseDate", ticket.getPurchaseDate());
                jsonResponse.put("status", ticket.getStatus());
                jsonResponse.put("customerName", ticket.getCustomerName());
                jsonResponse.put("movieTitle", ticket.getMovieTitle());
                jsonResponse.put("screeningRoom", ticket.getScreeningRoom());
                jsonResponse.put("seatNames", ticket.getSeatNames());
                jsonResponse.put("showtimeStart", ticket.getShowtimeStart());

                // Trả về JSON response của vé đã tìm thấy
                response.getWriter().write(jsonResponse.toString());
            } else {
                // Trả về lỗi nếu không tìm thấy vé
                response.getWriter().write("{\"error\":\"Ticket not found\"}");
            }
        } else {
            // Trả về lỗi nếu không có ticketId
            response.getWriter().write("{\"error\":\"Ticket ID is required\"}");
        }
    } catch (NumberFormatException e) {
        response.getWriter().write("{\"error\":\"Invalid ticket ID format\"}");
    } catch (JSONException e) {
        response.getWriter().write("{\"error\":\"JSON error occurred\"}");
    } catch (Exception e) {
        response.getWriter().write("{\"error\":\"An error occurred\"}");
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
         // Thiết lập kiểu trả về là JSON
      
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
