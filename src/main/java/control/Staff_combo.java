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
import model.Combo;
import model.DAO.Combo_DB;

/**
 *
 * @author Admin
 */
public class Staff_combo extends HttpServlet {

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
            out.println("<title>Servlet Staff_combo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_combo at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/staff/combo.jsp").forward(request, response);
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
        String action = request.getParameter("action");

        // Switch case dựa trên action
        switch (action) {
            case "addcombo":
                String comboName = request.getParameter("comboName");
                double comboPrice = Double.parseDouble(request.getParameter("comboPrice"));
                String description = request.getParameter("description");
                Combo com = new Combo(1, comboName, comboPrice, description, "open");
                Combo_DB.AddCombo(com);
                session.setAttribute("message", "Add Success.");
                response.sendRedirect("combo");
                break;

            case "editcombo":
                int comboId = Integer.parseInt(request.getParameter("comboId"));
                String comboName1 = request.getParameter("comboName");
                double comboPrice1 = Double.parseDouble(request.getParameter("comboPrice"));
                String description1 = request.getParameter("description");
                String status1 = request.getParameter("status");
                Combo c = Combo_DB.getCombobyID(comboId);
                c.setComboName(comboName1);
                c.setComboPrice(comboPrice1);
                c.setDescription(description1);
                c.setStatus(status1);
                Combo_DB.editCombo(c);
                session.setAttribute("message", "Edit Success.");
                response.sendRedirect("combo");
                break;

            case "deletecombo":
                int comboId1 = Integer.parseInt(request.getParameter("comboId"));
                Combo c1 = Combo_DB.getCombobyID(comboId1);
                c1.setStatus("Stop");
                Combo_DB.editCombo(c1);
                session.setAttribute("message", "Delete Success.");
                response.sendRedirect("combo");
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
