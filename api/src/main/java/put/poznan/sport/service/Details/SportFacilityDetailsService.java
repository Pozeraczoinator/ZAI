package put.poznan.sport.service.Details;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.Coach.CoachCreateResponse;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.SportEquipment;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.entity.openHour.OpenHour;
import put.poznan.sport.response.CoachAverageRating;
import put.poznan.sport.response.SportFacilityDetailsResponse;
import put.poznan.sport.service.rating.RatingService;
import put.poznan.sport.service.sportFacilityNews.SportFacilityNewsService;
import put.poznan.sport.service.trainingSession.TrainingSessionService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SportFacilityDetailsService {

    @Autowired
    private RatingService ratingService;

    @Autowired
    private SportFacilityNewsService sportFacilityNewsService;

    @Autowired
    private TrainingSessionService trainingSessionService;

    public SportFacilityDetailsResponse getSportFacilityDetails(SportFacility sportFacility) {

        OpenHour openHour = sportFacility.getOpenHour();

        List<Coach> coaches = sportFacility.getCoaches();
        List<CoachAverageRating> coachRatings = coaches.stream()
                .map(coach -> CoachAverageRating.builder()
                        .coachId(coach.getId())
                        .coachName(coach.getName() + " " + coach.getSurname())
                        .averageRating(ratingService.getCoachAverageRating(coach.getId()))
                        .build())
                .collect(Collectors.toList());

        List<CoachCreateResponse> coachResponses = coaches.stream()
                .map(coach -> CoachCreateResponse.builder()
                        .id(coach.getId())
                        .name(coach.getName())
                        .surname(coach.getSurname())
                        .sportFacilitiesId(coach.getSportFacility().getId())
                        .imageUrl(coach.getImageUrl())
                        .build())
                .collect(Collectors.toList());

        List<SportEquipment> equipment = sportFacility.getSportEquipments();

        List<SportFacilityNews> news = sportFacilityNewsService.getFacilityNewsBySportFacilityId(sportFacility.getId());
        List<TrainingSession> trainingSessions = trainingSessionService.getTrainingSessionsBySportFacilityId(sportFacility.getId());
        Double averageRating = ratingService.getSportFacilityAverageRating(sportFacility.getId());


        return SportFacilityDetailsResponse.builder()
                .id(sportFacility.getId())
                .name(sportFacility.getName())
                .description(sportFacility.getDescription())
                .address(sportFacility.getAddress())
                .type(String.valueOf(sportFacility.getType()))
                .membershipRequired(sportFacility.isMembershipRequired())
                .imageUrl(sportFacility.getImageUrl())
                .openHours(openHour)
                .coaches(coachResponses)
                .equipment(equipment)
                .averageRating(averageRating)
                .coachRatings(coachRatings)
                .news(news)
                .trainingSessions(trainingSessions)
                .build();
    }
}
