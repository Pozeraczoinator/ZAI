package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.service.trainingSessionParticipant.TrainingSessionParticipantService;

@RestController
@RequestMapping("api/training/participant/")
public class TrainingSessionParticipantController {

    @Autowired
    private TrainingSessionParticipantService trainingSessionParticipantService;

    @GetMapping("/user/training")
    @ResponseBody
    public ResponseEntity<?> getUsersCurrentTrainings() {
        return new ResponseEntity<>(trainingSessionParticipantService.getCurrentUserTrainings(), HttpStatus.OK);
    }

    @GetMapping("all/{trainingId}")
    @ResponseBody
    public ResponseEntity<?> getAllParticipant(@PathVariable  int trainingId) {
        return new ResponseEntity<>(trainingSessionParticipantService.getAllParticipant(trainingId),HttpStatus.OK);
    }

    @PostMapping("join/{trainingId}")
    @ResponseBody
    public ResponseEntity<?> joinSession(@PathVariable int trainingId) {
        return new ResponseEntity<>(trainingSessionParticipantService.joinTraining(trainingId),HttpStatus.OK);
    }

    @DeleteMapping("delete/{trainingId}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void leaveTraining(@PathVariable int trainingId) {
        trainingSessionParticipantService.leaveTraining(trainingId);
    }
}
