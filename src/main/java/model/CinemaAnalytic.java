/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


public class CinemaAnalytic {
    private int cinemaId;          // ID của rạp chiếu
    private String name;           // Tên của rạp chiếu
    private int numberOfTicket;    // Số lượng vé
    private double totalPrice;      // Doanh thu tổng

    // Constructor
    public CinemaAnalytic(int cinemaId, String name, int numberOfTicket, double totalPrice) {
        this.cinemaId = cinemaId;
        this.name = name;
        this.numberOfTicket = numberOfTicket;
        this.totalPrice = totalPrice;
    }

    // Getter và Setter cho cinemaId
    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    // Getter và Setter cho name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public int getNumberOfTicket() {
        return numberOfTicket;
    }

    public void setNumberOfTicket(int numberOfTicket) {
        this.numberOfTicket = numberOfTicket;
    }

    // Getter và Setter cho totalPrice
    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "CinemaAnalytic{" + "cinemaId=" + cinemaId + ", name=" + name + ", numberOfTicket=" + numberOfTicket + ", totalPrice=" + totalPrice + '}';
    }
    
}

