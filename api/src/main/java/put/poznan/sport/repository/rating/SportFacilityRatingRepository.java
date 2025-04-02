package put.poznan.sport.repository.rating;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.rating.SportFacilityRating;

import java.util.Optional;

public interface SportFacilityRatingRepository extends JpaRepository<SportFacilityRating, Integer> {

    Optional<SportFacilityRating> findByUserAndSportFacility(User user, SportFacility sportFacility);

    Optional<SportFacilityRating> findByUserAndId(User user, Integer id);

    @Query("SELECT AVG(sfp.rate) FROM SportFacilityRating sfp WHERE sfp.sportFacility = :sportFacility")
    Optional<Double> findSportFacilityAverage(SportFacility sportFacility);


}