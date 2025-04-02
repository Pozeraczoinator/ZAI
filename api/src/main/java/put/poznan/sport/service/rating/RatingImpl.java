package put.poznan.sport.service.rating;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.Rating.ObjectRating;
import put.poznan.sport.dto.Rating.ObjectType;
import put.poznan.sport.dto.Rating.Rating;
import put.poznan.sport.entity.*;
import put.poznan.sport.entity.rating.CoachRating;
import put.poznan.sport.entity.rating.SportFacilityRating;
import put.poznan.sport.entity.rating.TrainingSessionRating;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.*;
import put.poznan.sport.repository.CoachRepository;
import put.poznan.sport.repository.SportFacilityParticipantRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.repository.TrainingSessionRepository;
import put.poznan.sport.repository.rating.CoachRatingRepository;
import put.poznan.sport.repository.rating.SportFacilityRatingRepository;
import put.poznan.sport.repository.rating.TrainingSessionRatingRepository;

@Service
public class RatingImpl implements RatingService {

    @Autowired
    private CoachRatingRepository coachRatingRepository;

    @Autowired
    private SportFacilityRatingRepository sportFacilityRatingRepository;

    @Autowired
    private TrainingSessionRatingRepository trainingSessionRatingRepository;

    @Autowired
    private TrainingSessionRepository trainingSessionRepository;

    @Autowired
    private CoachRepository coachRepository;

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Autowired
    private SportFacilityParticipantRepository sportFacilityParticipantRepository;


    @Override
    public ObjectRating getAllRatings(ObjectRating objectRating) {
        if (objectRating.getObjectType().equals(ObjectType.COACH.name())){
            objectRating.setRatingAvg(handleCoachRatingSearch(objectRating));
        } else if(objectRating.getObjectType().equals(ObjectType.SPORT_FACILITY.name())){
            objectRating.setRatingAvg(handleSportFacilityRatingSearch(objectRating));
        } else {
            objectRating.setRatingAvg(handleTrainingSessionRatingSearch(objectRating));
        }

        if (objectRating.getRatingAvg() == null){
            throw new ObjectNullRating("Nie znaleziono żadnych opinii");
        }

        return objectRating;
    }

    @Override
    public Rating createRating(Rating rating) {

        if (rating.getObjectType().equals(ObjectType.COACH.name())){
            return handleCoachRatingCreat(rating);
        } else if(rating.getObjectType().equals(ObjectType.SPORT_FACILITY.name())){
            return handleSportFacilityRatingCreate(rating);
        } else {
            return handleTrainingSessionRatingCreate(rating);
        }

    }

    @Override
    public Rating updateRating(Rating rating) {
        if (rating.getObjectType().equals(ObjectType.COACH.name())){
            return handleCoachRatingUpdate(rating);
        } else if(rating.getObjectType().equals(ObjectType.SPORT_FACILITY.name())){
            return handleSportFacilityRatingUpdate(rating);
        } else {
            return handleTrainingSessionRatingUpdate(rating);
        }
    }

    @Override
    public void deleteRating(User user, String type, int id) {
        if (type.equals(ObjectType.COACH.name())){
            handleCoachRatingDelete(user, id);
        }else if (type.equals(ObjectType.SPORT_FACILITY.name())){
            handleSportFacilityRatingDelete(user, id);
        } else {
            handleTrainingSessionRatingDelete(user, id);
        }
    }

    @Override
    public Double getCoachAverageRating(Integer coachId) {
        if (coachId != null){
            Coach coach = coachRepository.findById(coachId).orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera"));
            return coachRatingRepository.findCoachAverage(coach).orElse(null);
        }

        return null;
    }

    @Override
    public Double getSportFacilityAverageRating(Integer sportFacilityId) {
        SportFacility facility = sportFacilityRepository.findById(sportFacilityId)
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));
        return sportFacilityRatingRepository.findSportFacilityAverage(facility)
                .orElse(null);
    }


    private Double handleCoachRatingSearch(ObjectRating objectRating){
        Coach coach = coachRepository.findById(objectRating.getObjectId())
                .orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera"));

        return coachRatingRepository.findCoachAverage(coach).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));
    }

    private Double handleSportFacilityRatingSearch(ObjectRating objectRating){
        SportFacility sportFacility = sportFacilityRepository.findById(objectRating.getObjectId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        return sportFacilityRatingRepository.findSportFacilityAverage(sportFacility)
                .orElseThrow(() -> new RatingNotFoundException("Nie zaleziono opini"));
    }

    private Double handleTrainingSessionRatingSearch(ObjectRating objectRating){
        TrainingSession trainingSession = trainingSessionRepository.findById(objectRating.getObjectId())
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono zajęć"));

        return trainingSessionRatingRepository.findTrainingSessionAverage(trainingSession);
    }

    private Rating handleCoachRatingCreat(Rating rating){
        Coach coach = coachRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera"));

        coachRatingRepository.findByUserAndCoach(rating.getAddedBy(), coach)
                .ifPresent(existingRating -> {
                    throw new RatingAlreadyExistsException("Opinia została już prędzej wystawiona");
                });

        checkIsUserMember(rating.getAddedBy(), coach.getSportFacility());

        CoachRating coachRating = CoachRating.builder()
                .coach(coach)
                .rate(rating.getRate())
                .user(rating.getAddedBy())
                .build();

        CoachRating newCoachRating = coachRatingRepository.save(coachRating);
        rating.setId(newCoachRating.getId());

        return rating;
    }

    private Rating handleCoachRatingUpdate(Rating rating){
        Coach coach = coachRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera"));

        CoachRating coachRating = coachRatingRepository.findByUserAndCoach(rating.getAddedBy(), coach).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));

        checkIsUserMember(rating.getAddedBy(), coach.getSportFacility());

        coachRating.setRate(rating.getRate());

        CoachRating newCoachRating = coachRatingRepository.save(coachRating);
        rating.setId(newCoachRating.getId());

        return rating;
    }

    private void handleCoachRatingDelete(User user, int id){

        CoachRating coachRating = coachRatingRepository.findByUserAndId(user, id).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));

        coachRatingRepository.delete(coachRating);

    }

    private Rating handleSportFacilityRatingCreate(Rating rating){
        SportFacility sportFacility = sportFacilityRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        sportFacilityRatingRepository.findByUserAndSportFacility(rating.getAddedBy(), sportFacility)
                .ifPresent(existingRating -> {
                    throw new RatingAlreadyExistsException("Opinia została już prędzej wystawiona");
                });

        checkIsUserMember(rating.getAddedBy(), sportFacility);

        SportFacilityRating sportFacilityRating = SportFacilityRating.builder()
                .rate(rating.getRate())
                .sportFacility(sportFacility)
                .user(rating.getAddedBy())
                .build();

        SportFacilityRating newSportFacilityRating = sportFacilityRatingRepository.save(sportFacilityRating);
        rating.setId(newSportFacilityRating.getId());

        return rating;
    }

    private Rating handleSportFacilityRatingUpdate(Rating rating){
        SportFacility sportFacility = sportFacilityRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu sportowego"));

        SportFacilityRating sportFacilityRating = sportFacilityRatingRepository.findByUserAndSportFacility(rating.getAddedBy(), sportFacility).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));

        checkIsUserMember(rating.getAddedBy(), sportFacility);

        sportFacilityRating.setRate(rating.getRate());

        SportFacilityRating newSportFacilityRating = sportFacilityRatingRepository.save(sportFacilityRating);
        rating.setId(newSportFacilityRating.getId());

        return rating;
    }

    private void handleSportFacilityRatingDelete(User user, int id){
        SportFacilityRating sportFacilityRating = sportFacilityRatingRepository.findByUserAndId(user, id).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));
        sportFacilityRatingRepository.delete(sportFacilityRating);
    }

    private Rating handleTrainingSessionRatingCreate(Rating rating){
        TrainingSession trainingSession = trainingSessionRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono zajęć"));

        trainingSessionRatingRepository.findByUserAndTrainingSession(rating.getAddedBy(), trainingSession)
                .ifPresent(existingRating -> {
                    throw new RatingAlreadyExistsException("Opinia została już prędzej wystawiona");
                });

        checkIsUserMember(rating.getAddedBy(), trainingSession.getSportFacility());

        TrainingSessionRating trainingSessionRating = TrainingSessionRating.builder()
                .rate(rating.getRate())
                .trainingSession(trainingSession)
                .user(rating.getAddedBy())
                .build();

        TrainingSessionRating newTrainingSessionRating = trainingSessionRatingRepository.save(trainingSessionRating);
        rating.setId(newTrainingSessionRating.getId());

        return rating;
    }

    private Rating handleTrainingSessionRatingUpdate(Rating rating){
        TrainingSession trainingSession = trainingSessionRepository.findById(rating.getObjectId())
                .orElseThrow(() -> new TrainingSessionNotFoundException("Nie znaleziono zajęć"));

        TrainingSessionRating trainingSessionRating = trainingSessionRatingRepository.findByUserAndTrainingSession(rating.getAddedBy(), trainingSession).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));

        checkIsUserMember(rating.getAddedBy(), trainingSession.getSportFacility());

        trainingSessionRating.setRate(rating.getRate());

        TrainingSessionRating newTrainingSessionRating = trainingSessionRatingRepository.save(trainingSessionRating);
        rating.setId(newTrainingSessionRating.getId());

        return rating;
    }

    private void handleTrainingSessionRatingDelete(User user, int id){
        TrainingSessionRating trainingSessionRating = trainingSessionRatingRepository.findByUserAndId(user, id).orElseThrow(() -> new RatingNotFoundException("Nie znaleziono opini"));
        trainingSessionRatingRepository.delete(trainingSessionRating);
    }

    private void checkIsUserMember(User user, SportFacility sportFacility){
        if (sportFacility.isMembershipRequired()) {
            sportFacilityParticipantRepository.findByUserAndSportFacilityAndIsActive(user, sportFacility,1)
                    .orElseThrow(() -> new UserIsNotMember("Użytkownik nie posiada wykupionego karnetu w obiekcie"));
        }
    }

}
