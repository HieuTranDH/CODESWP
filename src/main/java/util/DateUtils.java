package util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtils {

    // Trả về chuỗi tháng và năm hiện tại (ví dụ: "September 2024")
    public static String getCurrentMonthYear() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy");
        return currentDate.format(formatter);
    }

    // Trả về tháng và năm hiện tại dưới dạng số (ví dụ: 9 và 2024)
    public static int getCurrentYear() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getYear();
    }

    // Trả về ngày hiện tại dưới dạng số (ví dụ: 26)
    public static int getCurrentDay() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getDayOfMonth();
    }

    // Trả về tháng hiện tại dưới dạng số (ví dụ: 9 cho tháng 9)
    public static int getCurrentMonth() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getMonthValue();
    }
}
