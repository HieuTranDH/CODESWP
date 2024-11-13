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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Cinema;
import model.DAO.Cinema_DB;
import model.Movie;
import model.MovieShowtime;


@WebServlet(name = "Cinema_movieShowtime", urlPatterns = {"/cinema"})
public class Cinema_movieShowtime extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy ngày từ request (nếu có)
        String selectedDateStr = request.getParameter("selectedDate");

        // Nếu không có ngày được chọn, sử dụng ngày hiện tại
        java.util.Date selectedDate;
        if (selectedDateStr == null || selectedDateStr.isEmpty()) {
            selectedDate = new java.util.Date(); // Ngày hiện tại
        } else {
            try {
                // Chuyển chuỗi thành java.util.Date
                java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
                selectedDate = formatter.parse(selectedDateStr);
            } catch (java.text.ParseException e) {
                selectedDate = new java.util.Date(); // Nếu có lỗi khi parse, dùng ngày hiện tại
            }
        }

        // Gọi hàm để lấy danh sách rạp chiếu với suất chiếu
        Cinema_DB cdb = new Cinema_DB();
        List<Cinema> cinemaList = cdb.getAllCinemasWithShowtimes();

        // Gọi hàm để lấy danh sách các bộ phim đang có suất chiếu theo ngày đã chọn
        List<Movie> currentlyShowingMovies = cdb.getMoviesCurrentlyShowing(selectedDate);

        // Đặt danh sách này vào request attribute để chuyển cho trang JSP
        request.setAttribute("cinemas", cinemaList);
        request.setAttribute("currentlyShowingMovies", currentlyShowingMovies); // Danh sách phim đang chiếu theo ngày
        request.setAttribute("selectedDate", selectedDate); // Đặt ngày đã chọn để sử dụng trong JSP

        // Chuyển hướng đến trang JSP để hiển thị thông tin
        request.getRequestDispatcher("/cinema/index.jsp").forward(request, response);
    }

}
