package put.poznan.sport.entity.sportFacility;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SportFacilityNews {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer sportFacilityId;
    private String title;
    private String description;
    private String imageUrl;

    @ManyToOne
    @JoinColumn(name = "sportFacilityId", insertable = false, updatable = false)
    @JsonIgnore
    private SportFacility sportFacility;
}
