package put.poznan.sport.dto.SportFacility;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SportFacilityDTO {
    private Integer id;

    @NotBlank(message = "Nazwa nie może być pusty")
    private String name;

    @NotBlank(message = "Opis nie może być pusty")
    private String description;

    @NotBlank(message = "Adres nie może być pusty")
    private String address;

    @NotBlank(message = "Typ nie może być pusty")
    private String type;

    private boolean membershipRequired = false;

    @NotNull(message = "Obraz nie może być pusty")
    private String imageUrl;
}
