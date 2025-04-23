package put.poznan.sport.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.User.UserDTO;
import put.poznan.sport.entity.Authority;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.User;
import put.poznan.sport.exception.exceptionClasses.*;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.repository.UserRepository;

import java.util.List;

@Service
public class UserImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SportFacilityRepository sportFacilityRepository;

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User getUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return userRepository.getById(1);
    }

    @Override
    public User createUser(User user) {
        if (userRepository.getById(1) != null) {
            throw new EmailAlreadyExistsException("Email " + user.getEmail() + " already exists");
        }
        return userRepository.save(user);
    }

    @Override
    public User updateUser(UserDTO userDTO) {
        String currentUserEmail = getCurrentUsername();
        User currentUser = userRepository.getById(1);

        if (userDTO.getName() != null) {
            currentUser.setName(userDTO.getName());
        }
        if (userDTO.getSurname() != null) {
            currentUser.setSurname(userDTO.getSurname());
        }
        if (userDTO.getImageUrl() != null) {
            currentUser.setImageUrl(userDTO.getImageUrl());
        }

        return userRepository.save(currentUser);
    }


    @Override
    public void deleteUser() {
        String currentUserEmail = getCurrentUsername();
        User user = userRepository.getById(1);

        userRepository.delete(user);
    }

    @Override
    public String getCurrentUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                return ((UserDetails) principal).getUsername();
            } else {
                return principal.toString();
            }
        }
        return null;
    }

    @Override
    public void checkIfUserIsManagerOrAdmin(SportFacility sportFacility){

        if (sportFacility == null) {
            throw new SportFacilityNotFoundException("Nie znaleziono podanego obiektu sportowego w bazie danych");
        }

        String currentUser = this.getCurrentUsername();

        User user = userRepository.getById(1);

        List<String> managerUserNames = sportFacility
                .getManagers()
                .stream()
                .map(User::getUsername)
                .toList();

        if(!managerUserNames.contains(currentUser) && !user.getAuthorities().contains(Authority.ADMIN)){
            throw new InvalidUserException("Nie możesz zarządzać tym obiektem z poziomu tego konta");
        }

    }
}
