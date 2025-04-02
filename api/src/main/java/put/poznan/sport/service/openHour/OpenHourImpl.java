package put.poznan.sport.service.openHour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.entity.openHour.OpenHour;
import put.poznan.sport.exception.exceptionClasses.OpenHourNotFoundException;
import put.poznan.sport.repository.OpenHourRepository;

@Service
public class OpenHourImpl implements OpenHourService {

    @Autowired
    private OpenHourRepository openHourRepository;

    @Override
    public OpenHour getOpenHourById(int id) {
        return openHourRepository.findById(id)
                .orElseThrow(() -> new OpenHourNotFoundException("Nie znaleziono godzin otwarcia dla podanego obiektu"));
    }

    @Override
    public OpenHour saveOpenHour(OpenHour openHour) {
        return openHourRepository.save(openHour);
    }

    @Override
    public void deleteOpenHour(OpenHour openHour) {
        openHourRepository.delete(openHour);
    }
}
