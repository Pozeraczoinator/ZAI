package put.poznan.sport.dto.Rating;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class RatingRequest {

    @NotNull(message = "Ocena nie może być pusta")
    @Min(value =  1, message = "Ocena musi być większa od 0")
    @Max(value =  5, message = "Ocena musi być mniejsza lub równa 5")
    private Integer rate;

    @NotNull(message = "Typ nie może być pusty")
    private String objectType;

    @NotNull(message = "Id nie może być puste")
    private Integer objectId;

}
