package put.poznan.sport.exception;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import put.poznan.sport.exception.model.ErrorObject;

import java.security.SignatureException;
import java.util.Date;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({
            RuntimeException.class,
            DataIntegrityViolationException.class
    })
    public ResponseEntity<ErrorObject> handleException(Exception exception) {
        ErrorObject errorObject = new ErrorObject();
        HttpStatus status;

        if (exception instanceof DataIntegrityViolationException) {
            status = HttpStatus.CONFLICT;
            errorObject.setMessage("Wystąpił błąd zapisu do bazy danych.");
        } else {
            status = HttpStatus.BAD_REQUEST;
            errorObject.setMessage(exception.getMessage());
        }

        errorObject.setStatusCode(status.value());
        errorObject.setTimestamp(new Date());

        log.error("Exception occurred: ", exception);

        return new ResponseEntity<>(errorObject, status);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorObject> handleValidationExceptions(MethodArgumentNotValidException ex) {
        ErrorObject errorObject = new ErrorObject();

        FieldError error = ex.getBindingResult().getFieldErrors().get(0);

        errorObject.setMessage(error.getDefaultMessage());
        errorObject.setStatusCode(HttpStatus.BAD_REQUEST.value());
        errorObject.setTimestamp(new Date());

        log.warn("Validation error: {}", error.getDefaultMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorObject> handleIllegalArgumentException(IllegalArgumentException ex) {
        ErrorObject errorObject = new ErrorObject();

        errorObject.setMessage("Przesłano niepoprawną wartość stałej");
        errorObject.setStatusCode(HttpStatus.BAD_REQUEST.value());
        errorObject.setTimestamp(new Date());

        log.warn("IllegalArgumentException: {}", ex.getMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ExpiredJwtException.class)
    public ResponseEntity<ErrorObject> handleExpiredJwtException(ExpiredJwtException ex) {
        ErrorObject errorObject = new ErrorObject();
        errorObject.setMessage("Token wygasł.");
        errorObject.setStatusCode(HttpStatus.UNAUTHORIZED.value());
        errorObject.setTimestamp(new Date());

        log.warn("ExpiredJwtException: {}", ex.getMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(UnsupportedJwtException.class)
    public ResponseEntity<ErrorObject> handleUnsupportedJwtException(UnsupportedJwtException ex) {
        ErrorObject errorObject = new ErrorObject();
        errorObject.setMessage("Nieobsługiwany token.");
        errorObject.setStatusCode(HttpStatus.UNAUTHORIZED.value());
        errorObject.setTimestamp(new Date());

        log.warn("UnsupportedJwtException: {}", ex.getMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(MalformedJwtException.class)
    public ResponseEntity<ErrorObject> handleMalformedJwtException(MalformedJwtException ex) {
        ErrorObject errorObject = new ErrorObject();
        errorObject.setMessage("Niepoprawny format tokenu.");
        errorObject.setStatusCode(HttpStatus.UNAUTHORIZED.value());
        errorObject.setTimestamp(new Date());

        log.warn("MalformedJwtException: {}", ex.getMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(SignatureException.class)
    public ResponseEntity<ErrorObject> handleSignatureException(SignatureException ex) {
        ErrorObject errorObject = new ErrorObject();
        errorObject.setMessage("Błąd weryfikacji podpisu tokenu.");
        errorObject.setStatusCode(HttpStatus.UNAUTHORIZED.value());
        errorObject.setTimestamp(new Date());

        log.warn("SignatureException: {}", ex.getMessage());

        return new ResponseEntity<>(errorObject, HttpStatus.UNAUTHORIZED);
    }

}
