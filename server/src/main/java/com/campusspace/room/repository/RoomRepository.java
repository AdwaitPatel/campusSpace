package com.campusspace.room.repository;

import com.campusspace.room.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room, Long> {

    Optional<Room> findByTenantIdAndRoomNumber(
            Long tenantId,
            String roomNumber
    );

}