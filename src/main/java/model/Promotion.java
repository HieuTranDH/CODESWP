/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Promotion {

    private int promotionId;
    private String promotionCode;
    private String description;
    private double discountPercentage;
    private Date startDate;
    private Date endDate;
    private int minTicketQuantity;
    private int maxTicketQuantity;
    private double maxDiscountAmount;
    private String status;

    public Promotion() {
    }

    public Promotion(int promotionId, String promotionCode, String description, double discountPercentage, Date startDate, Date endDate, int minTicketQuantity, int maxTicketQuantity, double maxDiscountAmount, String status) {
        this.promotionId = promotionId;
        this.promotionCode = promotionCode;
        this.description = description;
        this.discountPercentage = discountPercentage;
        this.startDate = startDate;
        this.endDate = endDate;
        this.minTicketQuantity = minTicketQuantity;
        this.maxTicketQuantity = maxTicketQuantity;
        this.maxDiscountAmount = maxDiscountAmount;
        this.status = status;
    }

    //import promotion
     
    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getPromotionCode() {
        return promotionCode;
    }

    public void setPromotionCode(String promotionCode) {
        this.promotionCode = promotionCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getMinTicketQuantity() {
        return minTicketQuantity;
    }

    public void setMinTicketQuantity(int minTicketQuantity) {
        this.minTicketQuantity = minTicketQuantity;
    }

    public int getMaxTicketQuantity() {
        return maxTicketQuantity;
    }

    public void setMaxTicketQuantity(int maxTicketQuantity) {
        this.maxTicketQuantity = maxTicketQuantity;
    }

    public double getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(double maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
