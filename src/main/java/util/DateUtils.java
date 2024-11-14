package util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtils {


    public static int getCurrentYear() {
        LocalDate currentDate;
        currentDate = LocalDate.now();
        return currentDate.getYear();
    }



    public static int getCurrentMonth() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getMonthValue();
    }
}
