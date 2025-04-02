package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.Coach.CoachUpdate;
import put.poznan.sport.dto.Coach.CreateCoach;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.CoachNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportEquipmentNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.repository.CoachRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.service.coach.CoachImpl;
import put.poznan.sport.service.user.UserImpl;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@RestController
@RequestMapping("api/coach/")
public class CoachController {
    @Autowired
    private CoachImpl coachService;

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Autowired
    private CoachRepository coachRepository;

    @Autowired
    private UserImpl userService;

    @GetMapping("allBySportFacility")
    @ResponseBody
    public ResponseEntity<?> getSportFacilityCoaches(@RequestParam Integer sportFacilityID) {

        Optional<SportFacility> sportFacility = Optional.ofNullable(sportFacilityRepository.findById(sportFacilityID)
                .orElseThrow(() -> new SportEquipmentNotFoundException("Nie zaleziono obiektu sportowego")));

        List<Coach> coaches;
        if (sportFacility.isPresent()) {
            coaches = sportFacility.get().getCoaches()
                    .stream()
                    .toList();
        } else {
            throw new CoachNotFoundException("Nie zaleziono trenerów w podanym obieckie");
        }

        return new ResponseEntity<>(coaches, HttpStatus.OK);
    }

    @GetMapping("all")
    @ResponseBody
    public ResponseEntity<?> getAllCoaches() {
        return new ResponseEntity<>(coachService.getAllCoaches(), HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseBody
    public ResponseEntity<?> getCoachById(@PathVariable int id) {
        return new ResponseEntity<>(coachService.getCoachById(id), HttpStatus.OK);
    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createCoach(@RequestBody @Valid CreateCoach coachDTO) {

        SportFacility sportFacility = sportFacilityRepository.findById(coachDTO.getSportFacilitiesId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie zaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        Coach coach = Coach.builder()
                .name(coachDTO.getName())
                .surname(coachDTO.getSurname())
                .sportFacility(sportFacility)
                .imageUrl(coachDTO.getImageUrl())
                .build();

        return new ResponseEntity<>(coachService.createCoach(coach), HttpStatus.OK);
    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> updateCoach(@RequestBody @Valid CoachUpdate coachDTO) {

        SportFacility sportFacility = sportFacilityRepository.findById(coachDTO.getSportFacilitiesId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie zaleziono obiektu sportowego"));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        Coach coach = sportFacility.getCoaches()
                .stream()
                .filter(c -> Objects.equals(c.getId(), coachDTO.getId()))
                .findFirst()
                .orElseThrow(() -> new CoachNotFoundException("Nie znaleziono trenera w podanym obiekcie sportowym"));


        return new ResponseEntity<>(coachService.updateCoach(coachDTO, coach), HttpStatus.OK);
    }

    @DeleteMapping("delete/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteCoach(@PathVariable int id) {

        Coach coach = coachRepository.findById(id).orElseThrow(() -> new CoachNotFoundException("Nie znaleziono podanego trenera"));

        userService.checkIfUserIsManagerOrAdmin(coach.getSportFacility());

        coachService.deleteCoach(coach);

    }
}
