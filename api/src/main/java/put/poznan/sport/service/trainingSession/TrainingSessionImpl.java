package put.poznan.sport.service.trainingSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.TraningSession.TrainingSessionDTO;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.exception.exceptionClasses.CoachNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.exception.exceptionClasses.TrainingSessionNotFoundException;
import put.poznan.sport.repository.CoachRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.repository.TrainingSessionRepository;
import put.poznan.sport.service.user.UserService;

import java.util.List;
import java.util.Optional;

@Service
public class TrainingSessionImpl implements TrainingSessionService {

    @Autowired
    private TrainingSessionRepository trainingSessionRepository;
    @Autowired
    private CoachRepository coachRepository;
    @Autowired
    private SportFacilityRepository sportFacilityRepository;
    @Autowired
    private UserService userService;

    @Override
    public Optional<List<TrainingSession>> getAllSessions() {
        return Optional.of(trainingSessionRepository.findAll());
    }

    @Override
    public List<TrainingSession> getTrainingsByFacility(int id) {
        return trainingSessionRepository.findBySportFacilityId(id)
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));
    }

    @Override
    public TrainingSession getSessionById(int id) {
        return trainingSessionRepository.findById(id)
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));
    }

    @Override
    public TrainingSession createSession(TrainingSessionDTO request) {

        SportFacility facility = sportFacilityRepository.findById(request.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(facility);

        coachRepository.findById(request.getCoachId())
                .orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera"));

        TrainingSession session = TrainingSession.builder()
                .coachId(request.getCoachId())
                .sportFacilityId(request.getSportFacilityId())
                .name(request.getName())
                .startHour(request.getStartHour())
                .duration(request.getDuration())
                .isWeekly(request.getIsWeekly())
                .trainingDate(request.getTrainingDate())
                .capacity(request.getCapacity())
                .freeBooked(request.getCapacity())
                .build();


        return trainingSessionRepository.save(session);
    }

    @Override
    public TrainingSession updateSession(TrainingSessionDTO trainingSessionDTO) {
        TrainingSession newSession = trainingSessionRepository.findById(trainingSessionDTO.getTrainingSessionId())
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));

        userService.checkIfUserIsManagerOrAdmin(newSession.getSportFacility());

        newSession.setCoachId(trainingSessionDTO.getCoachId());
        newSession.setSportFacilityId(trainingSessionDTO.getSportFacilityId());
        newSession.setName(trainingSessionDTO.getName());
        newSession.setStartHour(trainingSessionDTO.getStartHour());
        newSession.setDuration(trainingSessionDTO.getDuration());
        newSession.setIsWeekly(trainingSessionDTO.getIsWeekly());
        newSession.setTrainingDate(trainingSessionDTO.getTrainingDate());
        newSession.setCapacity(trainingSessionDTO.getCapacity());

        return trainingSessionRepository.save(newSession);
    }


    @Override
    public List<TrainingSession> getTrainingSessionsBySportFacilityId(int sportFacilityId) {
        return trainingSessionRepository.findBySportFacilityId(sportFacilityId)
                .orElseThrow(null);
    }

    @Override
    public void deleteSession(int id) {
        TrainingSession trainingSession = trainingSessionRepository.findById(id)
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));

        userService.checkIfUserIsManagerOrAdmin(trainingSession.getSportFacility());
        trainingSessionRepository.delete(trainingSession);
    }
}
