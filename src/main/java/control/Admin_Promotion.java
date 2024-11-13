/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.DAO.Promotion_DB;
import model.Promotion;

/**
 *
 * @author Admin
 */
public class Admin_Promotion extends HttpServlet {

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
            out.println("<title>Servlet Admin_Promotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_Promotion at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/staff/dashboards-promotion.jsp").forward(request, response);
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
        Promotion_DB pdb = new Promotion_DB();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        switch (action) {
            case "editdiscount":
                try {
                    int promotionId = Integer.parseInt(request.getParameter("discountId"));
                    String promotionCode = request.getParameter("DiscountCodeInput");
                    String promotionDescription = request.getParameter("DescriptionInput");
                    double maxDiscountAmount = Double.parseDouble(request.getParameter("ConditionInput"));
                    double discountPercentage = Double.parseDouble(request.getParameter("DiscountPercentInput"));
                    int minTicketQuantity = Integer.parseInt(request.getParameter("UsageLimitInput"));
                    int maxTicketQuantity = Integer.parseInt(request.getParameter("UsageCountInput"));
                    String validFromStr = request.getParameter("ValidFromInput");
                    String validToStr = request.getParameter("ValidToInput");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date startDate = dateFormat.parse(validFromStr);
                    Date endDate = dateFormat.parse(validToStr);

                    Promotion promotion = pdb.getPromotionById(promotionId);
                    promotion.setPromotionId(promotionId);
                    promotion.setPromotionCode(promotionCode);
                    promotion.setMaxDiscountAmount(maxDiscountAmount);
                    promotion.setDiscountPercentage(discountPercentage);
                    promotion.setStartDate(startDate);
                    promotion.setEndDate(endDate);
                    promotion.setMinTicketQuantity(minTicketQuantity);
                    promotion.setMaxTicketQuantity(maxTicketQuantity);
                    promotion.setDescription(promotionDescription);
                    pdb.updatePromotion(promotion);

                    // Chuyển hướng sau khi cập nhật thành công
                    session.setAttribute("message", "Edit Success.");
                    response.sendRedirect("promotion");

                } catch (ParseException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace(); // In lỗi ra để theo dõi
                }
                break;
            case "adddiscount":
                try {
                    String promotionCode = request.getParameter("DiscountCodeInput");
                    double maxDiscountAmount = Double.parseDouble(request.getParameter("ConditionInput"));
                    double discountPercentage = Double.parseDouble(request.getParameter("DiscountPercentInput"));
                    int minTicketQuantity = Integer.parseInt(request.getParameter("UsageLimitInput"));
                    int maxTicketQuantity = Integer.parseInt(request.getParameter("UsageCountInput"));
                    String validFromStr = request.getParameter("ValidFromInput");
                    String validToStr = request.getParameter("ValidToInput");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date startDate = dateFormat.parse(validFromStr);
                    Date endDate = dateFormat.parse(validToStr);
                    String promotionDescription = request.getParameter("DescriptionInput");

                    Promotion promotion = new Promotion(1, promotionCode, promotionDescription, discountPercentage, startDate, endDate, minTicketQuantity, maxTicketQuantity, maxDiscountAmount, "Active");

                    pdb.addPromotion(promotion);

                    // Forward the request to the shop page
                    session.setAttribute("message", "Add Success.");
                    response.sendRedirect("promotion");

                } catch (ParseException | IOException | NumberFormatException e) {
                    e.printStackTrace();
                }
            // Print the error (ideally, handle it properly)
                break;

            case "deletepromotion":
                int promotionId = Integer.parseInt(request.getParameter("promotionId"));
                Promotion promotion = pdb.getPromotionById(promotionId);
                promotion.setStatus("Expired");

                pdb.updatePromotion(promotion);

                // Chuyển hướng sau khi cập nhật thành công
                session.setAttribute("message", "Delete Success.");
                response.sendRedirect("promotion");
                break;
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
