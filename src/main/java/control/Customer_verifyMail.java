/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.DAO.Customer_DB;

/**
 *
 * @author ThanhDuoc
 */
@WebServlet(name = "Customer_verifyMail", urlPatterns = {"/verify"})
public class Customer_verifyMail extends HttpServlet {

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
            out.println("<title>Servlet Customer_verifyMail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Customer_verifyMail at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String status = request.getParameter("status");
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String x = request.getParameter("x");
        String number = request.getParameter("number");
        Customer_DB userDB = new Customer_DB();

        HttpSession session = request.getSession();

        String msg;
        if (status.equals("lostaccount")) {
            if (Integer.parseInt(x) == Integer.parseInt(number)) {
                request.setAttribute("email", email);
                request.getRequestDispatcher("/auth/newpass.jsp").forward(request, response);
            } else {
                msg = "Verify Code Is Wrong!";
                request.setAttribute("message", msg);
                request.setAttribute("x", x);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
            }
        } else {
            if (Integer.parseInt(x) == Integer.parseInt(number)) {
                // Passwords match, proceed to add new staff
                Customer newUser = new Customer(userName, email, password);
                userDB.addUser(newUser);

                msg = "Registration Success";
//                request.setAttribute("message", msg);
                session.setAttribute("message", msg);
//                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                response.sendRedirect("login?value=login");
            } else {
                msg = "Verify Code Is Wrong!";
                request.setAttribute("message", msg);
                request.setAttribute("x", x);
                request.setAttribute("userName", userName);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
