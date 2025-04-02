package put.poznan.sport.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import put.poznan.sport.entity.sportFacility.SportFacility;

import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TrainingSession {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer coachId;
    private Integer sportFacilityId;
    private String name;
    private String startHour;
    private Integer duration;
    private Integer isWeekly;
    private Date trainingDate;
    private Integer capacity;
    private Integer freeBooked;

    @ManyToOne
    @JoinColumn(name = "coachId", insertable = false, updatable = false)
    @JsonIgnore
    private Coach coach;

    @ManyToOne
    @JoinColumn(name = "sportFacilityId", insertable = false, updatable = false)
    @JsonIgnore
    private SportFacility sportFacility;

    @OneToMany(mappedBy = "trainingSession", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<TrainingSessionParticipant> trainingSessionParticipants;
}
