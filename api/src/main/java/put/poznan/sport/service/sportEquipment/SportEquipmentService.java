package put.poznan.sport.service.sportEquipment;

import put.poznan.sport.dto.SportEquipment.CreateSportEquipment;
import put.poznan.sport.dto.SportEquipment.UpdateSportEquipment;
import put.poznan.sport.entity.SportEquipment;

import java.util.List;

public interface SportEquipmentService {


    public List<SportEquipment> getAllEquipments();

    public SportEquipment getEquipmentsById(int id);

    public List<SportEquipment> getEquipmentsBySportFacility(int id);

    SportEquipment createEquipment(CreateSportEquipment equipment);

    public SportEquipment updateEquipment(UpdateSportEquipment sportEquipment);

    public void deleteEquipment(int id);
}
