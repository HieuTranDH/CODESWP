
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cinema;
import model.DAO.Cinema_DB;
import model.DAO.Staff_DB;
import model.Staff;

/**
 *
 * @author KAILEGION
 */
public class Admin_ListCinema extends HttpServlet {

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
            out.println("<title>Servlet Admin_ListCinema</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_ListCinema at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/staff/dashboards-listcinema.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        System.out.println(action);
        Cinema_DB cdb = new Cinema_DB();
        Staff_DB sdb = new Staff_DB();
        if (action.equals("add")) {
            String name = request.getParameter("cinemaName");
            String address = request.getParameter("cinemaAddress");
            String phone = request.getParameter("cinemaPhone");
            String email = request.getParameter("cinemaEmail");
// Gọi phương thức addCinema để thêm cinema vào database

  boolean success = cdb.addCinema(name, address, phone, email);

            if (success) {
                session.setAttribute("message", "Add Success.");
                // Nếu thêm thành công, chuyển hướng về trang danh sách cinema hoặc trang khác
                response.sendRedirect(request.getContextPath() + "/staff/listcinema");
            } else {
                // Nếu có lỗi, thông báo lỗi và quay về trang form
                request.setAttribute("message", "Error adding cinema. Please try again.");
                response.sendRedirect(request.getContextPath() + "/staff/listcinema");
            }

 
        } else if (action.equals("edit")) {
            String id = request.getParameter("cinemaID");
            String name = request.getParameter("cinemaName");
            String address = request.getParameter("cinemaAddress");
            String phone = request.getParameter("cinemaPhone");
            String email = request.getParameter("cinemaEmail");
            int idnew = Integer.parseInt(id);
            Cinema c = cdb.getCinemaById(idnew);
            c.setName(name);
            c.setAddress(address);
            c.setPhoneNumber(phone);
            c.setEmail(email);
            boolean ed = cdb.updateCinema(c);
         
        } else if (action.equals("deletecinema")) {
            int id = Integer.parseInt(request.getParameter("cinemaId"));
            Cinema c = cdb.getCinemaById(id);
            c.setStatus("close");
            Staff st = cdb.getStaffByCinemaID(id);
            if (st != null) {
                st.setCinemaId(0);
                boolean changestaff = sdb.updateStaff(st);
            }

            boolean de = cdb.updateCinema(c);
            if (de) {
                session.setAttribute("message", "Delete Success.");
                // Nếu thêm thành công, chuyển hướng về trang danh sách cinema hoặc trang khác
                response.sendRedirect(request.getContextPath() + "/staff/listcinema");
            } else {
                // Nếu có lỗi, thông báo lỗi và quay về trang form
                request.setAttribute("message", "Error Delete cinema. Please try again.");
                response.sendRedirect(request.getContextPath() + "/staff/listcinema");
            }
        } else {
            // Lấy staffId từ request
      
            int cinemaid = Integer.parseInt(request.getParameter("cinemaid"));

            // Lấy đối tượng Staff từ database
            Staff staff = cdb.getStaffByCinemaID(cinemaid);  // Giả sử bạn có phương thức này

            // Đặt Staff vào session
            session.setAttribute("Staff2", staff);

            // Chuyển hướng đến trang dashboard
            response.sendRedirect(request.getContextPath() + "/staff/dashboard");
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
