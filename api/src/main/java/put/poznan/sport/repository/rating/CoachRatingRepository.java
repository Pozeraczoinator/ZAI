package put.poznan.sport.repository.rating;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.rating.CoachRating;
import put.poznan.sport.entity.rating.TrainingSessionRating;

import java.util.Optional;

public interface CoachRatingRepository extends JpaRepository<CoachRating, Integer> {
    Optional<CoachRating> findByUserAndCoach(User user, Coach coach);

    Optional<CoachRating> findByUserAndId(User user, Integer id);

    @Query("SELECT AVG(sfp.rate) FROM CoachRating sfp WHERE sfp.coach = :coach")
    Optional<Double> findCoachAverage(Coach coach);

}