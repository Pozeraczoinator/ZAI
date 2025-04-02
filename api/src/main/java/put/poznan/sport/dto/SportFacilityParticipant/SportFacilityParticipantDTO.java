package put.poznan.sport.dto.SportFacilityParticipant;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SportFacilityParticipantDTO {
    @NotNull(message = "Id użytkownika nie może pozostać puste")
    private Integer userId;

    @NotNull(message = "Id obiektu sportowego nie może pozostać puste")
    private Integer sportFacilitiesId;
}
