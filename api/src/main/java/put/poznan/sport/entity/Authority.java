package put.poznan.sport.entity;

import org.springframework.security.core.GrantedAuthority;


public enum Authority implements GrantedAuthority {
    USER,
    ADMIN,
    MANAGER;

    @Override
    public String getAuthority() {
        return name();
    }
}


