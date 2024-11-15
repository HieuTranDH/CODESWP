package control;

import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Cinema;
import model.DAO.Cinema_DB;
import model.DAO.Staff_DB;
import model.Staff;

@WebServlet(name = "Admin_RegisterStaffAcount", urlPatterns = {"/staff/registerStaffAcount"})
public class Admin_registerStaffAcount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Staff> staffList = Staff_DB.getAllStaffWithCinema();
        List<Staff> filteredStaffList = new ArrayList<>();
        for (Staff staff : staffList) {
            if (!"Admin".equalsIgnoreCase(staff.getRole())) {
                filteredStaffList.add(staff);
            }
        }
        request.setAttribute("staffList", filteredStaffList);
        List<Cinema> cinemaList = Cinema_DB.getAvailableCinemas();

        request.setAttribute("cinemaList", cinemaList);
        request.getRequestDispatcher("/staff/dashboards-staff.jsp").forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action"); // Get the action parameter
        HttpSession session = request.getSession();

         if ("register".equals(action)) {
        handleStaffRegistration(request, response, session);
    } else if ("updateProfile".equals(action)) {
        handleStaffUpdate(request, response, session);
    } 
   }

    private void handleStaffRegistration(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String email = request.getParameter("staffEmail");
        String userName = request.getParameter("staffName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("rePassword");

        Staff_DB staffDB = new Staff_DB();
        List<Staff> staffList = staffDB.getAllStaff(); // Retrieve the list of staff
        boolean checkEmail = true;
        boolean checkUsername = true;

        for (Staff staff : staffList) {
            if (staff.getEmail().equals(email)) {
                checkEmail = false;
                break;
            }
        }

        for (Staff staff : staffList) {
            if (staff.getName().equals(userName)) {
                checkUsername = false;
                break;
            }
        }

        String msg;

        if (!password.equals(confirmPassword)) {
            msg = "Mật khẩu xác nhận không khớp. Error";
            session.setAttribute("msg", msg);
            response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
        } else {
            if (!checkEmail) {
                msg = "Email này đã tồn tại. Error";
                session.setAttribute("msg", msg);
                response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
            } else if (!checkUsername) {
                msg = "Tên người dùng này đã tồn tại. Error";
                session.setAttribute("msg", msg);
                response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
            } else {
                String role = "Staff"; // Assign role "Staff"
                Staff newStaff = new Staff(userName, email, "", password, role);
                boolean isRegistered = staffDB.addStaff(newStaff); // Assumed method to register staff

                if (isRegistered) {
                    msg = "Đăng ký thành công!";
                    session.setAttribute("msg", msg);
                    response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
                } else {
                    msg = "Có Error xảy ra trong quá trình đăng ký.";
                    session.setAttribute("msg", msg);
                    response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
                }
            }
        }
    }

    private void handleStaffUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String email = request.getParameter("staffEmail");
        String userName = request.getParameter("staffName");
        String phoneNumber = request.getParameter("staffPhone"); // Retrieve phone number
        int cinemaId = Integer.parseInt(request.getParameter("cinemaId")); // Retrieve cinema ID
        int staffId = Integer.parseInt(request.getParameter("staffId")); // Assuming staffId is passed in the request
        String status = request.getParameter("status");
        Staff_DB staffDB = new Staff_DB();
        Staff existingStaff = staffDB.getStaffById(staffId); // Method to get existing staff by ID
        
        String msg;

        if (existingStaff == null) {
            msg = "Nhân viên không tồn tại.";
            session.setAttribute("msg", msg);
            response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
            return;
        }

        Staff staff = new Staff(staffId, userName, email, phoneNumber, cinemaId,status);

        boolean isUpdated = staffDB.updateStaff(staff);

        if (isUpdated) {
            msg = "Cập nhật Success!";
        } else {
            msg = "Có lỗi xảy ra trong quá trình cập nhật.";
        }

        session.setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
    }

}
