package put.poznan.sport.service.jwt;

import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import put.poznan.sport.dto.LoginUserDto;
import put.poznan.sport.dto.RegisterUserDto;
import put.poznan.sport.entity.User;
import put.poznan.sport.repository.UserRepository;

@Service
@AllArgsConstructor
public class AuthenticationService {
    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    private final AuthenticationManager authenticationManager;

    public User signup(RegisterUserDto input) {
        User user = User.builder()
                .name(input.getName())
                .surname(input.getSurname())
                .email(input.getEmail())
                .password(passwordEncoder.encode(input.getPassword()))
                .imageUrl(input.getImageUrl())
                .build();

        userRepository.save(user);

        return user;
    }

    public User authenticate(LoginUserDto input) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        input.getEmail(),
                        input.getPassword()
                )
        );

        return userRepository.findByEmail(input.getEmail())
                .orElseThrow();
    }
}

