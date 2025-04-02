package put.poznan.sport.entity.sportFacility;

import lombok.Getter;

@Getter
public enum SportFacilityType {
    SILOWNIA("Siłownia"),
    BASEN("Basen"),
    FITNESS("Fitness"),
    BOISKO("Boisko"),
    HALA("Hala sportowa"),
    STADION("Stadion"),
    TENIS("Kort tenisowy"),
    SAUNA("Sauna"),
    SQUASH("Kort do squasha");

    private final String name;

    SportFacilityType(String name) {
        this.name = name;
    }

}
