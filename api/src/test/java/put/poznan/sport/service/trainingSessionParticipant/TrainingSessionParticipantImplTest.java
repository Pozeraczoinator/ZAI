package put.poznan.sport.service.trainingSessionParticipant;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.entity.TrainingSessionParticipant;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.*;
import put.poznan.sport.repository.SportFacilityParticipantRepository;
import put.poznan.sport.repository.TrainingSessionParticipantRepository;
import put.poznan.sport.repository.TrainingSessionRepository;
import put.poznan.sport.repository.UserRepository;
import put.poznan.sport.service.user.UserService;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class TrainingSessionParticipantImplTest {

    @Mock
    private TrainingSessionParticipantRepository participantRepository;

    @Mock
    private UserService userService;

    @Mock
    private UserRepository userRepository;

    @Mock
    private TrainingSessionRepository trainingSessionRepository;

    @Mock
    private SportFacilityParticipantRepository sportFacilityParticipantRepository;

    @InjectMocks
    private TrainingSessionParticipantImpl participantService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getAllParticipant_ShouldReturnListOfParticipants() {
        // given
        int trainingId = 1;
        User user1 = User.builder().id(1).name("Jan").build();
        User user2 = User.builder().id(2).name("Anna").build();

        TrainingSessionParticipant participant1 = TrainingSessionParticipant.builder()
                .userId(1)
                .trainingSessionId(trainingId)
                .user(user1)
                .build();
        TrainingSessionParticipant participant2 = TrainingSessionParticipant.builder()
                .userId(2)
                .trainingSessionId(trainingId)
                .user(user2)
                .build();

        when(participantRepository.findAllByTrainingSessionId(trainingId))
                .thenReturn(Optional.of(Arrays.asList(participant1, participant2)));

        // when
        List<TrainingSessionParticipant> result = participantService.getAllParticipant(trainingId);

        // then
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    void joinTraining_ShouldAddParticipant() {
        // given
        int trainingId = 1;
        String userEmail = "test@example.com";
        User user = User.builder()
                .id(1)
                .email(userEmail)
                .build();

        SportFacility facility = SportFacility.builder()
                .id(1)
                .membershipRequired(false)
                .build();

        TrainingSession training = TrainingSession.builder()
                .id(trainingId)
                .capacity(10)
                .freeBooked(5)
                .sportFacility(facility)
                .build();

        when(userService.getCurrentUsername()).thenReturn(userEmail);
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(trainingSessionRepository.findById(trainingId)).thenReturn(Optional.of(training));
        when(participantRepository.existsByUserIdAndTrainingSessionId(user.getId(), trainingId))
                .thenReturn(false);

        TrainingSessionParticipant savedParticipant = TrainingSessionParticipant.builder()
                .userId(user.getId())
                .trainingSessionId(trainingId)
                .build();

        when(participantRepository.save(any(TrainingSessionParticipant.class)))
                .thenReturn(savedParticipant);

        // when
        TrainingSessionParticipant result = participantService.joinTraining(trainingId);

        // then
        assertNotNull(result);
        assertEquals(user.getId(), result.getUserId());
        assertEquals(trainingId, result.getTrainingSessionId());
        verify(trainingSessionRepository).save(training);
    }

    @Test
    void leaveTraining_ShouldRemoveParticipant() {
        // given
        int trainingId = 1;
        String userEmail = "test@example.com";
        User user = User.builder()
                .id(1)
                .email(userEmail)
                .build();

        TrainingSession training = TrainingSession.builder()
                .id(trainingId)
                .freeBooked(4)
                .build();

        when(userService.getCurrentUsername()).thenReturn(userEmail);
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(trainingSessionRepository.findById(trainingId)).thenReturn(Optional.of(training));
        when(participantRepository.findById(any())).thenReturn(Optional.of(new TrainingSessionParticipant()));

        // when
        participantService.leaveTraining(trainingId);

        // then
        assertEquals(5, training.getFreeBooked());
        verify(participantRepository).deleteById(any());
        verify(trainingSessionRepository).save(training);
    }
} 