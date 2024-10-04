/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import model.DAO.Customer_DB;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author ThanhDuoc
 */
public class Customer {

    private int customerId;
    private String name;
    private String email;
    private String phoneNumber;
    private String password;
    private int loyaltyPoints;
    private String registrationDate;
    private String avatar;
    private String location;
    private Date birthdate;

    // Constructor
    public Customer() {
    }

    public Customer(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public Customer(int customerId, String name, String email, String phoneNumber, String password, int loyaltyPoints, String registrationDate, String avatar, String location, Date birthdate) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.loyaltyPoints = loyaltyPoints;
        this.registrationDate = registrationDate;
        this.avatar = avatar;
        this.location = location;
        this.birthdate = birthdate;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public static Customer login(String identify, String inputMatKhau) {
        Customer user = Customer_DB.getCustomerByEmail(identify);
        if (user != null) {
            String storedPassword = user.getPassword();
            // Kiểm tra nếu mật khẩu được lưu trữ là mật khẩu đã mã hóa bằng BCrypt
        if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
            // Kiểm tra mật khẩu đã mã hóa
            if (BCrypt.checkpw(inputMatKhau, storedPassword)) {
                return user;
            }
        } else {
            // Kiểm tra mật khẩu thô cho các tài khoản ngoại lệ
            if (storedPassword.equals(inputMatKhau)) {
                // Trả về người dùng nếu mật khẩu khớp
                return user;
            }
        }
        }
        return null;
    }
}
