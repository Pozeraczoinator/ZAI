package put.poznan.sport.dto.Rating;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ObjectRating {

    private String objectType;
    private Integer objectId;
    private Double ratingAvg;

}
