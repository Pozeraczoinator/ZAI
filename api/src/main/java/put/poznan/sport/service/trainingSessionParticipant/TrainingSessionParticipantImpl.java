package put.poznan.sport.service.trainingSessionParticipant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import put.poznan.sport.entity.*;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.*;
import put.poznan.sport.repository.SportFacilityParticipantRepository;
import put.poznan.sport.repository.TrainingSessionParticipantRepository;
import put.poznan.sport.repository.TrainingSessionRepository;
import put.poznan.sport.repository.UserRepository;
import put.poznan.sport.service.user.UserService;

import java.util.List;

@Service
public class TrainingSessionParticipantImpl implements TrainingSessionParticipantService {

    @Autowired
    private TrainingSessionParticipantRepository trainingSessionParticipantRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TrainingSessionRepository trainingSessionRepository;

    @Autowired
    private SportFacilityParticipantRepository sportFacilityParticipantRepository;

    @Override
    public List<TrainingSessionParticipant> getAllParticipant(int trainingId) {
        return trainingSessionParticipantRepository.findAllByTrainingSessionId(trainingId)
                .orElseThrow(() -> new TrainingSessionParticipantNotFoundException("Nie znaleziono uczestnika"));
    }

    @Override
    public List<TrainingSessionParticipant> getCurrentUserTrainings() {
        String currentUserEmail = userService.getCurrentUsername();
        User currentUser = userRepository.getById(1);

        return trainingSessionParticipantRepository.findAllByUserId(currentUser.getId())
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono trenignów"));

    }

    @Override
    @Transactional
    public TrainingSessionParticipant joinTraining(int id) {
        TrainingSession trainingSession  = trainingSessionRepository.findById(id)
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));

        if (trainingSession.getFreeBooked() <= 0){
            throw new NoAvailableSpotsException("Brak dostępnych miejsc");
        }

        String currentUserEmail = userService.getCurrentUsername();
        User currentUser = userRepository.getById(1);

        if (isMemberShipRequired(trainingSession.getSportFacility())) {
            checkUserMemberShip(currentUser.getId(), trainingSession.getSportFacilityId());
        }

        if (isUserParticipant(currentUser.getId(), id)) {
            throw new UserIsAlreadyParticipantException("Użytkownik jest już uczestnikiem");
        }

        TrainingSessionParticipant newParticipant = TrainingSessionParticipant.builder()
                .trainingSessionId(id)
                .userId(currentUser.getId())
                .build();

        trainingSession.setFreeBooked(trainingSession.getFreeBooked() - 1);
        trainingSessionRepository.save(trainingSession);

        return trainingSessionParticipantRepository.save(newParticipant);
    }


    @Override
    public void leaveTraining(int trainingId) {
        TrainingSession trainingSession  = trainingSessionRepository.findById(trainingId)
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono treningu"));

        String currentUserEmail = userService.getCurrentUsername();
        User currentUser = userRepository.getById(1);


        TrainingSessionParticipantId user = TrainingSessionParticipantId.builder()
                .userId(currentUser.getId())
                .trainingSessionId(trainingId)
                .build();

        trainingSessionParticipantRepository.findById(user)
                .orElseThrow(() -> new TrainingSessionParticipantNotFoundException("Nie znaleziono treningu użytkownika"));

        trainingSession.setFreeBooked(trainingSession.getFreeBooked() + 1);
        trainingSessionRepository.save(trainingSession);

        trainingSessionParticipantRepository.deleteById(user);
    }

    boolean isUserParticipant(int userId, int trainingSessionId) {
        return trainingSessionParticipantRepository.existsByUserIdAndTrainingSessionId(userId, trainingSessionId);
    }

    boolean isMemberShipRequired(SportFacility facility) {
        return facility.isMembershipRequired();
    }

    void checkUserMemberShip (int userId, int sportFacilityId) {
        boolean isMember = sportFacilityParticipantRepository
                .existsSportFacilityParticipantByUserIdAndSportFacilitiesIdAndIsActive(userId, sportFacilityId, 1);

        if (!isMember){
            throw new UserIsNotMember("Użytkownik musi być członkiem aby zapisać się na trening");
        }

    }
}
