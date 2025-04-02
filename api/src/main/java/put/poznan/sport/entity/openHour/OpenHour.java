package put.poznan.sport.entity.openHour;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import put.poznan.sport.entity.sportFacility.SportFacility;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OpenHour {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "monday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "monday_end"))
    })
    private OpeningTime monday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "tuesday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "tuesday_end"))
    })
    private OpeningTime tuesday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "wednesday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "wednesday_end"))
    })
    private OpeningTime wednesday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "thursday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "thursday_end"))
    })
    private OpeningTime thursday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "friday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "friday_end"))
    })
    private OpeningTime friday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "saturday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "saturday_end"))
    })
    private OpeningTime saturday;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "start", column = @Column(name = "sunday_start")),
            @AttributeOverride(name = "end", column = @Column(name = "sunday_end"))
    })
    private OpeningTime sunday;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "sportFacilityID")
    @JsonIgnore
    private SportFacility sportFacility;
}

