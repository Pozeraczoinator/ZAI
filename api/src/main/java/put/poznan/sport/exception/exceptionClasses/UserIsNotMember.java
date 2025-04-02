package put.poznan.sport.exception.exceptionClasses;

public class UserIsNotMember extends RuntimeException {

    public UserIsNotMember(String message) {
        super(message);
    }
}
