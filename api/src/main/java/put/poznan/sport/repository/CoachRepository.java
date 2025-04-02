package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.Coach;

import java.util.Optional;

public interface CoachRepository extends JpaRepository<Coach, Integer> {

}
