package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.SportFacilityParticipant.SportFacilityParticipantDTO;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.service.sportFacilityParcticipant.SportFacilityParticipantService;

import java.util.List;

@RestController
@RequestMapping("api/participant/")
public class SportFacilityParticipantController {

    @Autowired
    private SportFacilityParticipantService sportFacilityParticipantService;

    @GetMapping("all")
    @ResponseBody
    public ResponseEntity<?> getAllSportFacilityParticipants() {
        return new ResponseEntity<>(sportFacilityParticipantService.getAllFacilityParticipants(), HttpStatus.OK);
    }

    @GetMapping("facility/{facilityId}")
    @ResponseBody
    public ResponseEntity<?> getUsersBySportFacility(@PathVariable Integer facilityId) {
        return new ResponseEntity<>(sportFacilityParticipantService.getUsersBySportFacility(facilityId), HttpStatus.OK);
    }

    @GetMapping("facilities")
    @ResponseBody
    public ResponseEntity<List<SportFacility>> getSportFacilitiesForLoggedInUser() {
        return new ResponseEntity<>(sportFacilityParticipantService.getSportFacilitiesByCurrentUser(), HttpStatus.OK);
    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createSportFacilityParticipant(@RequestBody SportFacilityParticipantDTO sportFacilityParticipant) {
        return new ResponseEntity<>(sportFacilityParticipantService.createSportFacilityParticipant(sportFacilityParticipant), HttpStatus.OK);
    }


    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> changeParticipantStatus(@RequestBody SportFacilityParticipantDTO sportFacilityParticipant) {
        return new ResponseEntity<>(sportFacilityParticipantService.changeParticipantStatus(sportFacilityParticipant), HttpStatus.OK);

    }

    @DeleteMapping("delete/{userId}/{facilityId}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteSportFacilityParticipantById(@PathVariable Integer userId, @PathVariable Integer facilityId) {
        sportFacilityParticipantService.deleteSportFacilityParticipant(userId, facilityId);
    }

}
