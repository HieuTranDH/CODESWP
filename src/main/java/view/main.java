/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package view;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAO.Movie_DB;
import model.Movie;


@WebServlet(name = "main", urlPatterns = {"/main"})
public class main extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Movie_DB mb = new Movie_DB();

        // Tính toán lại điểm trung bình cho tất cả các phim
        mb.updateAllMoviesAverageRating();

        // Lấy danh sách tất cả các phim từ cơ sở dữ liệu
        List<Movie> movies = mb.getTop8RecentMovies();

        // Lấy phim có điểm đánh giá cao nhất
        Movie topRatedMovie = mb.getTopRatedMovie();

        // Đặt danh sách phim và phim có điểm cao nhất vào thuộc tính của request
        request.setAttribute("movies", movies);
        request.setAttribute("topRatedMovie", topRatedMovie);

        // Chuyển tiếp yêu cầu đến trang index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}
