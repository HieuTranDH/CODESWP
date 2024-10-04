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
import jakarta.servlet.http.HttpSession;
import model.DAO.ScreeningRoom_DB;
import model.ScreeningRoom;

/**
 *
 * @author Admin
 */
public class Staff_screenroom extends HttpServlet {

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
            out.println("<title>Servlet Staff_screenroom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_screenroom at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/staff/dashboards-screenroom.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        // Get the action parameter from the request
        String action = request.getParameter("action");
        ScreeningRoom_DB scrdb = new ScreeningRoom_DB();
        // Extract parameters from the request
        int cinemaId = Integer.parseInt(request.getParameter("cinemaId"));
        String roomName = request.getParameter("roomName");
        int seatCapacity = Integer.parseInt(request.getParameter("seatCapacity"));

        // Switch case based on action
        switch (action) {
            case "addScreeningRoom":

                // Create a new ScreeningRoom object
                ScreeningRoom room = new ScreeningRoom();
                room.setCinemaId(cinemaId);
                room.setRoomName(roomName);
                room.setSeatCapacity(seatCapacity);

                // Add the new ScreeningRoom using the DAO method
                boolean success = scrdb.addNewScreeningRoom(room);

                // Redirect or show a message based on the result
                if (success) {
                    session.setAttribute("message", "Add Success.");
                    response.sendRedirect(request.getContextPath() + "/staff/screenroom");
                } else {
                    session.setAttribute("message", "Add Fail.");
                    response.sendRedirect(request.getContextPath() + "/staff/screenroom");
                }
                break;

            case "editScreeningRoom":
                int roomId = Integer.parseInt(request.getParameter("roomId"));

                ScreeningRoom roomedit = scrdb.getScreeningRoomById(roomId);
                roomedit.setRoomName(roomName);
                roomedit.setSeatCapacity(seatCapacity);
                // Edit the ScreeningRoom using the DAO method
                boolean successedit = ScreeningRoom_DB.editScreeningRoom(roomedit);
                if (successedit) {
                    session.setAttribute("message", "Edit Success.");
                    response.sendRedirect(request.getContextPath() + "/staff/screenroom");
                } else {
                    session.setAttribute("message", "Edit Fail.");
                    response.sendRedirect(request.getContextPath() + "/staff/screenroom");
                }
                break;
        }
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
