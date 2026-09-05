package com.campusspace.building.repository;

import com.campusspace.building.entity.Building;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BuildingRepository extends JpaRepository<Building, Long> {

    Optional<Building> findByTenantIdAndCode(Long tenantId, String code);

}