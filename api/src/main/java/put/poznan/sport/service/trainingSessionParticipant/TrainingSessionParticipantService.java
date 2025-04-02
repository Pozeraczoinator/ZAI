package put.poznan.sport.service.trainingSessionParticipant;

import put.poznan.sport.entity.TrainingSessionParticipant;

import java.util.List;


public interface TrainingSessionParticipantService {
    public List<TrainingSessionParticipant> getCurrentUserTrainings();
    public TrainingSessionParticipant joinTraining(int id) ;
    public List<TrainingSessionParticipant> getAllParticipant(int trainingId);
    public void leaveTraining(int trainingId);
}
