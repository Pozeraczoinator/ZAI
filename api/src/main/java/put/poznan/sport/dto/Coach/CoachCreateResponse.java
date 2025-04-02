package put.poznan.sport.dto.Coach;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CoachCreateResponse {
    private Integer id;
    private String name;
    private String surname;
    private Integer sportFacilitiesId;
    private String imageUrl;
}
