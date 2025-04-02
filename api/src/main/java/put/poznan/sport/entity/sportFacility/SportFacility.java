package put.poznan.sport.entity.sportFacility;


import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import put.poznan.sport.entity.Coach;
import put.poznan.sport.entity.SportEquipment;
import put.poznan.sport.entity.TrainingSession;
import put.poznan.sport.entity.User;
import put.poznan.sport.entity.openHour.OpenHour;
import put.poznan.sport.entity.sportFacility.SportFacilityNews;

import java.util.List;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SportFacility {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private boolean membershipRequired;

    @Column(nullable = false)
    private String imageUrl;

    @ManyToMany(mappedBy = "managedFacilities")
    @JsonIgnore
    private List<User> managers;

    @OneToOne(mappedBy = "sportFacility", orphanRemoval = true)
    @JsonIgnore
    private OpenHour openHour;

    @OneToMany(mappedBy = "sportFacility", orphanRemoval = true, cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Coach> coaches;

    @OneToMany(mappedBy = "sportFacility", orphanRemoval = true, cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<TrainingSession> trainingSessions;

    @OneToMany(mappedBy = "sportFacility", orphanRemoval = true, cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<SportFacilityNews> sportFacilityNews;

    @OneToMany(mappedBy = "ownerSportFacility", orphanRemoval = true)
    @JsonIgnore
    private List<SportEquipment> sportEquipments;

}
