package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.SportFacilityNews.SportFacilityNewsDTO;
import put.poznan.sport.service.sportFacilityNews.SportFacilityNewsService;

@RestController
@RequestMapping("api/SportFacilityNews/")
public class SportFacilityNewsController {

    @Autowired
    private SportFacilityNewsService sportFacilityNewsService;

    @GetMapping
    @ResponseBody
    public ResponseEntity<?> getAllSportFacilityNews() {
        return new ResponseEntity<>(sportFacilityNewsService.getAllFacilityNews(), HttpStatus.OK);
    }

    @PostMapping("create")
    @ResponseBody
    public ResponseEntity<?> createSportFacilityNews(@RequestBody SportFacilityNewsDTO news) {
        return new ResponseEntity<>(sportFacilityNewsService.createFacilityNews(news), HttpStatus.CREATED);
    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<?> updateSportFacilityNews(@RequestBody SportFacilityNewsDTO news) {
        return new ResponseEntity<>(sportFacilityNewsService.updateFacilityNews(news), HttpStatus.OK);
    }

    @DeleteMapping("delete/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public void deleteSportFacilityNews(@PathVariable("id") Integer id) {
        sportFacilityNewsService.deleteFacilityNews(id);
    }
}
