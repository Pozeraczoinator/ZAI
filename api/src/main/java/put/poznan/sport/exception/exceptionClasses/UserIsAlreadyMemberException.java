package put.poznan.sport.exception.exceptionClasses;

public class UserIsAlreadyMemberException extends RuntimeException {

    public UserIsAlreadyMemberException(String message) {
        super(message);
    }
}
