package com.campusspace.user.repository;

import com.campusspace.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByTenantIdAndEmail(Long tenantId, String email);

    boolean existsByTenantIdAndEmail(Long tenantId, String email);

    List<User> findAllByTenantId(Long tenantId);
}

