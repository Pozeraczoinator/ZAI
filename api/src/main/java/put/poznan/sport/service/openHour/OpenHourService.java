package put.poznan.sport.service.openHour;

import put.poznan.sport.entity.openHour.OpenHour;

public interface OpenHourService {


    public OpenHour getOpenHourById(int id);

    public OpenHour saveOpenHour(OpenHour openHour);

    public void deleteOpenHour(OpenHour openHour);
}