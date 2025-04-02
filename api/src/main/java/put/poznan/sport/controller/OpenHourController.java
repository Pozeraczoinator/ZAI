package put.poznan.sport.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.OpenHour.CreateOpenHour;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.openHour.OpenHour;
import put.poznan.sport.entity.openHour.OpeningTime;
import put.poznan.sport.exception.exceptionClasses.OpenHourNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.repository.OpenHourRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.service.openHour.OpenHourService;
import put.poznan.sport.service.user.UserService;

import java.time.LocalTime;

@RestController
@RequestMapping("api/openhour/")
public class OpenHourController {

    @Autowired
    private OpenHourService openHourService;

    @Autowired
    private UserService userService;

    @Autowired
    private OpenHourRepository openHourRepository;

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @GetMapping("{id}")
    @ResponseBody
    public ResponseEntity<?> getOpenHourById(@PathVariable("id") int id){


        return new ResponseEntity<>(openHourService.getOpenHourById(id), HttpStatus.OK);

    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createOpenHour(@RequestBody @Valid CreateOpenHour openHour){

        SportFacility sportFacility = sportFacilityRepository.findById(openHour.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie zaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        OpenHour newOpenHour =  OpenHour.builder()
                .sportFacility(sportFacility)
                .monday(convertToOpeningTime(openHour.getMondayStart(), openHour.getMondayEnd()))
                .tuesday(convertToOpeningTime(openHour.getTuesdayStart(), openHour.getTuesdayEnd()))
                .wednesday(convertToOpeningTime(openHour.getWednesdayStart(), openHour.getWednesdayEnd()))
                .thursday(convertToOpeningTime(openHour.getThursdayStart(), openHour.getThursdayEnd()))
                .friday(convertToOpeningTime(openHour.getFridayStart(), openHour.getFridayEnd()))
                .saturday(convertToOpeningTime(openHour.getSaturdayStart(), openHour.getSaturdayEnd()))
                .sunday(convertToOpeningTime(openHour.getSundayStart(), openHour.getSundayEnd()))
                .sportFacility(sportFacility)
                .build();

        return new ResponseEntity<>(openHourService.saveOpenHour(newOpenHour), HttpStatus.OK);

    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> updateOpenHour(@RequestBody @Valid CreateOpenHour openHour){

        OpenHour existingOpenHour = openHourRepository.findById(openHour.getSportFacilityId())
                .orElseThrow(() -> new OpenHourNotFoundException("Nie znaleziono godzin otwarcia dla podanego obiektu"));

        userService.checkIfUserIsManagerOrAdmin(existingOpenHour.getSportFacility());

        OpenHour newOpenHour =  OpenHour.builder()
                .id(existingOpenHour.getId())
                .monday(convertToOpeningTime(openHour.getMondayStart(), openHour.getMondayEnd()))
                .tuesday(convertToOpeningTime(openHour.getTuesdayStart(), openHour.getTuesdayEnd()))
                .wednesday(convertToOpeningTime(openHour.getWednesdayStart(), openHour.getWednesdayEnd()))
                .thursday(convertToOpeningTime(openHour.getThursdayStart(), openHour.getThursdayEnd()))
                .friday(convertToOpeningTime(openHour.getFridayStart(), openHour.getFridayEnd()))
                .saturday(convertToOpeningTime(openHour.getSaturdayStart(), openHour.getSaturdayEnd()))
                .sunday(convertToOpeningTime(openHour.getSundayStart(), openHour.getSundayEnd()))
                .sportFacility(existingOpenHour.getSportFacility())
                .build();

        return new ResponseEntity<>(openHourService.saveOpenHour(newOpenHour), HttpStatus.OK);


    }

    @DeleteMapping("delete/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteOpenHour(@PathVariable("id") int id){

        OpenHour openHour = openHourRepository.findById(id)
                .orElseThrow(() -> new OpenHourNotFoundException("Nie znaleziono godzin otwarcia dla podanego obiektu"));

        userService.checkIfUserIsManagerOrAdmin(openHour.getSportFacility());

        openHourService.deleteOpenHour(openHour);

    }

    private static OpeningTime convertToOpeningTime(LocalTime start, LocalTime end) {
        if (start == null && end == null) {
            return null;
        }
        return new OpeningTime(start, end);
    }

}
