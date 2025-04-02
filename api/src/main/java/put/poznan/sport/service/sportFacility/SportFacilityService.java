package put.poznan.sport.service.sportFacility;

import jakarta.transaction.Transactional;
import put.poznan.sport.dto.Manager.ManagerDTO;
import put.poznan.sport.dto.SportFacility.SportFacilityDTO;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.sportFacility.SportFacility;

import java.util.List;


public interface SportFacilityService {

    List<SportFacility> getAllFacilities();

    SportFacility getSportFacilityById(int id) ;

    SportFacility createSportFacility(SportFacilityDTO sportFacility) ;

    SportFacility updateSportFacility(SportFacilityDTO sportFacility);

    void deleteSportFacility(int id);

    @Transactional
    SportFacility addManager(ManagerDTO managerDTO);

    @Transactional
    SportFacility deleteManager(ManagerDTO managerDTO);

    List<User> getManagerByFacility(int id);
}
