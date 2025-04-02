package put.poznan.sport.dto.Rating;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;
import put.poznan.sport.entity.User;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
public class Rating extends RatingRequest {
    private Integer id;

    @JsonIgnore
    private User addedBy;
}
