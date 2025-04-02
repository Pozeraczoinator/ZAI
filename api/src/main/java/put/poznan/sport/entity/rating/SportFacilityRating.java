package put.poznan.sport.entity.rating;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import put.poznan.sport.entity.sportFacility.SportFacility;

@Getter
@Setter
@Entity
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class SportFacilityRating extends BaseRating {

    @ManyToOne
    @JoinColumn(name = "objectId")
    private SportFacility sportFacility;
}
