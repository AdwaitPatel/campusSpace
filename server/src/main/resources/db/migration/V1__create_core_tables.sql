-- ============================================
-- TENANTS
-- ============================================

CREATE TABLE tenants (
                         id BIGSERIAL PRIMARY KEY,

                         name VARCHAR(150) NOT NULL,
                         code VARCHAR(50) NOT NULL,
                         email_domain VARCHAR(150),
                         logo_url VARCHAR(255),

                         timezone VARCHAR(50) NOT NULL DEFAULT 'Asia/Kolkata',

                         status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

                         created_at TIMESTAMP NOT NULL,
                         updated_at TIMESTAMP NOT NULL,

                         CONSTRAINT uk_tenant_code
                             UNIQUE (code)
);


-- ============================================
-- DEPARTMENTS
-- ============================================

CREATE TABLE departments (
                             id BIGSERIAL PRIMARY KEY,

                             tenant_id BIGINT NOT NULL,

                             name VARCHAR(150) NOT NULL,
                             code VARCHAR(30) NOT NULL,

                             created_at TIMESTAMP NOT NULL,
                             updated_at TIMESTAMP NOT NULL,

                             CONSTRAINT fk_department_tenant
                                 FOREIGN KEY (tenant_id)
                                     REFERENCES tenants(id),

                             CONSTRAINT uk_department_code
                                 UNIQUE (tenant_id, code)
);


-- ============================================
-- USERS
-- ============================================

CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,

                       tenant_id BIGINT NOT NULL,
                       department_id BIGINT,

                       name VARCHAR(150) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,

                       role VARCHAR(30) NOT NULL,
                       status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

                       created_at TIMESTAMP NOT NULL,
                       updated_at TIMESTAMP NOT NULL,

                       CONSTRAINT fk_user_tenant
                           FOREIGN KEY (tenant_id)
                               REFERENCES tenants(id),

                       CONSTRAINT fk_user_department
                           FOREIGN KEY (department_id)
                               REFERENCES departments(id),

                       CONSTRAINT uk_user_email
                           UNIQUE (tenant_id, email)
);