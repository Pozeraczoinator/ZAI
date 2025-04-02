package put.poznan.sport.service.openHour;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import put.poznan.sport.entity.openHour.OpenHour;
import put.poznan.sport.entity.openHour.OpeningTime;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.exception.exceptionClasses.OpenHourNotFoundException;
import put.poznan.sport.repository.OpenHourRepository;

import java.time.LocalTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class OpenHourImplTest {

    @Mock
    private OpenHourRepository openHourRepository;

    @InjectMocks
    private OpenHourImpl openHourService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getOpenHourById_ShouldReturnOpenHour_WhenExists() {
        // given
        int openHourId = 1;
        OpenHour openHour = OpenHour.builder()
                .id(openHourId)
                .monday(new OpeningTime(LocalTime.of(8, 0), LocalTime.of(20, 0)))
                .tuesday(new OpeningTime(LocalTime.of(8, 0), LocalTime.of(20, 0)))
                .build();

        when(openHourRepository.findById(openHourId)).thenReturn(Optional.of(openHour));

        // when
        OpenHour result = openHourService.getOpenHourById(openHourId);

        // then
        assertNotNull(result);
        assertEquals(openHourId, result.getId());
        assertEquals(LocalTime.of(8, 0), result.getMonday().getStart());
        assertEquals(LocalTime.of(20, 0), result.getMonday().getEnd());
    }

    @Test
    void getOpenHourById_ShouldThrowException_WhenNotFound() {
        // given
        int openHourId = 999;
        when(openHourRepository.findById(openHourId)).thenReturn(Optional.empty());

        // when & then
        assertThrows(OpenHourNotFoundException.class, 
            () -> openHourService.getOpenHourById(openHourId));
    }

    @Test
    void saveOpenHour_ShouldSaveAndReturnOpenHour() {
        // given
        SportFacility facility = SportFacility.builder()
                .id(1)
                .name("Test Facility")
                .build();

        OpenHour openHour = OpenHour.builder()
                .monday(new OpeningTime(LocalTime.of(8, 0), LocalTime.of(20, 0)))
                .tuesday(new OpeningTime(LocalTime.of(8, 0), LocalTime.of(20, 0)))
                .sportFacility(facility)
                .build();

        when(openHourRepository.save(any(OpenHour.class))).thenReturn(openHour);

        // when
        OpenHour result = openHourService.saveOpenHour(openHour);

        // then
        assertNotNull(result);
        assertEquals(facility, result.getSportFacility());
        assertEquals(LocalTime.of(8, 0), result.getMonday().getStart());
        assertEquals(LocalTime.of(20, 0), result.getMonday().getEnd());
        verify(openHourRepository).save(openHour);
    }

    @Test
    void deleteOpenHour_ShouldDeleteOpenHour() {
        // given
        OpenHour openHour = OpenHour.builder()
                .id(1)
                .monday(new OpeningTime(LocalTime.of(8, 0), LocalTime.of(20, 0)))
                .build();

        // when
        openHourService.deleteOpenHour(openHour);

        // then
        verify(openHourRepository).delete(openHour);
    }
} 