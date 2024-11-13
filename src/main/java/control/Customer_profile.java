package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Customer;
import model.DAO.Customer_DB;
import model.Ticket;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10 MB
public class Customer_profile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Customer_profile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Customer_profile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại nếu có
        if (session != null) {
            Customer user = (Customer) session.getAttribute("USER"); // Lấy đối tượng User từ session
            if (user != null) {
                Integer customerId = user.getCustomerId(); // Lấy customerId từ đối tượng User
                if (customerId != null) {
                    Customer_DB cdb = new Customer_DB();
                    // Gọi hàm lấy thông tin ticket theo ticket_id giảm dần
                    List<Ticket> ticketDetails = cdb.getTicketDetails(customerId);
                    request.setAttribute("ticketDetails", ticketDetails);
                }
            }
        }
        request.getRequestDispatcher("user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer currentUser = (Customer) session.getAttribute("USER");

        if (currentUser != null) {
            String action = request.getParameter("action");

            try {
                switch (action) {
                    case "updateProfile":
                        updateCustomerInfo(request, currentUser);
                        break;
                    case "updateAvatar":
                        updateAvatar(request, currentUser);
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
                Customer updatedUser = Customer_DB.getCustomerByEmail(currentUser.getEmail());
                session.setAttribute("USER", updatedUser);
                response.sendRedirect(request.getContextPath() + "/profile");
            } catch (Exception e) {
                session.setAttribute("toastMessage", "Có lỗi xảy ra: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/profile");
            }
        } else {
            session.setAttribute("toastMessage", "Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        }

        response.getWriter().flush();
    }

    private void updateCustomerInfo(HttpServletRequest request, Customer currentUser) throws ParseException {
        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone");
        String location = request.getParameter("location");
        String birthdateStr = request.getParameter("birthdate");

        try {
            if (name == null || name.isEmpty()) {
                throw new IllegalArgumentException("Tên không được để trống.");
            }

            currentUser.setName(name);
            currentUser.setPhoneNumber(phoneNumber);
            currentUser.setLocation(location);

            if (birthdateStr != null && !birthdateStr.isEmpty()) {
                java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(birthdateStr);
                currentUser.setBirthdate(new java.sql.Date(date.getTime()));
            } else {
                currentUser.setBirthdate(null);
            }

            // Cập nhật thông tin khách hàng
            Customer_DB.updateCustomerInfo(currentUser);
            session.setAttribute("msg", "Cập nhật thông tin Success.");
        } catch (Exception e) {
            session.setAttribute("msg", "Cập nhật thông tin thất bại: " + e.getMessage());
        }
    }

    private void updateAvatar(HttpServletRequest request, Customer currentUser) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Part avatarPart = request.getPart("avatar");

        if (avatarPart != null && avatarPart.getSize() > 0) {
            try {
                String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdir();
                }

                String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadDir + File.separator + fileName;
                avatarPart.write(filePath);

                String avatarPath = "uploads/" + fileName;
                currentUser.setAvatar(avatarPath);

                // Cập nhật avatar
                Customer_DB.updateAvatar(currentUser);
                session.setAttribute("msg", "Cập nhật avatar Success.");
            } catch (Exception e) {
                session.setAttribute("msg", "Cập nhật avatar thất bại: " + e.getMessage());
            }
        } else {
            session.setAttribute("msg", "Không có avatar được chọn.");
        }
    }

    private String changePassword(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("USER");

        if (user == null) {
            session.setAttribute("msg", "Vui lòng đăng nhập.");
            return "Vui lòng đăng nhập.";
        }

        //

        Customer_DB userDB = new Customer_DB();

        try {
            if (!userDB.checkCurrentPassword(email, currentPassword)) {
                session.setAttribute("msg", "Mật khẩu hiện tại không đúng.");
                return "Mật khẩu hiện tại không đúng.";
            }

            // Mã hóa mật khẩu mới trước khi cập nhật
            boolean updateSuccess = userDB.changePass(email, newPassword);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
