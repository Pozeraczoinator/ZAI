package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.sportFacility.SportFacilityParticipant;
import put.poznan.sport.entity.sportFacility.SportFacilityParticipantId;
import put.poznan.sport.entity.User;

import java.util.List;
import java.util.Optional;

public interface SportFacilityParticipantRepository extends JpaRepository<SportFacilityParticipant, SportFacilityParticipantId> {
    Optional <SportFacilityParticipant> findByUserAndSportFacilityAndIsActive(User user, SportFacility sportFacility, Integer isActive );
    Optional<List<SportFacilityParticipant>> findAllByUserId(int id);
    Optional<List<SportFacilityParticipant>> findAllBySportFacilitiesId(Integer facilityId);
    Boolean existsSportFacilityParticipantByUserIdAndSportFacilitiesIdAndIsActive(Integer userId, Integer SportFacilityId, int active);

}