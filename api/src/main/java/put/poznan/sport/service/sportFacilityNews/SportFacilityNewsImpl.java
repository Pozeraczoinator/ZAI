package put.poznan.sport.service.sportFacilityNews;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.SportFacilityNews.SportFacilityNewsDTO;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNewsNotFoundException;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.repository.SportFacilityNewsRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.service.user.UserService;

import java.util.List;

@Service
public class SportFacilityNewsImpl implements SportFacilityNewsService {

    @Autowired
    private SportFacilityNewsRepository sportFacilityNewsRepository;

    @Autowired
    private SportFacilityRepository sportFacilityRepository;


    @Autowired
    private UserService userService;

    @Override
    public List<SportFacilityNews> getAllFacilityNews() {
        return sportFacilityNewsRepository.findAll();
    }

    @Override
    public List<SportFacilityNews> getFacilityNewsBySportFacilityId(int sportFacilityId) {
        return sportFacilityNewsRepository.findBySportFacilityId(sportFacilityId)
                .orElseThrow(null);
    }

    @Override
    public SportFacilityNews createFacilityNews(SportFacilityNewsDTO facilityNews) {

        SportFacility sportFacility = sportFacilityRepository.findById(facilityNews.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + facilityNews.getSportFacilityId()));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        SportFacilityNews sportFacilityNews = SportFacilityNews.builder()
                .title(facilityNews.getTitle())
                .sportFacilityId(sportFacility.getId())
                .description(facilityNews.getDescription())
                .imageUrl(facilityNews.getImageUrl())
                .sportFacility(sportFacility)
                .build();


        return sportFacilityNewsRepository.save(sportFacilityNews);
    }

    @Override
    public SportFacilityNews updateFacilityNews(SportFacilityNewsDTO facilityNewsDTO) {

        SportFacilityNews existingFacilityNews = sportFacilityNewsRepository.findById(facilityNewsDTO.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNewsNotFoundException("Nie znaleziono wiadomosci o id " + facilityNewsDTO.getSportFacilityNewsID()));

        SportFacility sportFacility = sportFacilityRepository.findById(facilityNewsDTO.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + facilityNewsDTO.getSportFacilityId()));

        userService.checkIfUserIsManagerOrAdmin(sportFacility);

        existingFacilityNews.setTitle(facilityNewsDTO.getTitle());
        existingFacilityNews.setDescription(facilityNewsDTO.getDescription());
        existingFacilityNews.setImageUrl(facilityNewsDTO.getImageUrl());

        return sportFacilityNewsRepository.save(existingFacilityNews);
    }


    @Override
    public void deleteFacilityNews(int id) {
        SportFacilityNews facilityNews = sportFacilityNewsRepository.findById(id)
                .orElseThrow(() -> new SportFacilityNewsNotFoundException("Nie znaleziono wiadomości o " + id));

        userService.checkIfUserIsManagerOrAdmin(facilityNews.getSportFacility());

        sportFacilityNewsRepository.deleteById(id);
    }
}
