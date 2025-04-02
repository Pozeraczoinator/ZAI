package put.poznan.sport.dto.OpenHour;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalTime;

@Data
public class CreateOpenHour {

    @NotNull(message = "Id obiektu sportowego nie może być puste")
    private Integer sportFacilityId;
    private LocalTime mondayStart;
    private LocalTime mondayEnd;
    private LocalTime tuesdayStart;
    private LocalTime tuesdayEnd;
    private LocalTime wednesdayStart;
    private LocalTime wednesdayEnd;
    private LocalTime thursdayStart;
    private LocalTime thursdayEnd;
    private LocalTime fridayStart;
    private LocalTime fridayEnd;
    private LocalTime saturdayStart;
    private LocalTime saturdayEnd;
    private LocalTime sundayStart;
    private LocalTime sundayEnd;

    @AssertTrue(message = "Godzina rozpoczęcia poniedziałku musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isMondayHoursValid() {
        if (mondayStart == null && mondayEnd == null) return true;
        assert mondayStart != null;
        return mondayEnd != null && (mondayStart.isBefore(mondayEnd) || mondayStart.equals(mondayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia wtorku musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isTuesdayHoursValid() {
        if (tuesdayStart == null && tuesdayEnd == null) return true;
        assert tuesdayStart != null;
        return tuesdayEnd != null && (tuesdayStart.isBefore(tuesdayEnd) || tuesdayStart.equals(tuesdayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia środy musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isWednesdayHoursValid() {
        if (wednesdayStart == null && wednesdayEnd == null) return true;
        assert wednesdayStart != null;
        return wednesdayEnd != null && (wednesdayStart.isBefore(wednesdayEnd) || wednesdayStart.equals(wednesdayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia czwartku musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isThursdayHoursValid() {
        if (thursdayStart == null && thursdayEnd == null) return true;
        assert thursdayStart != null;
        return thursdayEnd != null && (thursdayStart.isBefore(thursdayEnd) || thursdayStart.equals(thursdayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia piątku musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isFridayHoursValid() {
        if (fridayStart == null && fridayEnd == null) return true;
        assert fridayStart != null;
        return fridayEnd != null && (fridayStart.isBefore(fridayEnd) || fridayStart.equals(fridayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia soboty musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isSaturdayHoursValid() {
        if (saturdayStart == null && saturdayEnd == null) return true;
        assert saturdayStart != null;
        return saturdayEnd != null && (saturdayStart.isBefore(saturdayEnd) || saturdayStart.equals(saturdayEnd));
    }

    @AssertTrue(message = "Godzina rozpoczęcia niedzieli musi być wcześniejsza lub równa godzinie zakończenia.")
    private boolean isSundayHoursValid() {
        if (sundayStart == null && sundayEnd == null) return true;
        assert sundayStart != null;
        return sundayEnd != null && (sundayStart.isBefore(sundayEnd) || sundayStart.equals(sundayEnd));
    }
}
