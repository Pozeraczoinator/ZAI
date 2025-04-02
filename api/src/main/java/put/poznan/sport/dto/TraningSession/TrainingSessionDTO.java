package put.poznan.sport.dto.TraningSession;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Builder
@AllArgsConstructor
@Data
public class TrainingSessionDTO {

    private Integer trainingSessionId;

    @NotNull(message = "Id trenera nie może pozostać puste")
    private Integer coachId;

    @NotNull(message = "Id obiektu sportowego nie może pozostać puste")
    private Integer sportFacilityId;

    @NotBlank(message = "Nazwa nie może pozostać pusta")
    private String name;

    @NotBlank(message = "Godziny rozpoczęcia nie mogą pozostać puste")
    private String startHour;

    @NotNull(message = "Czas trwania nie może pozostać pusty")
    @Min(value = 1, message = "Czas trwania musi wynosić minimum 1 minutę")
    private Integer duration;

    private Integer isWeekly;

    @NotBlank(message = "Data nie może pozostać pusta")
    private Date trainingDate;

    @NotNull(message = "Ilość miejsc nie może pozostać pusta")
    @Min(value = 1, message = "Ilość miejsc musi wynosić minimum 1")
    private Integer capacity;
}
