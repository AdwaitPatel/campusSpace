package com.campusspace.timetable.repository;

import com.campusspace.timetable.entity.TimetableSlot;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TimetableSlotRepository extends JpaRepository<TimetableSlot, Long> {

    List<TimetableSlot> findByTenantIdAndRoomIdAndDayOfWeek(
            Long tenantId,
            Long roomId,
            Short dayOfWeek
    );
}