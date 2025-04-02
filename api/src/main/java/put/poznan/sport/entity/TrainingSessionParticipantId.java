package put.poznan.sport.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Objects;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TrainingSessionParticipantId implements Serializable {
    private Integer userId;
    private Integer trainingSessionId;
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TrainingSessionParticipantId that = (TrainingSessionParticipantId) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(trainingSessionId, that.trainingSessionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, trainingSessionId);
    }

}
