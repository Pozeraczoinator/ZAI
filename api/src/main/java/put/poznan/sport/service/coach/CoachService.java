package put.poznan.sport.service.coach;

import put.poznan.sport.dto.Coach.CoachCreateResponse;
import put.poznan.sport.dto.Coach.CoachUpdate;
import put.poznan.sport.entity.Coach;

import java.util.List;

public interface CoachService {

    public List<Coach> getAllCoaches();

    public Coach getCoachById(int id);

    public CoachCreateResponse createCoach(Coach coach);

    public CoachUpdate updateCoach(CoachUpdate coach, Coach existingCoach);

    public void deleteCoach(Coach coach);
}
