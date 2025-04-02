package put.poznan.sport.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.SportEquipment.CreateSportEquipment;
import put.poznan.sport.dto.SportEquipment.UpdateSportEquipment;
import put.poznan.sport.service.sportEquipment.SportEquipmentService;

@RestController
@RequestMapping("api/equipment/")
public class SportEquipmentController {

    @Autowired
    private SportEquipmentService sportEquipmentService;

    @GetMapping("{id}")
    @ResponseBody
    public ResponseEntity<?> getEquipmentById(@PathVariable int id) {

        return new ResponseEntity<>(sportEquipmentService.getEquipmentsById(id), HttpStatus.OK);

    }

    @GetMapping("/sport/{id}")
    @ResponseBody
    public ResponseEntity<?> getEquipmentBySportFacility(@PathVariable int id) {

        return new ResponseEntity<>(sportEquipmentService.getEquipmentsBySportFacility(id), HttpStatus.OK);

    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createEquipment(@Valid @RequestBody CreateSportEquipment sportEquipment) {

        return new ResponseEntity<>(sportEquipmentService.createEquipment(sportEquipment), HttpStatus.OK);
    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> updateEquipment(@Valid @RequestBody UpdateSportEquipment sportEquipment) {

        return new ResponseEntity<>(sportEquipmentService.updateEquipment(sportEquipment), HttpStatus.OK);

    }

    @DeleteMapping("delete/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteEquipment(@PathVariable int id) {
        sportEquipmentService.deleteEquipment(id);
    }
}
