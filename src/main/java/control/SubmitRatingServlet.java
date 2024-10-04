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
import java.sql.SQLException;
import model.Customer;
import model.DAO.Movie_DB;

/**
 *
 * @author ThanhDuoc
 */
@WebServlet(name = "SubmitRatingServlet", urlPatterns = {"/submitRating"})
public class SubmitRatingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy các giá trị từ form
        Customer cus = (Customer) request.getSession().getAttribute("USER");

        int movieId = Integer.parseInt(request.getParameter("movieId"));
        float rating = Float.parseFloat(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        Movie_DB mdb = new Movie_DB();
        // Gọi hàm insert vào database
        try {
            mdb.insertRating(movieId, cus.getCustomerId(), rating, comment);
            // Chuyển hướng sau khi thành công
            response.sendRedirect("/FCM/profile");
        } catch (SQLException e) {
            e.printStackTrace();
            // Chuyển hướng nếu có lỗi
            response.sendRedirect("/FCM/profile");
        }
    }

}
