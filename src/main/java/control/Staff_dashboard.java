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
        Staff currentStaff = (Staff) session.getAttribute("Staff");

        if (currentStaff != null) {
            String action = request.getParameter("action");

            try {
                switch (action) {
                    case "updateProfile":
//                        updateCustomerInfo(request, currentUser);
                        break;
                    case "updateAvatar":
//                        updateAvatar(request, currentUser);
                        break;
                    case "changePassword":
                        String message = changePassword(request);
                        session.setAttribute("toastMessage", message);
                        break;
                    default:
                        session.setAttribute("toastMessage", "Hành động không hợp lệ.");
                        break;
                }
                // Cập nhật lại session
                Staff updatedUser = Staff_DB.getStaffByEmail(currentStaff.getEmail());
                session.setAttribute("Staff", updatedUser);
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            } catch (Exception e) {
                session.setAttribute("toastMessage", "Có lỗi xảy ra: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            }
        } else {
            session.setAttribute("toastMessage", "Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
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
