package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.sportFacility.SportFacility;

public interface SportFacilityRepository extends JpaRepository<SportFacility, Integer> {
}