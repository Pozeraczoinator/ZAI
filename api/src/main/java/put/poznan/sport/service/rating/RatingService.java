package put.poznan.sport.service.rating;


import put.poznan.sport.dto.Rating.ObjectRating;
import put.poznan.sport.dto.Rating.Rating;
import put.poznan.sport.entity.User;

import java.util.List;
import java.util.Optional;

public interface RatingService {


    public ObjectRating getAllRatings(ObjectRating objectRating);

    public Rating createRating(Rating rating);

    public Rating updateRating(Rating rating);

    public void deleteRating(User user, String type, int id);

    public Double getCoachAverageRating(Integer coachId);
    public Double getSportFacilityAverageRating(Integer sportFacilityId);

}
