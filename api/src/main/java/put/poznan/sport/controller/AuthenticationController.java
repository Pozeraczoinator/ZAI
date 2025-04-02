package put.poznan.sport.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import put.poznan.sport.dto.LoginUserDto;
import put.poznan.sport.dto.RegisterUserDto;
import put.poznan.sport.entity.User;
import put.poznan.sport.service.jwt.AuthenticationService;
import put.poznan.sport.service.jwt.JwtService;
import put.poznan.sport.response.AccountResponse;
@RequestMapping("/auth")
@RestController
public class AuthenticationController {
    private final JwtService jwtService;

    private final AuthenticationService authenticationService;

    public AuthenticationController(JwtService jwtService, AuthenticationService authenticationService) {
        this.jwtService = jwtService;
        this.authenticationService = authenticationService;
    }

    @PostMapping("/signup")
    public ResponseEntity<AccountResponse> register(@RequestBody @Validated RegisterUserDto registerUserDto) {
        User registeredUser = authenticationService.signup(registerUserDto);

        String jwtToken = jwtService.generateToken(registeredUser);

        AccountResponse loginResponse = AccountResponse.builder()
                .token(jwtToken)
                .expiresIn(jwtService.getExpirationTime())
                .build();

        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping("/login")
    public ResponseEntity<AccountResponse> authenticate(@RequestBody @Validated LoginUserDto loginUserDto) {
        User authenticatedUser = authenticationService.authenticate(loginUserDto);

        String jwtToken = jwtService.generateToken(authenticatedUser);

        AccountResponse loginResponse = AccountResponse.builder()
                .token(jwtToken)
                .expiresIn(jwtService.getExpirationTime())
                .build();

        return ResponseEntity.ok(loginResponse);
    }
}

