package put.poznan.sport.exception.exceptionClasses;

public class UserIsAlreadyParticipantException extends RuntimeException{
    public UserIsAlreadyParticipantException(String message) {
        super(message);
    }
}
