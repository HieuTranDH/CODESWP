/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.DAO.Movie_DB;
import model.DAO.ScreeningRoom_DB;
import model.DAO.Staff_DB;
import model.Movie;
import model.ScreeningRoom;
import model.Showtime;
import model.Staff;


@WebServlet(name = "Admin_showTimeManagement", urlPatterns = {"/staff/showTimeManagement"})
public class Admin_showTimeManagement extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Admin_showTimeManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_showTimeManagement at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("Staff");

        if (staff != null) {
            // Lấy danh sách các phòng chiếu theo cinemaId của Staff
            List<ScreeningRoom> screeningRoomList = ScreeningRoom_DB.getAllRoomsByCinemaId(staff.getCinemaId());
            request.setAttribute("screeningRoomList", screeningRoomList);
        }
        List<Movie> movieList = Movie_DB.getAllMovies();
        request.setAttribute("movieList", movieList);
// Chuyển hướng đến trang dashboards-showTime.jsp
        request.getRequestDispatcher("/staff/dashboards-showTime.jsp").forward(request, response);
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
        String action = request.getParameter("action"); // Lấy tham số action từ request

        switch (action) {
            case "createShowtime":
                createShowtime(request, response);
                break;
            case "addShowtimeDefault":
                addShowtimeDefault(request, response);
                break;
            case "deleteShowtime":
                deleteShowtime(request, response);
                break;
            case "updateShowtime":
                updateShowtime(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void createShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ request
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String selectedDate = request.getParameter("selectedDate");  // Lấy ngày đã chọn
        String startTime = request.getParameter("startTime");  // Lấy thời gian bắt đầu
        String endTime = request.getParameter("endTime");  // Lấy thời gian kết thúc

        // Kết hợp ngày đã chọn với giờ để tạo DateTime
        String startDateTime = selectedDate + " " + startTime + ":00";  // Định dạng đầy đủ DateTime
        String endDateTime = selectedDate + " " + endTime + ":00";  // Định dạng đầy đủ DateTime

        ScreeningRoom_DB db = new ScreeningRoom_DB();
        List<Showtime> existingShowtimes = db.getShowtimesByRoomAndDate(roomId, selectedDate); // Method to fetch existing showtimes

        boolean hasConflict = false;
        for (Showtime existingShowtime : existingShowtimes) {
            // Check for overlapping showtimes
            if (isOverlapping(startDateTime, endDateTime, existingShowtime.getStartTime(), existingShowtime.getEndTime())) {
                hasConflict = true;
                break;
            }
        }
        List<Showtime> existingEndtimes = db.getShowtimesByRoomAndDate(roomId, endDateTime);
        // Check for 15-minute gap
        if (!hasConflict) {
            for (Showtime existingShowtimeEnd : existingEndtimes) {
                String existingEndTime = existingShowtimeEnd.getEndTime();
                // Check if the new showtime starts within 15 minutes after the existing showtime ends
                if (isWithinFifteenMinutes(existingEndTime, startDateTime)) {
                    hasConflict = true;
                    break;
                }
            }
        }

        if (hasConflict) {
            request.getSession().setAttribute("msg", "Không thể thêm showtime, giờ chiếu trùng lặp hoặc không đủ khoảng cách 15 phút!");
            response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
            return;
        }

        Showtime showtime = new Showtime();
        showtime.setStartTime(startDateTime);
        showtime.setEndTime(endDateTime);
        showtime.setRoomId(roomId);
        showtime.setMovieId(movieId);

        // Gọi phương thức addShowTime từ lớp DB
        boolean isSuccess = db.addShowTime(showtime);

        if (isSuccess) {
            request.getSession().setAttribute("msg", "Thêm show time Success!");
        } else {
            request.getSession().setAttribute("msg", "Thêm show time bại!");
        }
        response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
    }

    private void updateShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ request
        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String selectedDate = request.getParameter("selectedDate");
        String startTime = request.getParameter("startTime");  // Lấy thời gian bắt đầu
        String endTime = request.getParameter("endTime");  // Lấy thời gian kết thúc

        // Kết hợp ngày đã chọn với giờ để tạo DateTime
        String startDateTime = selectedDate + " " + startTime + ":00";  // Định dạng đầy đủ DateTime
        String endDateTime = selectedDate + " " + endTime + ":00";  // Định dạng đầy đủ DateTime

        ScreeningRoom_DB db = new ScreeningRoom_DB();
        List<Showtime> existingShowtimes = db.getShowtimesByRoomAndDate(roomId, selectedDate); // Method to fetch existing showtimes

        boolean hasConflict = false;
        for (Showtime existingShowtime : existingShowtimes) {
            // Check for overlapping showtimes
            if (isOverlapping(startDateTime, endDateTime, existingShowtime.getStartTime(), existingShowtime.getEndTime())) {
                hasConflict = true;
                break;
            }
        }
        List<Showtime> existingEndtimes = db.getShowtimesByRoomAndDate(roomId, endDateTime);
        // Check for 15-minute gap
        if (!hasConflict) {
            for (Showtime existingShowtimeEnd : existingEndtimes) {
                String existingEndTime = existingShowtimeEnd.getEndTime();
                // Check if the new showtime starts within 15 minutes after the existing showtime ends
                if (isWithinFifteenMinutes(existingEndTime, startDateTime)) {
                    hasConflict = true;
                    break;
                }
            }
        }

        if (hasConflict) {
            request.getSession().setAttribute("msg", "Không thể thêm showtime, giờ chiếu trùng lặp hoặc không đủ khoảng cách 15 phút!");
            response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
            return;
        }
        Showtime showtime = new Showtime();
        showtime.setShowtimeId(showtimeId);
        showtime.setMovieId(movieId);
        showtime.setRoomId(roomId);
        showtime.setStartTime(startDateTime);
        showtime.setEndTime(endDateTime);

        // Gọi phương thức updateShowtime từ lớp DB
        boolean isSuccess = db.updateShowtime(showtime);

        if (isSuccess) {
            request.getSession().setAttribute("msg", "Update show time Success!");
        } else {
            request.getSession().setAttribute("msg", "Update show time bại!");
        }
        response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
    }

    private void deleteShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số showtimeId từ request
        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));

        // Tạo đối tượng của lớp DAO để tương tác với cơ sở dữ liệu
        ScreeningRoom_DB showtimeDAO = new ScreeningRoom_DB();

        // Xóa suất chiếu dựa trên showtimeId
        boolean isDeleted = showtimeDAO.deleteShowtime(showtimeId);

        // Kiểm tra kết quả của việc xóa và chuyển hướng hoặc thông báo cho người dùng
        if (isDeleted) {
            // Nếu xóa thành công, chuyển hướng về trang quản lý suất chiếu với thông báo thành công
            request.getSession().setAttribute("msg", "Xóa suất chiếu  Success!");
            response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
        } else {
            // Nếu xóa không thành công, hiển thị thông báo lỗi
            request.getSession().setAttribute("msg", "Xóa suất chiếu thất bại!");
            response.sendRedirect(request.getContextPath() + "/staff/showTimeManagement");
        }
    }

    private void addShowtimeDefault(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập mã hóa cho request và response
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Đọc dữ liệu JSON từ request
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        String jsonData = jsonBuilder.toString();

        // Chuyển đổi chuỗi JSON thành đối tượng JSON
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jsonData, JsonObject.class);

        // Lấy các giá trị từ đối tượng JSON
        int movieId = jsonObject.get("movieId").getAsInt();
        String startTime = jsonObject.get("startTime").getAsString();
        String endTime = jsonObject.get("endTime").getAsString();
        JsonArray selectedDays = jsonObject.getAsJsonArray("selectedDays");
        JsonArray selectedRooms = jsonObject.getAsJsonArray("selectedRooms");

        ScreeningRoom_DB db = new ScreeningRoom_DB();
        boolean success = true;
        StringBuilder conflictMessage = new StringBuilder();

        // Lặp qua các ngày và phòng chiếu
        for (JsonElement dayElement : selectedDays) {
            String selectedDate = dayElement.getAsString();
            for (JsonElement roomElement : selectedRooms) {
                int roomId = roomElement.getAsInt();

                // Lấy danh sách suất chiếu hiện có
                List<Showtime> existingShowtimes = db.getShowtimesByRoomAndDate(roomId, selectedDate);
                boolean hasConflict = false;

                // Kiểm tra xung đột với các suất chiếu hiện có
                for (Showtime existingShowtime : existingShowtimes) {
                    String existingStartTime = existingShowtime.getStartTime();
                    String existingEndTime = existingShowtime.getEndTime();

                    // Kiểm tra xung đột thời gian
                    if (isOverlapping(selectedDate + " " + startTime, selectedDate + " " + endTime, existingStartTime, existingEndTime)
                            || isWithinFifteenMinutes2(existingEndTime, selectedDate + " " + startTime)) {
                        hasConflict = true;
                        conflictMessage.append("Xung đột showtime cho phòng ").append(roomId).append(" vào ngày ").append(selectedDate).append(".\n");
                        success = false;
                        break;
                    }
                }

                if (!hasConflict) {
                    // Thêm suất chiếu mới nếu không có xung đột
                    Showtime newShowtime = new Showtime();
                    newShowtime.setMovieId(movieId);
                    newShowtime.setRoomId(roomId);
                    newShowtime.setStartTime(selectedDate + " " + startTime);
                    newShowtime.setEndTime(selectedDate + " " + endTime);

                    boolean isSuccess = db.addShowTime(newShowtime);
                    if (!isSuccess) {
                        conflictMessage.append("Thêm showtime thất bại cho phòng ").append(roomId).append(" vào ngày ").append(selectedDate).append(".\n");
                        success = false;
                    }
                }
            }
        }

        // Tạo phản hồi JSON
        JsonObject jsonResponse = new JsonObject();
        if (success) {
            jsonResponse.addProperty("message", "Thêm tất cả showtime Success!");
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("redirectUrl", request.getContextPath() + "/staff/showTimeManagement");
        } else {
            jsonResponse.addProperty("message", conflictMessage.toString());
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("redirectUrl", request.getContextPath() + "/staff/showTimeManagement");
        }

// Gửi phản hồi về client
        PrintWriter out = response.getWriter();
        out.write(gson.toJson(jsonResponse));
        System.out.println("JSON Response: " + gson.toJson(jsonResponse));// Chuyển đổi đối tượng JSON thành chuỗi và gửi đi
        out.flush();
    }

    private boolean isOverlapping(String start1, String end1, String start2, String end2) {
        // Suất chiếu bị trùng khi:
        // - Suất 1 bắt đầu trước khi suất 2 kết thúc và kết thúc sau khi suất 2 bắt đầu
        // - Đồng thời, không được trùng khớp với giờ bắt đầu và giờ kết thúc của suất chiếu hiện tại
        return (start1.compareTo(end2) < 0 && end1.compareTo(start2) > 0)
                || start1.equals(start2) || end1.equals(end2);
    }

// Helper method to check if a start time is within 15 minutes after an end time
    private boolean isWithinFifteenMinutes(String endTime, String startTime) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date end = sdf.parse(endTime);
            Date start = sdf.parse(startTime);

            long differenceInMinutes = (start.getTime() - end.getTime()) / (60 * 1000);
            return differenceInMinutes < 15 && differenceInMinutes > 0;
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean isWithinFifteenMinutes2(String endTime, String startTime) {
        try {

            // Định dạng cho ngày và giờ
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            Date end = sdf.parse(endTime);
            Date start = sdf.parse(startTime);

            long differenceInMinutes = (start.getTime() - end.getTime()) / (60 * 1000);
            return differenceInMinutes < 15 && differenceInMinutes > 0;
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
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
