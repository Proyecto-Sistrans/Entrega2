-- ====================================================
-- POBLACIÓN EXTENDIDA DE DATOS PARA EPSANDES (SIN TRIGGER)
-- ====================================================

-- 0. Limpiar datos previos (opcional)
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Agendas CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Ordenes CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Servicio_A_Prestar CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Ips_Prestacion CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Contratados_En CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Servicios CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Medicos CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IPS CASCADE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Afiliados CASCADE';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- 0.1 Eliminar la restricción única en Agendas que impide citas con mismo médico y fecha
ALTER TABLE Agendas DROP CONSTRAINT UQ_Agendas_Medico_Fecha;
COMMIT;

--------------------------------------------------
-- 1. Servicios (8 registros)
--------------------------------------------------
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (1, 'General', 'Consulta con Médico General');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (2, 'Especialista', 'Consulta con Médico Especialista');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (3, 'Control', 'Consulta de Control');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (4, 'Urgencias', 'Consulta de Urgencias');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (5, 'Examen', 'Examen Diagnóstico');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (6, 'Terapia', 'Terapia Física');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (7, 'ProcedimientoEspecializado', 'Procedimiento Quirúrgico');
INSERT INTO Servicios (id, tipo_servicio, nombre)
VALUES (8, 'Hospitalizacion', 'Hospitalización');

--------------------------------------------------
-- 2. Afiliados (15 registros)
--------------------------------------------------
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A001','CC','Laura Guiza',TO_DATE('1985-06-12','YYYY-MM-DD'),'Cra 7 #85-20, Bogotá','3101234567',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A002','CC','Angie Gutierrez',TO_DATE('1990-04-25','YYYY-MM-DD'),'Cl. 93 #12-50, Bogotá','3102345678','A001','Hermana');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A003','CC','Alberto Pertuz',TO_DATE('1982-09-15','YYYY-MM-DD'),'Av. 68 #15-40, Bogotá','3103456789',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A004','CC','Valentina Melo',TO_DATE('1995-12-10','YYYY-MM-DD'),'Cll. 80 #45-12, Bogotá','3104567890','A003','Prima');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A005','CC','Carlos Mendoza',TO_DATE('1978-03-22','YYYY-MM-DD'),'Cra 15 #88-30, Bogotá','3105678901',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A006','CC','Elena Rodriguez',TO_DATE('1988-11-05','YYYY-MM-DD'),'Cl. 45 #23-15, Bogotá','3106789012','A005','Esposa');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A007','CC','Diego Martinez',TO_DATE('1992-07-18','YYYY-MM-DD'),'Av. 19 #75-35, Bogotá','3107890123',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A008','CC','Sofía Castro',TO_DATE('1996-01-30','YYYY-MM-DD'),'Cra 10 #65-25, Bogotá','3108901234','A007','Hermana');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A009','CC','Miguel Torres',TO_DATE('1980-05-12','YYYY-MM-DD'),'Cl. 50 #30-20, Bogotá','3109012345',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A010','CC','Camila García',TO_DATE('1987-08-08','YYYY-MM-DD'),'Av. El Dorado #100-10, Bogotá','3100123456','A009','Hija');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A011','CC','Ricardo López',TO_DATE('1975-02-10','YYYY-MM-DD'),'Cl. 80 #25-30, Bogotá','3111123456',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A012','CC','Mariana Rivas',TO_DATE('1983-07-29','YYYY-MM-DD'),'Cra 14 #55-12, Bogotá','3112234567','A011','Esposa');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A013','CC','Esteban Rojas',TO_DATE('1991-11-15','YYYY-MM-DD'),'Av. 68 #10-20, Bogotá','3113345678',NULL,NULL);
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A014','CC','Natalia Soto',TO_DATE('1994-03-05','YYYY-MM-DD'),'Cll. 70 #34-15, Bogotá','3114456789','A013','Hermana');
INSERT INTO Afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco)
VALUES ('A015','CC','Andrés Gil',TO_DATE('1989-09-09','YYYY-MM-DD'),'Cra 5 #22-50, Bogotá','3115567890',NULL,NULL);

--------------------------------------------------
-- 3. IPS (6 registros)
--------------------------------------------------
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS001','IPS Central Bogotá','Av. 68 #15-40, Bogotá','3111111111');
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS002','IPS Norte Bogotá','Cl. 93 #12-50, Bogotá','3112222222');
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS003','IPS Sur Bogotá','Cra 7 #85-20, Bogotá','3113333333');
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS004','IPS Occidente Bogotá','Cll. 50 #30-20, Bogotá','3114444444');
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS005','IPS Oriente Bogotá','Av. 19 #75-35, Bogotá','3115555555');
INSERT INTO IPS (nit, nombre, direccion, telefono) VALUES ('IPS006','IPS Central Sur','Cl. 70 #40-22, Bogotá','3116666666');

--------------------------------------------------
-- 4. Médicos (15 registros)
--------------------------------------------------
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M001','11111','CC','Sara Cárdenas','General');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M002','22222','CC','Juan Pablo Reyes','Especialista');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M003','33333','CC','Andrés Ramírez','General');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M004','44444','CC','Carolina Rojas','Pediatra');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M005','55555','CC','Ricardo Morales','Cardiología');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M006','66666','CC','Luis Rivera','General');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M007','77777','CC','Isabel Morales','Dermatología');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M008','88888','CC','Andrés Lozano','Especialista');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M009','99999','CC','Paula González','Pediatra');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M010','101010','CC','Fernando Suárez','Cardiología');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M011','111111','CC','Marta Escobar','General');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M012','121212','CC','Julio Cabrera','Ginecología');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M013','131313','CC','Claudia Jiménez','Neurología');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M014','141414','CC','Oscar Mejía','Ortopedia');
INSERT INTO Medicos (registro_medico, identificacion, tipo_documento, nombre, especialidad)
VALUES ('M015','151515','CC','Verónica Herrera','Oftalmología');

--------------------------------------------------
-- 5. Contratados_En (relaciones)
--------------------------------------------------
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M001','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M001','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M002','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M002','IPS003');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M003','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M003','IPS004');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M004','IPS003');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M004','IPS005');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M005','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M005','IPS005');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M006','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M006','IPS004');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M007','IPS003');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M007','IPS004');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M008','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M008','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M009','IPS005');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M009','IPS004');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M010','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M010','IPS003');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M011','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M011','IPS006');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M012','IPS003');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M012','IPS006');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M013','IPS004');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M013','IPS005');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M014','IPS001');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M014','IPS006');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M015','IPS002');
INSERT INTO Contratados_En (registro_medico, nit) VALUES ('M015','IPS003');

--------------------------------------------------
-- 6. Ips_Prestacion (relaciones)
--------------------------------------------------
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS001',1);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS001',2);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS001',3);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS001',4);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS002',1);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS002',3);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS002',5);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS002',6);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS003',2);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS003',4);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS003',7);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS003',8);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS004',1);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS004',5);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS004',7);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS005',2);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS005',6);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS005',8);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS006',3);
INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES ('IPS006',8);

--------------------------------------------------
-- 7. Servicio_A_Prestar (relaciones)
--------------------------------------------------
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (1,'M001');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (1,'M003');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (1,'M004');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (1,'M008');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (2,'M002');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (2,'M004');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (2,'M015');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (3,'M001');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (3,'M005');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (3,'M008');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (3,'M011');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (4,'M001');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (4,'M005');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (4,'M009');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (4,'M012');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (5,'M002');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (5,'M006');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (5,'M009');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (5,'M013');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (6,'M002');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (6,'M006');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (6,'M010');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (6,'M014');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (7,'M003');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (7,'M007');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (7,'M010');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (7,'M015');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (8,'M003');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (8,'M007');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (8,'M009');
INSERT INTO Servicio_A_Prestar (servicio_id, registro_medico) VALUES (8,'M011');

--------------------------------------------------
-- 8. Ordenes (10 registros, con número explícito)
--------------------------------------------------
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (1,'vigente',TO_DATE('2025-03-10 08:00:00','YYYY-MM-DD HH24:MI:SS'),
        'Receta, exámenes y seguimiento','M001','A001');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (2,'completada',TO_DATE('2025-03-05 09:30:00','YYYY-MM-DD HH24:MI:SS'),
        'Consulta de seguimiento','M002','A003');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (3,'cancelada',TO_DATE('2025-03-12 10:15:00','YYYY-MM-DD HH24:MI:SS'),
        'Orden cancelada por reprogramación','M003','A002');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (4,'vigente',TO_DATE('2025-03-08 11:00:00','YYYY-MM-DD HH24:MI:SS'),
        'Receta y órdenes para exámenes','M005','A005');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (5,'completada',TO_DATE('2025-03-06 14:00:00','YYYY-MM-DD HH24:MI:SS'),
        'Consulta con especialista','M008','A007');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (6,'vigente',TO_DATE('2025-03-09 08:45:00','YYYY-MM-DD HH24:MI:SS'),
        'Consulta general y seguimiento','M004','A009');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (7,'completada',TO_DATE('2025-03-02 13:30:00','YYYY-MM-DD HH24:MI:SS'),
        'Orden para exámenes diagnósticos','M007','A010');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (8,'vigente',TO_DATE('2025-03-07 10:00:00','YYYY-MM-DD HH24:MI:SS'),
        'Consulta y órdenes de laboratorio','M011','A012');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (9,'completada',TO_DATE('2025-03-03 16:00:00','YYYY-MM-DD HH24:MI:SS'),
        'Consulta de control post-operatorio','M013','A014');
INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara)
VALUES (10,'vigente',TO_DATE('2025-03-04 09:15:00','YYYY-MM-DD HH24:MI:SS'),
        'Revisión general y órdenes varias','M015','A015');

--------------------------------------------------
-- 9. Agendas
--------------------------------------------------
-- (a) 10 citas en estados 'terminada' (5) y 'ausencia' (5) – fechas pasadas
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 08:00:00','YYYY-MM-DD HH24:MI:SS'),30,'terminada','A001','M001',1,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 08:40:00','YYYY-MM-DD HH24:MI:SS'),30,'terminada','A002','M002',2,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 09:20:00','YYYY-MM-DD HH24:MI:SS'),30,'terminada','A003','M003',3,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 10:00:00','YYYY-MM-DD HH24:MI:SS'),30,'terminada','A004','M004',4,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 10:40:00','YYYY-MM-DD HH24:MI:SS'),30,'terminada','A005','M005',5,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 11:30:00','YYYY-MM-DD HH24:MI:SS'),30,'ausencia','A006','M006',6,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 12:10:00','YYYY-MM-DD HH24:MI:SS'),30,'ausencia','A007','M007',7,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 12:50:00','YYYY-MM-DD HH24:MI:SS'),30,'ausencia','A008','M008',8,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 13:30:00','YYYY-MM-DD HH24:MI:SS'),30,'ausencia','A009','M009',1,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-10 14:10:00','YYYY-MM-DD HH24:MI:SS'),30,'ausencia','A010','M010',2,NULL);

-- (b) 4 citas en estado 'cancelada' – fechas pasadas
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-11 08:00:00','YYYY-MM-DD HH24:MI:SS'),30,'cancelada','A011','M011',3,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-11 08:40:00','YYYY-MM-DD HH24:MI:SS'),30,'cancelada','A012','M012',4,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-11 09:20:00','YYYY-MM-DD HH24:MI:SS'),30,'cancelada','A013','M013',5,NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
VALUES (TO_DATE('2025-02-11 10:00:00','YYYY-MM-DD HH24:MI:SS'),30,'cancelada','A014','M014',6,NULL);


-- ====================================================
-- Inserción de Agendas sin trigger (sin validación de traslape)
-- Se insertan:
-- (c) 2 citas en estado "agendada" por servicio (total 16)
-- (d) 5 citas en estado "disponible" por servicio (total 40)
-- ====================================================

-- Servicio 1 (id = 1) - Posibles médicos: M001, M003, M004, M008
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A001', 'M001', 1, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-02 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A002', 'M003', 1, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-01 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 1, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-02 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M003', 1, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-03 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M004', 1, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-04 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M008', 1, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-05 08:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 1, NULL);

-- Servicio 2 (id = 2) - Posibles médicos: M002, M004, M015
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-03 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A003', 'M002', 2, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-04 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A004', 'M004', 2, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-06 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 2, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-07 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M004', 2, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-08 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M015', 2, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-09 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 2, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-10 09:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M004', 2, NULL);

-- Servicio 3 (id = 3) - Posibles médicos: M001, M005, M008, M011
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-05 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A005', 'M001', 3, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-06 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A006', 'M005', 3, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-11 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 3, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-12 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M005', 3, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-13 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M008', 3, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M011', 3, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-15 10:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 3, NULL);

-- Servicio 4 (id = 4) - Posibles médicos: M001, M005, M009, M012
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-07 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A007', 'M001', 4, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-08 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A008', 'M005', 4, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-16 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 4, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-17 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M005', 4, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-18 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M009', 4, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-19 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M012', 4, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-20 11:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M001', 4, NULL);

-- Servicio 5 (id = 5) - Posibles médicos: M002, M006, M009, M013
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-09 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A009', 'M002', 5, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-10 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A010', 'M006', 5, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-21 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 5, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-22 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M006', 5, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-23 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M009', 5, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-24 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M013', 5, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-25 12:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 5, NULL);

-- Servicio 6 (id = 6) - Posibles médicos: M002, M006, M010, M014
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-11 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A011', 'M002', 6, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-12 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A012', 'M006', 6, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-26 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 6, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-27 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M006', 6, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-04-28 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M010', 6, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-01 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M014', 6, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-02 13:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M002', 6, NULL);

-- Servicio 7 (id = 7) - Posibles médicos: M003, M007, M010, M015
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-13 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A013', 'M003', 7, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-14 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A014', 'M007', 7, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-03 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M003', 7, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-04 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M007', 7, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-05 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M010', 7, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-06 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M015', 7, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-07 14:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M003', 7, NULL);

-- Servicio 8 (id = 8) - Posibles médicos: M003, M007, M009, M011
-- Agendada (2):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-15 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A015', 'M003', 8, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-01-16 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'agendada', 'A001', 'M007', 8, NULL);
-- Disponible (5):
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-08 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M003', 8, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-09 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M007', 8, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-10 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M009', 8, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-11 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M011', 8, NULL);
INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita)
  VALUES (TO_DATE('2025-05-12 15:00:00','YYYY-MM-DD HH24:MI:SS'), 30, 'disponible', NULL, 'M003', 8, NULL);

COMMIT;


