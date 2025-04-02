package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;

import java.util.List;
import java.util.Optional;

public interface SportFacilityNewsRepository extends JpaRepository<SportFacilityNews, Integer> {
    Optional<List<SportFacilityNews>> findBySportFacilityId(Integer sportFacilitiesId);
}