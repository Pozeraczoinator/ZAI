package put.poznan.sport.repository.rating;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.rating.TrainingSessionRating;

import java.util.Optional;

public interface TrainingSessionRatingRepository extends JpaRepository<TrainingSessionRating, Integer> {
    Optional<TrainingSessionRating> findByUserAndTrainingSession(User user, TrainingSession trainingSession);

    Optional<TrainingSessionRating> findByUserAndId(User user, Integer id);

    @Query("SELECT AVG(sfp.rate) FROM TrainingSessionRating sfp WHERE sfp.trainingSession = :trainingSession")
    Double findTrainingSessionAverage(TrainingSession trainingSession);

}