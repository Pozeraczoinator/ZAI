package put.poznan.sport.service.coach;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import put.poznan.sport.dto.Coach.CoachCreateResponse;
import put.poznan.sport.dto.Coach.CoachUpdate;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.CoachNotFoundException;
import put.poznan.sport.repository.CoachRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class CoachImplTest {

    @Mock
    private CoachRepository coachRepository;

    @InjectMocks
    private CoachImpl coachService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getAllCoaches_ShouldReturnListOfCoaches() {
        // given
        Coach coach1 = Coach.builder()
                .id(1)
                .name("Jan")
                .surname("Kowalski")
                .build();
        Coach coach2 = Coach.builder()
                .id(2)
                .name("Anna")
                .surname("Nowak")
                .build();

        when(coachRepository.findAll()).thenReturn(Arrays.asList(coach1, coach2));

        // when
        List<Coach> result = coachService.getAllCoaches();

        // then
        assertNotNull(result);
        assertEquals(2, result.size());
        verify(coachRepository).findAll();
    }

    @Test
    void getCoachById_ShouldReturnCoach_WhenCoachExists() {
        // given
        int coachId = 1;
        Coach coach = Coach.builder()
                .id(coachId)
                .name("Jan")
                .surname("Kowalski")
                .build();

        when(coachRepository.findById(coachId)).thenReturn(Optional.of(coach));

        // when
        Coach result = coachService.getCoachById(coachId);

        // then
        assertNotNull(result);
        assertEquals(coachId, result.getId());
        assertEquals("Jan", result.getName());
    }

    @Test
    void getCoachById_ShouldThrowException_WhenCoachNotFound() {
        // given
        int coachId = 999;
        when(coachRepository.findById(coachId)).thenReturn(Optional.empty());

        // when & then
        assertThrows(CoachNotFoundException.class, () -> coachService.getCoachById(coachId));
    }

    @Test
    void createCoach_ShouldReturnCoachCreateResponse() {
        // given
        SportFacility facility = SportFacility.builder()
                .id(1)
                .name("Test Facility")
                .build();

        Coach coach = Coach.builder()
                .name("Jan")
                .surname("Kowalski")
                .sportFacility(facility)
                .imageUrl("image.jpg")
                .build();

        Coach savedCoach = Coach.builder()
                .id(1)
                .name("Jan")
                .surname("Kowalski")
                .sportFacility(facility)
                .imageUrl("image.jpg")
                .build();

        when(coachRepository.save(any(Coach.class))).thenReturn(savedCoach);

        // when
        CoachCreateResponse result = coachService.createCoach(coach);

        // then
        assertNotNull(result);
        assertEquals(savedCoach.getId(), result.getId());
        assertEquals(savedCoach.getName(), result.getName());
        assertEquals(savedCoach.getSurname(), result.getSurname());
        assertEquals(facility.getId(), result.getSportFacilitiesId());
    }

    @Test
    void updateCoach_ShouldUpdateCoachDetails() {
        // given
        Coach existingCoach = Coach.builder()
                .id(1)
                .name("Old Name")
                .surname("Old Surname")
                .imageUrl("old-image.jpg")
                .build();

        CoachUpdate updateData = CoachUpdate.builder()
                .id(1)
                .name("New Name")
                .surname("New Surname")
                .imageUrl("new-image.jpg")
                .sportFacilitiesId(1)
                .build();

        when(coachRepository.save(any(Coach.class))).thenReturn(existingCoach);

        // when
        CoachUpdate result = coachService.updateCoach(updateData, existingCoach);

        // then
        assertNotNull(result);
        assertEquals(updateData.getName(), result.getName());
        assertEquals(updateData.getSurname(), result.getSurname());
        assertEquals(updateData.getImageUrl(), result.getImageUrl());
        verify(coachRepository).save(any(Coach.class));
    }

    @Test
    void deleteCoach_ShouldDeleteCoach() {
        // given
        Coach coach = Coach.builder()
                .id(1)
                .name("Jan")
                .surname("Kowalski")
                .build();

        // when
        coachService.deleteCoach(coach);

        // then
        verify(coachRepository).delete(coach);
    }
} 