package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Combo;
import model.DAO.Combo_DB;


public class Staff_combo extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/staff/combo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        switch (action) {
            case "addcombo":
                String comboName = request.getParameter("comboName");
                double comboPrice = Double.parseDouble(request.getParameter("comboPrice"));
                String description = request.getParameter("description");
                Combo com = new Combo(1, comboName, comboPrice, description, "open");
                Combo_DB.AddCombo(com);
                session.setAttribute("message", "Add Success.");
                response.sendRedirect("combo");
                break;

            case "editcombo":
                int comboId = Integer.parseInt(request.getParameter("comboId"));
                String comboName1 = request.getParameter("comboName");
                double comboPrice1 = Double.parseDouble(request.getParameter("comboPrice"));
                String description1 = request.getParameter("description");
                String status1 = request.getParameter("status");
                Combo c = Combo_DB.getCombobyID(comboId);
                c.setComboName(comboName1);
                c.setComboPrice(comboPrice1);
                c.setDescription(description1);
                c.setStatus(status1);
                Combo_DB.editCombo(c);
                session.setAttribute("message", "Edit Success.");
                response.sendRedirect("combo");
                break;

            case "deletecombo":
                int comboId1 = Integer.parseInt(request.getParameter("comboId"));
                Combo c1 = Combo_DB.getCombobyID(comboId1);
                c1.setStatus("Stop");
                Combo_DB.editCombo(c1);
                session.setAttribute("message", "Delete Success.");
                response.sendRedirect("combo");
                break;
        }
    }




}
