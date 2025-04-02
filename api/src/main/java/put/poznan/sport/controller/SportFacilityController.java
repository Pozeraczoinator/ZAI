package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.SportFacility.SportFacilityDTO;
import put.poznan.sport.service.sportFacility.SportFacilityService;

@RestController
@RequestMapping("api/sportFacility/")
public class SportFacilityController {

    @Autowired
    private SportFacilityService sportFacilityService;

    @GetMapping("all")
    @ResponseBody
    public ResponseEntity<?> getAllSportFacilities() {
        return new ResponseEntity<>(sportFacilityService.getAllFacilities(), HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseBody
    public ResponseEntity<?> getSportFacilityById(@PathVariable("id") int id) {
        return new ResponseEntity<>(sportFacilityService.getSportFacilityById(id), HttpStatus.OK);
    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createSportFacility(@RequestBody SportFacilityDTO sportFacility) {
        return new ResponseEntity<>(sportFacilityService.createSportFacility(sportFacility), HttpStatus.OK);
    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> updateSportFacility(@RequestBody SportFacilityDTO sportFacility) {
        return new ResponseEntity<>(sportFacilityService.updateSportFacility(sportFacility), HttpStatus.OK);
    }

    @DeleteMapping("delete/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteSportFacility(@PathVariable("id") int id) {
        sportFacilityService.deleteSportFacility(id);
    }
}
