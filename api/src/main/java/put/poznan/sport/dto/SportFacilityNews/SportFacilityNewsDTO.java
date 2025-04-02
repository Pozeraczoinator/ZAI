package put.poznan.sport.dto.SportFacilityNews;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class SportFacilityNewsDTO {

    private Integer sportFacilityNewsID;

    @NotNull(message = "Id obiektu sportowego nie może być puste")
    private Integer sportFacilityId;

    @NotBlank(message = "Tytuł nie może być pusty")
    private String title;

    @NotBlank(message = "Opis nie może być pusty")
    private String description;

    @NotBlank(message = "Obraz nie może być pusty")
    private String imageUrl;
}
