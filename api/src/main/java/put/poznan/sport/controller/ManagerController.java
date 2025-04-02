package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.Manager.ManagerDTO;
import put.poznan.sport.service.sportFacility.SportFacilityService;

@RestController
@RequestMapping("/api/manager")
public class ManagerController {

    @Autowired
    private SportFacilityService sportFacilityService;

    @PostMapping("/add")
    public ResponseEntity<?> addManager(@RequestBody ManagerDTO managerDTO) {
        return new ResponseEntity<>(sportFacilityService.addManager(managerDTO), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getManagerBySportFacility(@PathVariable int id) {
        return new ResponseEntity<>(sportFacilityService.getManagerByFacility(id), HttpStatus.OK);
    }

    @PostMapping("/delete")
    public ResponseEntity<?> deleteManager(@RequestBody ManagerDTO managerDTO) {
        return new ResponseEntity<>(sportFacilityService.deleteManager(managerDTO), HttpStatus.OK);
    }

}
