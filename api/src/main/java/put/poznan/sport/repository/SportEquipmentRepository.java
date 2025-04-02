package put.poznan.sport.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import put.poznan.sport.entity.SportEquipment;

import java.util.Optional;

public interface SportEquipmentRepository extends JpaRepository<SportEquipment, Integer> {
   // Optional<SportEquipment> findByIdAndOwnerID(Integer id, Integer ownerID);
}