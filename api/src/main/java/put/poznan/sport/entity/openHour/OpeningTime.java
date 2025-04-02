package put.poznan.sport.entity.openHour;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalTime;

@Embeddable
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OpeningTime {
    @NotBlank(message = "Godzina otwarcia nie może być pusta")
    private LocalTime start;

    @NotBlank(message = "Godzina zamknięcia nie może być pusta")
    private LocalTime end;

    @AssertTrue(message = "Godzina otwarcia musi być wcześniejsza niż zamknięcia")
    @JsonIgnore
    public boolean isStartTimeBeforeOrEqualEndTime() {
        if (start == null || end == null) {
            return true;
        }

        return start.isAfter(end);
    }
}
