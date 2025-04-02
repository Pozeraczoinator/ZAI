package put.poznan.sport.dto.SportEquipment;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

@Data
public class CreateSportEquipment {

    @NotBlank(message = "Typ nie może być pusty")
    private String type;

    @NotBlank(message = "Marka nie może być pusty")
    private String brand;

    @NotBlank(message = "Model nie może być pusty")
    private String model;

    @NotBlank(message = "Opis nie może być pusty")
    private String description;

    @NotBlank(message = "Link do zdjęcia nie może być pusty")
    private String imageUrl;

    @Min(value = 1, message = "Ilość musi być większa od zera")
    @NotNull(message = "Ilość nie może być pusta")
    private Integer amount;

    @NotNull(message = "Obiekt sportowy nie może być pusty")
    private Integer sportFacilityId;

}
