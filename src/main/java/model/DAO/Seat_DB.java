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
import java.util.Collections;
import java.util.Comparator;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Seat;

/**
 *
 * @author Admin
 */
public class Seat_DB implements DBinfo {

    public Seat_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Seat_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Seat> getAllSeatByRoomIDNone(int roomId) {
        ArrayList<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM Seat WHERE room_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Seat seat = new Seat(
                        rs.getInt("seat_id"), // seatId từ bảng
                        rs.getString("seat_number"), // seatNumber từ bảng
                        rs.getString("seat_type"), // seatType từ bảng
                        rs.getBigDecimal("seat_price") // seatPrice từ bảng
                );
                seats.add(seat);
            }

            // Sắp xếp theo seat_number với logic A1, A2, A3, ..., A10
            Collections.sort(seats, new Comparator<Seat>() {
                @Override
                public int compare(Seat s1, Seat s2) {
                    return compareSeatNumbers(s1.getSeatNumber(), s2.getSeatNumber());
                }

                private int compareSeatNumbers(String seat1, String seat2) {
                    // Tách phần chữ và phần số
                    String letter1 = seat1.replaceAll("[0-9]", "");
                    String letter2 = seat2.replaceAll("[0-9]", "");
                    int letterComparison = letter1.compareTo(letter2);

                    if (letterComparison != 0) {
                        return letterComparison;
                    }

                    // Tách phần số và chuyển thành số nguyên để so sánh
                    int number1 = Integer.parseInt(seat1.replaceAll("[^0-9]", ""));
                    int number2 = Integer.parseInt(seat2.replaceAll("[^0-9]", ""));
                    return Integer.compare(number1, number2);
                }
            });

        } catch (SQLException ex) {
            Logger.getLogger(Seat_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return seats;
    }

    public static Seat getSeatByIDNone(int seatId) {
        Seat seat = null;
        String query = "SELECT * FROM Seat WHERE seat_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, seatId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                seat = new Seat(
                        rs.getInt("seat_id"), // seatId từ bảng
                        rs.getString("seat_number"), // seatNumber từ bảng
                        rs.getString("seat_type"), // seatType từ bảng
                        rs.getBigDecimal("seat_price") // seatPrice từ bảng
                );
            }

        } catch (SQLException ex) {
            Logger.getLogger(Seat_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return seat;
    }

    public static boolean addSeatNone(int roomId, Seat seat) {
        String query = "INSERT INTO Seat (room_id, seat_number, seat_type, seat_price) VALUES (?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, roomId);                     // Sử dụng roomId từ tham số truyền vào
            ps.setString(2, seat.getSeatNumber());    // Số ghế từ đối tượng Seat
            ps.setString(3, seat.getSeatType());      // Loại ghế từ đối tượng Seat
            ps.setBigDecimal(4, seat.getSeatPrice()); // Giá ghế từ đối tượng Seat

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            Logger.getLogger(Seat_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static boolean deleteSeat(int seatId) {
        String query = "DELETE FROM Seat WHERE seat_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, seatId);

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            Logger.getLogger(Seat_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static void main(String[] args) {
          ArrayList<Seat> seatoldlist = getAllSeatByRoomIDNone(3);
          for(Seat s : seatoldlist){
              System.out.println(s);
          }
    }
}
