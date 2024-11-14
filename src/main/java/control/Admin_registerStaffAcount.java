
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
            out.println("<title>Servlet Admin_ResigterStaffAcount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_ResigterStaffAcount at " + request.getContextPath() + "</h1>");
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

        List<Staff> staffList = Staff_DB.getAllStaffWithCinema();
        // Lọc những nhân viên có vai trò "admin"
        List<Staff> filteredStaffList = new ArrayList<>();
        for (Staff staff : staffList) {
            if (!"Admin".equalsIgnoreCase(staff.getRole())) {
                filteredStaffList.add(staff);
            }
        }
        request.setAttribute("staffList", filteredStaffList);
        List<Cinema> cinemaList = Cinema_DB.getAvailableCinemas();

        request.setAttribute("cinemaList", cinemaList);
        // Chuyển hướng tới JSP để hiển thị danh sách Staff
        request.getRequestDispatcher("/staff/dashboards-staff.jsp").forward(request, response);

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

        

        

        String msg;

        
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

     

        Staff staff = new Staff(staffId, userName, email, phoneNumber, cinemaId,status);

        // Call update method without password
        boolean isUpdated = staffDB.updateStaff(staff);

        if (isUpdated) {
            msg = "Cập nhật Success!";
        } else {
            msg = "Có lỗi xảy ra trong quá trình cập nhật.";
        }

        session.setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/staff/registerStaffAcount");
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
