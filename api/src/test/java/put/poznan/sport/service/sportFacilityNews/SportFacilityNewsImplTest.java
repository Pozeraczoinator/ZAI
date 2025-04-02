package put.poznan.sport.service.sportFacilityNews;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import put.poznan.sport.dto.SportFacilityNews.SportFacilityNewsDTO;
import put.poznan.sport.entity.sportFacility.SportFacility;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;
import put.poznan.sport.exception.exceptionClasses.SportFacilityNewsNotFoundException;
import put.poznan.sport.repository.SportFacilityNewsRepository;
import put.poznan.sport.repository.SportFacilityRepository;
import put.poznan.sport.service.user.UserService;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class SportFacilityNewsImplTest {

    @Mock
    private SportFacilityNewsRepository newsRepository;

    @Mock
    private SportFacilityRepository sportFacilityRepository;

    @Mock
    private UserService userService;

    @InjectMocks
    private SportFacilityNewsImpl newsService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getAllFacilityNews_ShouldReturnListOfNews() {
        // given
        SportFacilityNews news1 = SportFacilityNews.builder()
                .id(1)
                .title("News 1")
                .description("Description 1")
                .build();
        SportFacilityNews news2 = SportFacilityNews.builder()
                .id(2)
                .title("News 2")
                .description("Description 2")
                .build();

        when(newsRepository.findAll()).thenReturn(Arrays.asList(news1, news2));

        // when
        List<SportFacilityNews> result = newsService.getAllFacilityNews();

        // then
        assertNotNull(result);
        assertEquals(2, result.size());
        verify(newsRepository).findAll();
    }

    @Test
    void getFacilityNewsBySportFacilityId_ShouldReturnNews() {
        // given
        int facilityId = 1;
        SportFacilityNews news1 = SportFacilityNews.builder()
                .id(1)
                .sportFacilityId(facilityId)
                .title("News 1")
                .build();
        SportFacilityNews news2 = SportFacilityNews.builder()
                .id(2)
                .sportFacilityId(facilityId)
                .title("News 2")
                .build();

        when(newsRepository.findBySportFacilityId(facilityId))
                .thenReturn(Optional.of(Arrays.asList(news1, news2)));

        // when
        List<SportFacilityNews> result = newsService.getFacilityNewsBySportFacilityId(facilityId);

        // then
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("News 1", result.get(0).getTitle());
        assertEquals("News 2", result.get(1).getTitle());
    }

    @Test
    void createFacilityNews_ShouldCreateNewNews() {
        // given
        SportFacilityNewsDTO dto = new SportFacilityNewsDTO();
        dto.setSportFacilityId(1);
        dto.setTitle("New Title");
        dto.setDescription("New Description");
        dto.setImageUrl("image.jpg");

        SportFacility facility = SportFacility.builder()
                .id(1)
                .name("Test Facility")
                .build();

        SportFacilityNews savedNews = SportFacilityNews.builder()
                .id(1)
                .sportFacilityId(dto.getSportFacilityId())
                .title(dto.getTitle())
                .description(dto.getDescription())
                .imageUrl(dto.getImageUrl())
                .sportFacility(facility)
                .build();

        when(sportFacilityRepository.findById(dto.getSportFacilityId())).thenReturn(Optional.of(facility));
        when(newsRepository.save(any(SportFacilityNews.class))).thenReturn(savedNews);

        // when
        SportFacilityNews result = newsService.createFacilityNews(dto);

        // then
        assertNotNull(result);
        assertEquals(dto.getTitle(), result.getTitle());
        assertEquals(dto.getDescription(), result.getDescription());
        assertEquals(dto.getImageUrl(), result.getImageUrl());
        assertEquals(facility, result.getSportFacility());
    }

    @Test
    void updateFacilityNews_ShouldUpdateExistingNews() {
        // given
        SportFacilityNewsDTO dto = new SportFacilityNewsDTO();
        dto.setSportFacilityNewsID(1);
        dto.setSportFacilityId(1);
        dto.setTitle("Updated Title");
        dto.setDescription("Updated Description");
        dto.setImageUrl("updated-image.jpg");

        SportFacility facility = SportFacility.builder()
                .id(1)
                .name("Test Facility")
                .build();

        SportFacilityNews existingNews = SportFacilityNews.builder()
                .id(1)
                .sportFacilityId(1)
                .title("Old Title")
                .description("Old Description")
                .imageUrl("old-image.jpg")
                .sportFacility(facility)
                .build();

        when(newsRepository.findById(dto.getSportFacilityId())).thenReturn(Optional.of(existingNews));
        when(sportFacilityRepository.findById(dto.getSportFacilityId())).thenReturn(Optional.of(facility));
        when(newsRepository.save(any(SportFacilityNews.class))).thenReturn(existingNews);

        // when
        SportFacilityNews result = newsService.updateFacilityNews(dto);

        // then
        assertNotNull(result);
        assertEquals(dto.getTitle(), result.getTitle());
        assertEquals(dto.getDescription(), result.getDescription());
        assertEquals(dto.getImageUrl(), result.getImageUrl());
    }

    @Test
    void deleteFacilityNews_ShouldDeleteNews() {
        // given
        int newsId = 1;
        SportFacility facility = SportFacility.builder().id(1).build();
        SportFacilityNews news = SportFacilityNews.builder()
                .id(newsId)
                .sportFacility(facility)
                .build();

        when(newsRepository.findById(newsId)).thenReturn(Optional.of(news));

        // when
        newsService.deleteFacilityNews(newsId);

        // then
        verify(newsRepository).deleteById(newsId);
    }

    @Test
    void deleteFacilityNews_ShouldThrowException_WhenNewsNotFound() {
        // given
        int newsId = 999;
        when(newsRepository.findById(newsId)).thenReturn(Optional.empty());

        // when & then
        assertThrows(SportFacilityNewsNotFoundException.class, 
            () -> newsService.deleteFacilityNews(newsId));
    }
} 