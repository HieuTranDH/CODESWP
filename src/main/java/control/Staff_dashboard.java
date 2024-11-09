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
import model.Customer;
import model.DAO.Customer_DB;
import model.DAO.Staff_DB;
import model.Staff;

/**
 *
 * @author PC
 */
@WebServlet(name = "Staff_dashboard", urlPatterns = {"/staff/dashboard"})
public class Staff_dashboard extends HttpServlet {

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
            out.println("<title>Servlet Staff_dashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Staff_dashboard at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/staff/index.jsp").forward(request, response);

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
        Staff currentStaff = null;
        Staff currentAdmin = null;

// Kiểm tra xem session có chứa Staff hay Admin
        if (session.getAttribute("Staff") != null) {
            currentStaff = (Staff) session.getAttribute("Staff");
        } else if (session.getAttribute("Admin") != null) {
            currentAdmin = (Staff) session.getAttribute("Admin");
        }

        if (currentStaff != null || currentAdmin != null) {
            String action = request.getParameter("action");

            try {
                String message1 = ""; // Khai báo trước để tránh NullPointerException

                switch (action) {
                    case "updateInfo":
                        int id = Integer.parseInt(request.getParameter("id"));
                        String name = request.getParameter("name");
                        String phoneNumber = request.getParameter("phoneNumber");

                        // Cập nhật thông tin cho Admin
                        if (currentAdmin != null) {
                            message1 = updateStaffInfo(currentAdmin.getStaffId(), name, phoneNumber); // Giả sử updateStaffInfo dùng cho cả Admin
                            session.setAttribute("msg", message1);

                            // Cập nhật lại session Admin
                            Staff updatedAdmin = Staff_DB.getStaffById(currentAdmin.getStaffId());
                            if (updatedAdmin != null) {
                                session.setAttribute("Admin", updatedAdmin);
                            } else {
                                request.setAttribute("msg", "Không tìm thấy thông tin Admin.");
                            }

                            response.sendRedirect(request.getHeader("Referer")); // Chuyển hướng về trang hiện tại
                            return;
                        } else if (currentStaff != null) {
                            // Cập nhật thông tin cho Staff
                            message1 = updateStaffInfo(currentStaff.getStaffId(), name, phoneNumber);
                            session.setAttribute("msg", message1);

                            // Cập nhật lại session Staff
                            Staff updatedUser = Staff_DB.getStaffById(currentStaff.getStaffId());
                            if (updatedUser != null) {
                                session.setAttribute("Staff", updatedUser);
                            } else {
                                request.setAttribute("msg", "Không tìm thấy thông tin nhân viên.");
                            }

                            response.sendRedirect(request.getHeader("Referer")); // Chuyển hướng về trang hiện tại
                            return; // Dừng thực thi tại đây
                        }
                        break;

                    case "updateAvatar":
                        // updateAvatar(request, currentUser);
                        break;

                    case "changePassword":
                        String message2 = changePassword(request);
                        session.setAttribute("msg", message2);
                        break;

                    default:
                        session.setAttribute("msg", "Hành động không hợp lệ.");
                        break;
                }

                // Nếu không redirect trong case "updateInfo", sẽ chuyển hướng về trang dashboard
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            } catch (Exception e) {
                session.setAttribute("msg", "Có lỗi xảy ra: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            } finally {
                // Thêm khối finally nếu cần thiết để làm sạch tài nguyên hoặc xử lý khác
            }

            if (currentAdmin == null && currentStaff == null) {
                session.setAttribute("msg", "Vui lòng đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/login");

            }
        }
    }

    private String changePassword(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("Staff");

        if (staff == null) {
            session.setAttribute("msg", "Vui lòng đăng nhập.");
            return "Vui lòng đăng nhập.";
        }

        String email = staff.getEmail();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmNewPassword)) {
            session.setAttribute("msg", "Mật khẩu mới và xác nhận không khớp.");
            return "Mật khẩu mới và xác nhận không khớp.";
        }

        Staff_DB staffDB = new Staff_DB();

        try {
            if (!staffDB.checkCurrentPassword(email, currentPassword)) {
                session.setAttribute("msg", "Mật khẩu hiện tại không đúng.");
                return "Mật khẩu hiện tại không đúng.";
            }

            // Mã hóa mật khẩu mới trước khi cập nhật
            boolean updateSuccess = staffDB.changePass(email, newPassword);
            if (updateSuccess) {
                session.setAttribute("msg", "Đổi mật khẩu Success.");
                return "Đổi mật khẩu thành công.";
            } else {
                session.setAttribute("msg", "Đổi mật khẩu thất bại.");
                return "Đổi mật khẩu thất bại.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Đã xảy ra lỗi khi đổi mật khẩu.");
            return "Đã xảy ra lỗi khi đổi mật khẩu.";
        }
    }

    private String updateStaffInfo(int id, String name, String phoneNumber) {
        // Lấy thông tin hiện tại của nhân viên
        Staff currentStaff = Staff_DB.getStaffById(id);

        if (currentStaff != null) {
            currentStaff.setName(name);
            currentStaff.setPhoneNumber(phoneNumber);

            // Gọi đến phương thức trong Staff_DB để thực hiện cập nhật
            boolean updateSuccess = Staff_DB.updateStaffInfo(currentStaff);
            return updateSuccess ? "Cập nhật thông tin Success." : "Cập nhật thông tin thất bại.";
        } else {
            return "Nhân viên không tồn tại.";
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
