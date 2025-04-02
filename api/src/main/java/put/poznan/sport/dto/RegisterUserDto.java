package put.poznan.sport.dto;

import lombok.Data;

@Data
public class RegisterUserDto {
    private String email;

    private String password;

    private String name;

    private String surname;

    private String imageUrl;

}
