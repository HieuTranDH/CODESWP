package control;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.DAO.Customer_DB;
import model.DAO.Staff_DB;
import model.Staff;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.mindrot.jbcrypt.BCrypt;
import util.Constants;
import util.UserGoogleDto;

public class Customer_login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        System.out.println(accessToken);
        UserGoogleDto usergg = getUserInfo(accessToken);
        System.out.println(usergg.getEmail());
        Customer_DB customerDB = new Customer_DB();

        Customer userInfo = customerDB.getCustomerByEmail(usergg.getEmail());
        if (userInfo != null) {
            request.getSession().setAttribute("USER", userInfo);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            String msg = "Email account has not been created yet! ";
            session.setAttribute("message", msg);
            response.sendRedirect("login?value=login");

        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);
        return googlePojo;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer user = (Customer) request.getSession().getAttribute("USER");
        String value = request.getParameter("value");
        if (value == null) {
            if (user == null) {
                processRequest(request, response);
            }
        } else {
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String identifier = request.getParameter("identify");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        Customer_DB customerDB = new Customer_DB();
        Staff_DB staffDB = new Staff_DB(); // Tạo đối tượng Staff_DB để gọi các phương thức cho Staff

        String msg;

        if (staffDB.checkStaffByEmail(identifier)) {
            Staff staff = staffDB.getStaffByEmail(identifier);

            if ("Cancel".equals(staff.getStatus())) {
                msg = "Nhân viên này đã bị vô hiệu hóa.";
                session.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                return;
            }
            String storedPassword = staff.getPassword();

            if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
                if (BCrypt.checkpw(password, storedPassword)) {

                    String role = staff.getRole();
                    if (role.equalsIgnoreCase("Staff")) {
                        session.setAttribute("Staff", staff);
                        handleRememberMe(response, identifier, password, rememberMe);

                        response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                        return;
                    } else if (role.equalsIgnoreCase("Admin")) {
                        session.setAttribute("Admin", staff);
                        handleRememberMe(response, identifier, password, rememberMe);

                        response.sendRedirect(request.getContextPath() + "/staff/listcinema");
                        return;
                    }

                } else {
                    msg = "Mật khẩu không đúng.";
                    session.setAttribute("message", msg);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                }
            } else {
                if (storedPassword.equals(password)) {

                    String role = staff.getRole();
                    if (role.equalsIgnoreCase("Staff")) {
                        session.setAttribute("Staff", staff);
                        handleRememberMe(response, identifier, password, rememberMe);

                        response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                        return;
                    } else if (role.equalsIgnoreCase("Admin")) {
                        session.setAttribute("Admin", staff);
                        handleRememberMe(response, identifier, password, rememberMe);

                        response.sendRedirect(request.getContextPath() + "/staff/listcinema");
                        return;
                    }

                } else {
                    msg = "Mật khẩu không đúng.";
                    session.setAttribute("message", msg);
                    response.sendRedirect(request.getContextPath() + "/login?value=login");
                    return;
                }
            }
        } else {
            Customer customer = customerDB.getCustomerByEmail(identifier);
            if (customer == null) {
                msg = "Email không tồn tại.";
                session.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                return;
            }

            String storedPassword = customer.getPassword();
            if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
                if (BCrypt.checkpw(password, storedPassword)) {

                    session.setAttribute("USER", customer);

                    // Xử lý cookie nếu chọn "Remember me"
                    handleRememberMe(response, identifier, password, rememberMe);

                    response.sendRedirect("/FCM/main");
                    return;
                } else {
                    msg = "Mật khẩu không đúng.";
                    session.setAttribute("message", msg);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                }
            } else {
                if (storedPassword.equals(password)) {

                    session.setAttribute("USER", customer);

                    handleRememberMe(response, identifier, password, rememberMe);

                    response.sendRedirect("/FCM/main");
                    return;
                } else {
                    msg = "Mật khẩu không đúng.";
                    session.setAttribute("message", msg);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                }
            }

        }
    }

    private void handleRememberMe(HttpServletResponse response, String identifier, String password, String rememberMe) {
        if (rememberMe != null && rememberMe.equals("true")) {
            Cookie emailCookie = new Cookie("identify", identifier);
            Cookie passwordCookie = new Cookie("password", password);
            Cookie rememberMeCookie = new Cookie("rememberMe", "true");

            emailCookie.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
            passwordCookie.setMaxAge(60 * 60 * 24 * 30);
            rememberMeCookie.setMaxAge(60 * 60 * 24 * 30);

            response.addCookie(emailCookie);
            response.addCookie(passwordCookie);
            response.addCookie(rememberMeCookie);
        } else {
            Cookie emailCookie = new Cookie("identify", "");
            Cookie passwordCookie = new Cookie("password", "");
            Cookie rememberMeCookie = new Cookie("rememberMe", "");

            emailCookie.setMaxAge(0);
            passwordCookie.setMaxAge(0);
            rememberMeCookie.setMaxAge(0);

            response.addCookie(emailCookie);
            response.addCookie(passwordCookie);
            response.addCookie(rememberMeCookie);
        }
    }



}
