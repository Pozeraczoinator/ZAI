package put.poznan.sport.service.sportFacility;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.Manager.ManagerDTO;
import put.poznan.sport.dto.SportFacility.SportFacilityDTO;
import put.poznan.sport.entity.Authority;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.sportFacility.SportFacilityType;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNotFoundException;
import put.poznan.sport.exception.exceptionClasses.UserNotFoundException;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.repository.UserRepository;
import put.poznan.sport.service.user.UserService;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

@Service
public class SportFacilityImpl implements SportFacilityService {

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;

    @Override
    public List<SportFacility> getAllFacilities() {
        return sportFacilityRepository.findAll();
    }

    @Override
    public SportFacility getSportFacilityById(int id) {
        return sportFacilityRepository.findById(id)
                .orElseThrow(() -> new SportFacilityNotFoundException("SportFacility with id " + id + " not found"));
    }

    @Override
    public SportFacility createSportFacility(SportFacilityDTO facilityDTO) {
        User currentUser = userRepository.getById(1);
        SportFacility sportFacility = SportFacility.builder()
                .name(facilityDTO.getName())
                .description(facilityDTO.getDescription())
                .address(facilityDTO.getAddress())
                .type(SportFacilityType.valueOf(facilityDTO.getType()).getName())
                .membershipRequired(facilityDTO.isMembershipRequired())
                .imageUrl(facilityDTO.getImageUrl())
                .managers(Collections.singletonList(currentUser))
                .build();

        return sportFacilityRepository.save(sportFacility);
    }

    @Override
    public SportFacility updateSportFacility(SportFacilityDTO facilityDTO) {
        SportFacility sportFacility = sportFacilityRepository.findById(facilityDTO.getId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + facilityDTO.getId()));

        if (facilityDTO.getName() != null) {
            sportFacility.setName(facilityDTO.getName());
        }
        if (facilityDTO.getDescription() != null) {
            sportFacility.setDescription(facilityDTO.getDescription());
        }
        if (facilityDTO.getAddress() != null) {
            sportFacility.setAddress(facilityDTO.getAddress());
        }
        if (facilityDTO.getType() != null) {
            sportFacility.setType(SportFacilityType.valueOf(facilityDTO.getType()).getName());
        }

        sportFacility.setMembershipRequired(facilityDTO.isMembershipRequired());

        if (facilityDTO.getImageUrl() != null) {
            sportFacility.setImageUrl(facilityDTO.getImageUrl());
        }

        return sportFacilityRepository.save(sportFacility);
    }

    @Override
    public void deleteSportFacility(int id) {
        SportFacility facility = sportFacilityRepository.findById(id)
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + id));

        sportFacilityRepository.delete(facility);
    }

    @Override
    @Transactional
    public SportFacility addManager(ManagerDTO managerDTO) {
        SportFacility facility = sportFacilityRepository.findById(managerDTO.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + managerDTO.getSportFacilityId()));

        User newManager = userRepository.getById(1);
        Collection<Authority> updatedAuthorities = new HashSet<>();
        for (GrantedAuthority authority : newManager.getAuthorities()) {
            if (authority instanceof Authority) {
                updatedAuthorities.add((Authority) authority);
            }
        }

        if (!facility.getManagers().contains(newManager)) {
            updatedAuthorities.add(Authority.MANAGER);
            newManager.setAuthorities(updatedAuthorities);
            facility.getManagers().add(newManager);
            newManager.getManagedFacilities().add(facility);
            sportFacilityRepository.save(facility);
            userRepository.save(newManager);
        }

        return sportFacilityRepository.save(facility);
    }

    @Override
    @Transactional
    public SportFacility deleteManager(ManagerDTO managerDTO) {
        SportFacility facility = sportFacilityRepository.findById(managerDTO.getSportFacilityId())
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o id " + managerDTO.getSportFacilityId()));

        User managerToDelete = userRepository.findById(managerDTO.getUserId())
                .orElseThrow(() -> new UserNotFoundException("Nie znaleziono użytkownika o id: " + managerDTO.getUserId()));

        Collection<Authority> updatedAuthorities = new HashSet<>();
        for (GrantedAuthority authority : managerToDelete.getAuthorities()) {
            if (authority instanceof Authority) {
                updatedAuthorities.add((Authority) authority);
            }
        }

        facility.getManagers().remove(managerToDelete);
        managerToDelete.getManagedFacilities().remove(facility);

        if (managerToDelete.getManagedFacilities().isEmpty()) {
            updatedAuthorities.remove(Authority.MANAGER);
            managerToDelete.setAuthorities(updatedAuthorities);
            sportFacilityRepository.save(facility);
            userRepository.save(managerToDelete);
        }

        return sportFacilityRepository.save(facility);
    }

    @Override
    public List<User> getManagerByFacility(int id) {
        SportFacility facilities = sportFacilityRepository.findById(id)
                .orElseThrow(() -> new SportFacilityNotFoundException("Nie znaleziono obiektu o takim id: " + id));

        return facilities.getManagers();
    }

}
