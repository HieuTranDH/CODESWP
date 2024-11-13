package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Random;
import model.Customer;
import model.DAO.Customer_DB;
import static util.Email.sendEmail;


@WebServlet(name = "Customer_lostAccount", urlPatterns = {"/lostaccount"})
public class Customer_lostAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/auth/lost-account.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("identify");
        Customer_DB userDB = new Customer_DB();
        String msg;
        Customer users = null;
        ArrayList<Customer> userlist = userDB.getAllCustomers();
        boolean checkMail = false;
        for (Customer us : userlist) {
            if (us.getEmail().equals(email)) {
                users = us;
                checkMail = true;
                break;
            }
        }
        if (checkMail) {
            int x = new Random().nextInt(90000) + 10000;
            sendEmail(email, x);
            request.setAttribute("x", x);
            request.setAttribute("email", email);
            request.setAttribute("status", "lostaccount");
            request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
        } else {
            msg = "Email not found. Please try again!";
            request.setAttribute("message", msg);
            request.getRequestDispatcher("/auth/lost-account.jsp").forward(request, response);
        }
    }


}
