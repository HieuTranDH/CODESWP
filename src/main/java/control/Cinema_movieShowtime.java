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

//huydep trai    
    
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
            out.println("<title>Servlet Cinema_movieShowtime</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Cinema_movieShowtime at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
