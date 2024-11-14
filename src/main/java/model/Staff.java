
package model;


public class Staff {

    private int staffId;
    private String name;
    private String email;
    private String phoneNumber;
    private String password;
    private String role;
    private String hireDate;
     private String disableDate;
    private int cinemaId;
    private String status;
  private Cinema cinema;
    // Constructor
    
    public Staff() {
    }

    

    public Staff(int staffId, String name, String email, String phoneNumber, String password, String role, String hireDate, int cinemaId) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.hireDate = hireDate;
        this.cinemaId = cinemaId;
    }
    // Getters and Setters

    public Staff(String name, String email, String phoneNumber, String password, String role, String hireDate, int cinemaId, String status) {
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.hireDate = hireDate;
        this.cinemaId = cinemaId;
        this.status = status;
    }

    public Staff(int staffId, String name, String email, String phoneNumber, String password, String role, String hireDate,String disableDate, Cinema cinema, String status) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.hireDate = hireDate;
        this.disableDate = disableDate;
        this.cinema = cinema;
        this.status = status;
    }
      public Staff(int staffId, String name, String email, String phoneNumber, String password, String role, String hireDate,String disableDate, int cinemaId, String status) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.hireDate = hireDate;
        this.disableDate = disableDate;
        this.cinemaId = cinemaId;
        this.status = status;
    }

    public Staff(int staffId, String name, String email, String phoneNumber, int cinemaId, String status) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.cinemaId = cinemaId;
        this.status = status;
    }

 

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

  

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }
   public String getDisableDate() {
        return disableDate;
    }

    public void setDisableDate(String disableDate) {
        this.disableDate = disableDate;
    }
}
