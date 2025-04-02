package put.poznan.sport.dto.Coach;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class CreateCoach {

    @NotBlank(message = "Imię nie może pozostać puste")
    private String name;

    @NotBlank(message = "Nazwisko nie może pozostać puste")
    private String surname;

    @NotNull(message = "Numer obiektu nie może być pusty")
    private Integer sportFacilitiesId;

    @NotBlank(message = "Nie przesłano zdjęcia")
    private String imageUrl;
}
