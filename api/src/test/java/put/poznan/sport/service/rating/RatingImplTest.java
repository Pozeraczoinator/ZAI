package put.poznan.sport.service.rating;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import put.poznan.sport.dto.Rating.ObjectRating;
import put.poznan.sport.dto.Rating.ObjectType;
import put.poznan.sport.dto.Rating.Rating;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.rating.CoachRating;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.CoachNotFoundException;
import put.poznan.sport.exception.exceptionClasses.RatingAlreadyExistsException;
import put.poznan.sport.repository.CoachRepository;
import put.poznan.sport.repository.rating.CoachRatingRepository;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class RatingImplTest {

    @Mock
    private CoachRepository coachRepository;

    @Mock
    private CoachRatingRepository coachRatingRepository;

    @InjectMocks
    private RatingImpl ratingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getAllRatings_ShouldReturnCoachRating_WhenTypeIsCoach() {
        // given
        ObjectRating request = ObjectRating.builder()
                .objectType(ObjectType.COACH.name())
                .objectId(1)
                .build();

        Coach coach = Coach.builder()
                .id(1)
                .name("Jan")
                .surname("Kowalski")
                .build();

        when(coachRepository.findById(1)).thenReturn(Optional.of(coach));
        when(coachRatingRepository.findCoachAverage(coach)).thenReturn(Optional.of(4.5));

        // when
        ObjectRating result = ratingService.getAllRatings(request);

        // then
        assertNotNull(result);
        assertEquals(4.5, result.getRatingAvg());
        verify(coachRepository).findById(1);
        verify(coachRatingRepository).findCoachAverage(coach);
    }

    @Test
    void createRating_ShouldThrowException_WhenRatingAlreadyExists() {
        // given
        User user = User.builder()
                .id(1)
                .email("test@example.com")
                .build();

        Coach coach = Coach.builder()
                .id(1)
                .name("Jan")
                .surname("Kowalski")
                .sportFacility(new SportFacility())
                .build();

        Rating rating = Rating.builder()
                .objectType(ObjectType.COACH.name())
                .objectId(1)
                .rate(5)
                .addedBy(user)
                .build();

        when(coachRepository.findById(1)).thenReturn(Optional.of(coach));
        when(coachRatingRepository.findByUserAndCoach(user, coach))
                .thenReturn(Optional.of(new CoachRating()));

        // when & then
        assertThrows(RatingAlreadyExistsException.class, () -> ratingService.createRating(rating));
    }

    @Test
    void createRating_ShouldThrowException_WhenCoachNotFound() {
        // given
        Rating rating = Rating.builder()
                .objectType(ObjectType.COACH.name())
                .objectId(999)
                .rate(5)
                .build();

        when(coachRepository.findById(999)).thenReturn(Optional.empty());

        // when & then
        assertThrows(CoachNotFoundException.class, () -> ratingService.createRating(rating));
    }
} 