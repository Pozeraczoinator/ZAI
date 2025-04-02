package put.poznan.sport.service.trainingSession;

import put.poznan.sport.dto.TraningSession.TrainingSessionDTO;
import put.poznan.sport.entity.TrainingSession;

import java.util.List;
import java.util.Optional;


public interface TrainingSessionService {

    public Optional<List<TrainingSession>> getAllSessions();

    public List<TrainingSession> getTrainingsByFacility(int id);

    public TrainingSession getSessionById(int id);

    public TrainingSession createSession(TrainingSessionDTO trainingSession) ;

    public TrainingSession updateSession(TrainingSessionDTO trainingSession);

    List<TrainingSession> getTrainingSessionsBySportFacilityId(int sportFacilityId);

    public void deleteSession(int id) ;

}

