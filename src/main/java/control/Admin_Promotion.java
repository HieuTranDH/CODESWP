
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

public class Admin_Promotion extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/staff/dashboards-promotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Promotion_DB pdb = new Promotion_DB();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        switch (action) {
            case "editdiscount":
                try {
                    //pro
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

                    session.setAttribute("message", "Edit Success.");
                    response.sendRedirect("promotion");

                } catch (ParseException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
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

                    session.setAttribute("message", "Add Success.");
                    response.sendRedirect("promotion");

                } catch (ParseException | IOException | NumberFormatException e) {
                    e.printStackTrace();
                }
                break;

            case "deletepromotion":
                int promotionId = Integer.parseInt(request.getParameter("promotionId"));
                Promotion promotion = pdb.getPromotionById(promotionId);
                promotion.setStatus("Expired");

                pdb.updatePromotion(promotion);

                session.setAttribute("message", "Delete Success.");
                response.sendRedirect("promotion");
                break;
        }
    }



}
