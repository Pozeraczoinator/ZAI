package put.poznan.sport.exception.exceptionClasses;

public class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(String message) {
        super(message);
    }
}
