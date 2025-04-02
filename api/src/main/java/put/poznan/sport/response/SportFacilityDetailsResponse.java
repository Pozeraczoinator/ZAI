package put.poznan.sport.response;

import lombok.Builder;
import lombok.Data;
import put.poznan.sport.dto.Coach.CoachCreateResponse;
import put.poznan.sport.entity.SportEquipment;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.entity.openHour.OpenHour;

import java.util.List;

@Data
@Builder
public class SportFacilityDetailsResponse {
    private Integer id;
    private String name;
    private String description;
    private String address;
    private String type;
    private boolean membershipRequired;
    private String imageUrl;
    private OpenHour openHours;
    private List<CoachCreateResponse> coaches;
    private List<SportEquipment> equipment;
    private Double averageRating;
    private List<CoachAverageRating> coachRatings;
    private List<SportFacilityNews> news;
    private List<TrainingSession> trainingSessions;
}
