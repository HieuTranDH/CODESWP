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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Combo;
import static model.DAO.DBinfo.driver;

/**
 *
 * @author Admin
 */
public class Combo_DB implements DBinfo {

    public Combo_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Combo> getAllCombo() {
        ArrayList<Combo> comboList = new ArrayList<>();
        String query = "SELECT * FROM Combo";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Combo combo = new Combo();
                combo.setComboId(rs.getInt("combo_id"));
                combo.setComboName(rs.getString("combo_name"));
                combo.setComboPrice(rs.getDouble("combo_price"));
                combo.setDescription(rs.getString("description"));
                combo.setStatus(rs.getString("status"));

                comboList.add(combo);
            }
        } catch (SQLException e) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, e);
        }

        return comboList;
    }

    public static ArrayList<Combo> getAllComboByStatusIsOpen() {
        ArrayList<Combo> comboList = new ArrayList<>();
        String query = "SELECT * FROM Combo WHERE status = ?";  // Chỉ lấy các combo có status là "open"

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            // Đặt giá trị "open" cho câu lệnh SQL
            pstmt.setString(1, "open");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Combo combo = new Combo();
                    combo.setComboId(rs.getInt("combo_id"));
                    combo.setComboName(rs.getString("combo_name"));
                    combo.setComboPrice(rs.getDouble("combo_price"));
                    combo.setDescription(rs.getString("description"));
                    combo.setStatus(rs.getString("status"));

                    comboList.add(combo);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, e);
        }

        return comboList;
    }

    public static Combo getCombobyID(int comboId) {
        Combo combo = null;
        String query = "SELECT * FROM Combo WHERE combo_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, comboId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    combo = new Combo();
                    combo.setComboId(rs.getInt("combo_id"));
                    combo.setComboName(rs.getString("combo_name"));
                    combo.setComboPrice(rs.getDouble("combo_price"));
                    combo.setDescription(rs.getString("description"));
                    combo.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, e);
        }

        return combo;
    }

    public static void editCombo(Combo combo) {
        String query = "UPDATE Combo SET combo_name = ?, combo_price = ?, description = ?, status = ? WHERE combo_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, combo.getComboName());
            pstmt.setDouble(2, combo.getComboPrice());
            pstmt.setString(3, combo.getDescription());
            pstmt.setString(4, combo.getStatus());
            pstmt.setInt(5, combo.getComboId());

            pstmt.executeUpdate();  // Thực hiện câu lệnh cập nhật
        } catch (SQLException e) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public static void AddCombo(Combo combo) {
        String query = "INSERT INTO Combo (combo_name, combo_price, description, status) VALUES (?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, combo.getComboName());
            pstmt.setDouble(2, combo.getComboPrice());
            pstmt.setString(3, combo.getDescription());
            pstmt.setString(4, combo.getStatus());

            pstmt.executeUpdate();  // Thực hiện câu lệnh thêm mới
        } catch (SQLException e) {
            Logger.getLogger(Combo_DB.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
