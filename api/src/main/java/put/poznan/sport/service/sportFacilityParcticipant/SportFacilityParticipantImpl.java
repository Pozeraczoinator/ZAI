package put.poznan.sport.service.sportFacilityParcticipant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.SportFacilityParticipant.SportFacilityParticipantDTO;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.sportFacility.SportFacilityParticipant;
import put.poznan.sport.entity.sportFacility.SportFacilityParticipantId;
import put.poznan.sport.entity.User;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportFacilityParticipantNotFoundException;
import put.poznan.sport.exception.exceptionClasses.UserIsAlreadyMemberException;
import put.poznan.sport.exception.exceptionClasses.UserNotFoundException;
import put.poznan.sport.repository.SportFacilityParticipantRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.repository.UserRepository;
import put.poznan.sport.service.user.UserService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SportFacilityParticipantImpl implements SportFacilityParticipantService {

    @Autowired
    private SportFacilityParticipantRepository sportFacilityParticipantRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Autowired
    private UserService userService;

    @Override
    public List<SportFacilityParticipant> getAllFacilityParticipants() {
        return sportFacilityParticipantRepository.findAll();
    }

    @Override
    public List<User> getUsersBySportFacility(Integer facilityID) {
        List<SportFacilityParticipant> participants = sportFacilityParticipantRepository.findAllBySportFacilitiesId(facilityID)
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono członków podanego obiektu"));

        return  participants
                .stream()
                .map(SportFacilityParticipant::getUser)
                .collect(Collectors.toList());
    }

    @Override
    public List<SportFacility> getSportFacilitiesByCurrentUser () {
        User user = userService.getUser();
        return sportFacilityParticipantRepository.findAllByUserId(user.getId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektów dla podanego użytkownika"))
                .stream()
                .map(SportFacilityParticipant::getSportFacility)
                .collect(Collectors.toList());
    }

    @Override
    public SportFacilityParticipant createSportFacilityParticipant(SportFacilityParticipantDTO participant) {
        userRepository.findById(participant.getUserId())
                .orElseThrow(() -> new UserNotFoundException("Nie znaleziono takiego użytkownika"));

        SportFacility sportFacility = sportFacilityRepository.findById(participant.getSportFacilitiesId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        if (!userIsParticipant(participant.getUserId(), participant.getSportFacilitiesId())) {
            throw new UserIsAlreadyMemberException("Użytkownik jest już członkiem");
        }

        SportFacilityParticipant newParticipant = SportFacilityParticipant.builder()
                .userId(participant.getUserId())
                .sportFacilitiesId(participant.getSportFacilitiesId())
                .isActive(1)
                .build();

        return sportFacilityParticipantRepository.save(newParticipant);
    }


    @Override
    public SportFacilityParticipant changeParticipantStatus(SportFacilityParticipantDTO participant) {
        SportFacilityParticipantId user = new SportFacilityParticipantId(participant.getUserId(), participant.getSportFacilitiesId());

        SportFacility sportFacility = sportFacilityRepository.findById(participant.getSportFacilitiesId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        SportFacilityParticipant newParticipant = sportFacilityParticipantRepository.findById(user)
                .orElseThrow(() -> new SportFacilityParticipantNotFoundException("Nie znaleziono podanego członka"));

        newParticipant.setIsActive(newParticipant.getIsActive() == 1 ? 0 : 1);

        return sportFacilityParticipantRepository.save(newParticipant);
    }

    @Override
    public void deleteSportFacilityParticipant(Integer userId,  Integer facilityId) {
        SportFacilityParticipantId user = new SportFacilityParticipantId(userId, facilityId);

        SportFacility sportFacility = sportFacilityRepository.findById(facilityId)
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        SportFacilityParticipant participant = sportFacilityParticipantRepository.findById(user)
                .orElseThrow(() -> new SportFacilityParticipantNotFoundException("Nie znaleziono podanego członka"));

        sportFacilityParticipantRepository.delete(participant);
    }

    private boolean userIsParticipant(int userId, int sportFacilityId) {
        return sportFacilityParticipantRepository
                .existsSportFacilityParticipantByUserIdAndSportFacilitiesIdAndIsActive(userId, sportFacilityId, 1);
    }

}
