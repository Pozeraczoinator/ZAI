package put.poznan.sport.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CoachAverageRating {
    private Integer coachId;
    private String coachName;
    private Double averageRating;
}