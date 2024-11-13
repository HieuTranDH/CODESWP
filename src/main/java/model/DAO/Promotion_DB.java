/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import model.Promotion;

/**
 *
 * @author Admin
 */
public class Promotion_DB {

    public Promotion_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Promotion_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Promotion> getActivePromotions() {
        ArrayList<Promotion> promotions = new ArrayList<>();
        String query = "SELECT * FROM Promotion WHERE status = 'Active'";  // Chỉ lấy các promotion có status là 'Active'

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionId(rs.getInt("promotion_id"));
                promotion.setPromotionCode(rs.getString("promotion_code"));
                promotion.setDescription(rs.getString("description"));
                promotion.setDiscountPercentage(rs.getDouble("discount_percentage"));
                promotion.setStartDate(rs.getDate("start_date"));
                promotion.setEndDate(rs.getDate("end_date"));
                promotion.setMinTicketQuantity(rs.getInt("min_ticket_quantity"));
                promotion.setMaxTicketQuantity(rs.getInt("max_ticket_quantity"));
                promotion.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                promotion.setStatus(rs.getString("status"));

                promotions.add(promotion);
            }
        } catch (SQLException e) {
            Logger.getLogger(Promotion_DB.class.getName()).log(Level.SEVERE, null, e);
        }
        return promotions;
    }

    // Hàm thêm khuyến mãi mới vào cơ sở dữ liệu
    public static void addPromotion(Promotion promotion) {
        String query = "INSERT INTO Promotion (promotion_code, description, discount_percentage, start_date, end_date, min_ticket_quantity, max_ticket_quantity, max_discount_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, promotion.getPromotionCode());
            pstmt.setString(2, promotion.getDescription());
            pstmt.setDouble(3, promotion.getDiscountPercentage());
            pstmt.setDate(4, new java.sql.Date(promotion.getStartDate().getTime()));
            pstmt.setDate(5, new java.sql.Date(promotion.getEndDate().getTime()));
            pstmt.setInt(6, promotion.getMinTicketQuantity());
            pstmt.setInt(7, promotion.getMaxTicketQuantity());
            pstmt.setDouble(8, promotion.getMaxDiscountAmount());
            pstmt.setString(9, promotion.getStatus());

            pstmt.executeUpdate(); // Thực thi câu lệnh
            System.out.println("Promotion added successfully."); // In thông báo thành công

        } catch (SQLException e) {
            Logger.getLogger(Promotion_DB.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("Error adding promotion: " + e.getMessage()); // In thông báo lỗi
        }
    }

    // Hàm cập nhật thông tin khuyến mãi trong cơ sở dữ liệu
    public static void updatePromotion(Promotion promotion) {
        String query = "UPDATE Promotion SET promotion_code = ?, description = ?, discount_percentage = ?, start_date = ?, end_date = ?, min_ticket_quantity = ?, max_ticket_quantity = ?, max_discount_amount = ?, status = ? WHERE promotion_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, promotion.getPromotionCode());
            pstmt.setString(2, promotion.getDescription());
            pstmt.setDouble(3, promotion.getDiscountPercentage());
            pstmt.setDate(4, new java.sql.Date(promotion.getStartDate().getTime()));
            pstmt.setDate(5, new java.sql.Date(promotion.getEndDate().getTime()));
            pstmt.setInt(6, promotion.getMinTicketQuantity());
            pstmt.setInt(7, promotion.getMaxTicketQuantity());
            pstmt.setDouble(8, promotion.getMaxDiscountAmount());
            pstmt.setString(9, promotion.getStatus());
            pstmt.setInt(10, promotion.getPromotionId());

            pstmt.executeUpdate(); // Thực thi câu lệnh
            System.out.println("Promotion updated successfully."); // In thông báo thành công

        } catch (SQLException e) {
            Logger.getLogger(Promotion_DB.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("Error updating promotion: " + e.getMessage()); // In thông báo lỗi
        }
    }

    // Hàm lấy thông tin khuyến mãi theo ID
    public static Promotion getPromotionById(int promotionId) {
        Promotion promotion = null;
        String query = "SELECT * FROM Promotion WHERE promotion_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, promotionId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                promotion = new Promotion();
                promotion.setPromotionId(rs.getInt("promotion_id"));
                promotion.setPromotionCode(rs.getString("promotion_code"));
                promotion.setDescription(rs.getString("description"));
                promotion.setDiscountPercentage(rs.getDouble("discount_percentage"));
                promotion.setStartDate(rs.getDate("start_date"));
                promotion.setEndDate(rs.getDate("end_date"));
                promotion.setMinTicketQuantity(rs.getInt("min_ticket_quantity"));
                promotion.setMaxTicketQuantity(rs.getInt("max_ticket_quantity"));
                promotion.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                promotion.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            Logger.getLogger(Promotion_DB.class.getName()).log(Level.SEVERE, null, e);
        }

        return promotion;
    }

}
