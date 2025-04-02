package put.poznan.sport.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
@Data
@Builder
@AllArgsConstructor
public class AccountResponse {
    private String token;

    private long expiresIn;

}
