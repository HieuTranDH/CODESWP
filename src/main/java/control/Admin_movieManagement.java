/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAO.Movie_DB;
import model.DAO.Staff_DB;
import model.Movie;

/**
 *
 * @author PC
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10 MB
@WebServlet(name = "Admin_movieManagement", urlPatterns = {"/staff/movieManagement"})
public class Admin_movieManagement extends HttpServlet {

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
            out.println("<title>Servlet Admin_movieManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_movieManagement at " + request.getContextPath() + "</h1>");
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
        List<Movie> movieList = Movie_DB.getAllMovies();
        request.setAttribute("movieList", movieList);

        request.getRequestDispatcher("/staff/dashboards-movieMn.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/movieManagement");
            return;
        }

        switch (action) {
            case "createMovie":
                createMovie(request, response);
                break;
            case "update":
                // Xử lý cập nhật phim ở đây
                editMovie(request, response);
                break;
            case "delete":
                // Xử lý xóa phim ở đây
                deleteMovie(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/staff/movieManagement");
        }
    }

    private void createMovie(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String genre = request.getParameter("genre");
        String releaseDateStr = request.getParameter("releaseDate");
        String description = request.getParameter("description");

        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy/MM/dd");

        String formattedReleaseDate = releaseDateStr;
        try {
            java.util.Date date = originalFormat.parse(releaseDateStr);
            formattedReleaseDate = targetFormat.format(date);
        } catch (ParseException e) {
            Logger.getLogger(Admin_movieManagement.class.getName()).log(Level.SEVERE, "Error formatting release date", e);
        }

        // Xử lý file ảnh poster
        Part filePart = request.getPart("poster");
        String poster = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Xử lý tải ảnh lên
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + "uploads";  // Thư mục lưu ảnh

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // Tạo thư mục nếu chưa tồn tại
            }

            String fileName = getFileName(filePart);
            filePart.write(uploadFilePath + File.separator + fileName);

            // Đường dẫn đến poster (có thể điều chỉnh cho phù hợp với ứng dụng)
            poster = "uploads/" + fileName;
        }

        // Mặc định status là "Coming soon"
        String status = "Coming soon";

        // Tạo đối tượng Movie từ dữ liệu form
        Movie movie = new Movie(title, duration, genre, formattedReleaseDate, description, status, poster, 0.00);

        // Gọi method createMovie từ Staff_DB để lưu vào cơ sở dữ liệu
        boolean isCreated = Staff_DB.createMovie(movie);

        // Đẩy thông báo thành công hoặc thất bại vào session
        if (isCreated) {
            request.getSession().setAttribute("msg", "Thêm bộ phim Success!");
        } else {
            request.getSession().setAttribute("msg", "Thêm bộ phim thất bại!");
        }

        // Redirect về trang quản lý phim
        response.sendRedirect(request.getContextPath() + "/staff/movieManagement");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }

    private void editMovie(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String title = request.getParameter("title");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String genre = request.getParameter("genre");
        String releaseDateStr = request.getParameter("releaseDate");
        String description = request.getParameter("description");

// Định dạng ngày tháng từ form
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy/MM/dd");

        String formattedReleaseDate = releaseDateStr;
        try {
            java.util.Date date = originalFormat.parse(releaseDateStr);
            formattedReleaseDate = targetFormat.format(date);
        } catch (ParseException e) {
            Logger.getLogger(Admin_movieManagement.class.getName()).log(Level.SEVERE, "Error formatting release date", e);
        }

// Xử lý file ảnh poster
        Part filePart = request.getPart("poster");
        String poster = request.getParameter("currentPoster");  // Lấy giá trị poster hiện tại nếu không có thay đổi

// Kiểm tra xem người dùng có chọn ảnh mới không
        if (filePart != null && filePart.getSize() > 0) {
            // Xử lý tải ảnh mới lên
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + "uploads";  // Thư mục lưu ảnh

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // Tạo thư mục nếu chưa tồn tại
            }

            String fileName = getFileName(filePart);
            filePart.write(uploadFilePath + File.separator + fileName);

            // Cập nhật đường dẫn đến poster mới
            poster = "uploads/" + fileName;
        }

        // Mặc định status là "Coming soon" nếu không được nhập từ form
        String status = request.getParameter("status") != null ? request.getParameter("status") : "Coming soon";

        // Tạo đối tượng Movie từ dữ liệu form
        Movie movie = new Movie(movieId, title, duration, genre, formattedReleaseDate, description, status, poster, 0.00);

        // Gọi phương thức updateMovie từ DAO/service để cập nhật phim
        boolean isUpdated = Staff_DB.updateMovie(movie);

        // Kiểm tra xem quá trình cập nhật có thành công không
        if (isUpdated) {
            // Nếu cập nhật thành công, chuyển hướng về trang quản lý phim
            request.getSession().setAttribute("msg", "Update bộ phim Success!");
        } else {
            // Nếu thất bại, chuyển hướng với thông báo lỗi
            request.getSession().setAttribute("msg", "Update bộ phim thất bại!");
        }
        response.sendRedirect(request.getContextPath() + "/staff/movieManagement");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Logic xóa phim
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
