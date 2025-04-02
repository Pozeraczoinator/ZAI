package put.poznan.sport.entity.rating;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import put.poznan.sport.entity.Coach;

@Getter
@Setter
@Entity
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class CoachRating extends BaseRating {

    @ManyToOne
    @JoinColumn(name = "objectId")
    private Coach coach;
}
