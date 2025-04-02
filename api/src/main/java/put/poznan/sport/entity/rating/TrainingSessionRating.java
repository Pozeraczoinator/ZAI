package put.poznan.sport.entity.rating;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import put.poznan.sport.entity.TrainingSession;

@Getter
@Setter
@Entity
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class TrainingSessionRating extends BaseRating {

    @ManyToOne
    @JoinColumn(name = "objectId")
    private TrainingSession trainingSession;
}
