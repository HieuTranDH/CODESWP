package model;

/**
 *
 * @author Admin
 */
public class Combo {

    private int comboId;
    private String comboName;
    private double comboPrice;
    private String description;
    private String status;  // Thêm trường status

    // Constructor không tham số
    public Combo() {
        this.status = "open";  // Thiết lập giá trị mặc định cho status là 'open'
    }

    // Constructor đầy đủ tham số
    public Combo(int comboId, String comboName, double comboPrice, String description, String status) {
        this.comboId = comboId;
        this.comboName = comboName;
        this.comboPrice = comboPrice;
        this.description = description;
        this.status = status;
    }

    // Getter và Setter
    public int getComboId() {
        return comboId;
    }

    public void setComboId(int comboId) {
        this.comboId = comboId;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public double getComboPrice() {
        return comboPrice;
    }

    public void setComboPrice(double comboPrice) {
        this.comboPrice = comboPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Phương thức toString để dễ dàng in ra thông tin của combo
    @Override
    public String toString() {
        return "Combo{"
                + "comboId=" + comboId
                + ", comboName='" + comboName + '\''
                + ", comboPrice=" + comboPrice
                + ", description='" + description + '\''
                + ", status='" + status + '\''
                + '}';
    }
}
