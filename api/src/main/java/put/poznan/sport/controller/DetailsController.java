package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.response.SportFacilityDetailsResponse;
import put.poznan.sport.service.Details.SportFacilityDetailsService;

@RestController
@RequestMapping("/api/details")
public class DetailsController {

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Autowired
    private SportFacilityDetailsService sportFacilityDetailsService;

    @GetMapping("/{id}")
    public ResponseEntity<SportFacilityDetailsResponse> getSportFacilityDetails(@PathVariable Integer id) {
        SportFacility sportFacility = sportFacilityRepository.findById(id)
                .orElseThrow(() -> new SportFacilityNotFoundException("Obiekt sportowy nie znaleziony"));

        SportFacilityDetailsResponse response = sportFacilityDetailsService.getSportFacilityDetails(sportFacility);
        return ResponseEntity.ok(response);
    }
}
