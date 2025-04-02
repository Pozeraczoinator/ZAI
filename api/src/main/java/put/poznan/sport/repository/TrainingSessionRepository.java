package put.poznan.sport.repository;

import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import put.poznan.sport.entity.TrainingSession;

import java.util.List;
import java.util.Optional;

public interface TrainingSessionRepository extends JpaRepository<TrainingSession, Integer> {
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    Optional<TrainingSession> findById(int id);
    Optional<List<TrainingSession>> findBySportFacilityId(int sportFacilityId);
}