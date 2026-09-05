CREATE TABLE buildings (
                           id BIGSERIAL PRIMARY KEY,

                           tenant_id BIGINT NOT NULL,

                           name VARCHAR(255) NOT NULL,
                           code VARCHAR(100) NOT NULL,

                           created_at TIMESTAMP NOT NULL,
                           updated_at TIMESTAMP NOT NULL,

                           CONSTRAINT fk_building_tenant
                               FOREIGN KEY (tenant_id)
                                   REFERENCES tenants(id),

                           CONSTRAINT uk_building_tenant_code
                               UNIQUE (tenant_id, code)
);


CREATE TABLE rooms (
                       id BIGSERIAL PRIMARY KEY,

                       tenant_id BIGINT NOT NULL,
                       building_id BIGINT NOT NULL,

                       room_number VARCHAR(100) NOT NULL,
                       display_name VARCHAR(255),

                       created_at TIMESTAMP NOT NULL,
                       updated_at TIMESTAMP NOT NULL,

                       CONSTRAINT fk_room_tenant
                           FOREIGN KEY (tenant_id)
                               REFERENCES tenants(id),

                       CONSTRAINT fk_room_building
                           FOREIGN KEY (building_id)
                               REFERENCES buildings(id),

                       CONSTRAINT uk_room_tenant_building_number
                           UNIQUE (tenant_id, building_id, room_number)
);


CREATE TABLE timetable_slots (
                                 id BIGSERIAL PRIMARY KEY,

                                 tenant_id BIGINT NOT NULL,
                                 room_id BIGINT NOT NULL,

                                 day_of_week SMALLINT NOT NULL,

                                 start_time TIME NOT NULL,
                                 end_time TIME NOT NULL,

                                 effective_from DATE NOT NULL,
                                 effective_until DATE,

                                 created_at TIMESTAMP NOT NULL,
                                 updated_at TIMESTAMP NOT NULL,

                                 CONSTRAINT fk_timetable_tenant
                                     FOREIGN KEY (tenant_id)
                                         REFERENCES tenants(id),

                                 CONSTRAINT fk_timetable_room
                                     FOREIGN KEY (room_id)
                                         REFERENCES rooms(id),

                                 CONSTRAINT chk_timetable_day
                                     CHECK (day_of_week BETWEEN 1 AND 7),

                                 CONSTRAINT chk_timetable_time
                                     CHECK (start_time < end_time),

                                 CONSTRAINT chk_timetable_effective_date
                                     CHECK (
                                         effective_until IS NULL
                                             OR effective_until >= effective_from
                                         )
);


CREATE INDEX idx_timetable_tenant
    ON timetable_slots(tenant_id);

CREATE INDEX idx_timetable_room
    ON timetable_slots(room_id);

CREATE INDEX idx_timetable_room_day
    ON timetable_slots(room_id, day_of_week);