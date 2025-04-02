package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.TrainingSessionParticipant;
import put.poznan.sport.entity.TrainingSessionParticipantId;

import java.util.List;
import java.util.Optional;

public interface TrainingSessionParticipantRepository extends JpaRepository<TrainingSessionParticipant, TrainingSessionParticipantId> {
    boolean existsByUserIdAndTrainingSessionId(int userId, int trainingSessionId);
    Optional<List<TrainingSessionParticipant>> findAllByUserId(int id);
    Optional<List<TrainingSessionParticipant>> findAllByTrainingSessionId(int id);
}