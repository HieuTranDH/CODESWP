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
import java.util.ArrayList;
import java.util.Random;
import model.Customer;
import model.DAO.Customer_DB;
import util.Email;

public class Customer_register extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Customer_register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Customer_register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        if (request.getSession().getAttribute("USER") != null) {
            // Nếu đã đăng nhập, chuyển hướng đến trang chính
            response.sendRedirect(response.encodeRedirectURL("home"));
        } else {
            // Nếu chưa đăng nhập, hiển thị trang đăng nhập
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("userEmail");
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("rePassword");

        Customer_DB customerDB = new Customer_DB();
        ArrayList<Customer> customerList = customerDB.getAllCustomers(); // Lấy danh sách khách hàng
        boolean checkEmail = true;
        boolean checkUsername = true;

        for (Customer customer : customerList) {
            if (customer.getEmail().equals(email)) {
                checkEmail = false;
                break;
            }
        }

        for (Customer customer : customerList) {
            if (customer.getName().equals(userName)) {
                checkUsername = false;
                break;
            }
        }

        String msg;

        if (!password.equals(confirmPassword)) {
            msg = "Mật khẩu xác nhận không khớp.";
            request.setAttribute("message", msg);
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        } else {
            if (!checkEmail && checkUsername) {
                msg = "Email này đã tồn tại.";
                request.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            }

            if (checkEmail && checkUsername) {
                int x = new Random().nextInt(90000) + 10000;
                Email.sendEmail(email, x);

                // Cài đặt thuộc tính cho JSP xác thực
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
