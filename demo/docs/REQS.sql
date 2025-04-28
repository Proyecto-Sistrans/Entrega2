-- RFC1 - CONSULTAR LA AGENDA DE DISPONIBILIDAD QUE TIENE UN SERVICIO DE SALUD INGRESADO POR EL USUARIO
SELECT 
    s.nombre AS servicio,
    a.fecha,
    i.nombre AS ips,
    m.nombre AS medico
FROM Agendas a
JOIN Servicios s ON a.servicio_cita = s.id
JOIN Medicos m ON a.medico_cita = m.registro_medico
JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico
JOIN IPS i ON ce.nit = i.nit
WHERE a.estado = 'disponible'
    AND s.id = :codigo_servicio
    AND a.fecha BETWEEN SYSDATE AND (SYSDATE + INTERVAL '28' DAY)
ORDER BY a.fecha;



-- RFC2 - MOSTRAR LOS 20 SERVICIOS MÁS SOLICITADOS
SELECT s.nombre AS servicio, COUNT(a.id) AS cantidad_solicitudes
FROM Agendas a
JOIN Servicios s ON a.servicio_cita = s.id
WHERE a.estado IN ('agendada', 'terminada')
AND a.fecha BETWEEN :fecha_inicio AND :fecha_fin
GROUP BY s.nombre
ORDER BY cantidad_solicitudes DESC
FETCH FIRST 20 ROWS ONLY;

-- RFC3 - MOSTRAR EL ÍNDICE DE USO DE CADA UNO DE LOS SERVICIOS PROVISTOS
SELECT s.nombre AS servicio,
       COUNT(CASE WHEN a.estado IN ('agendada', 'terminada') THEN 1 END) / 
       NULLIF(COUNT(a.id), 0) AS indice_uso
FROM Agendas a
JOIN Servicios s ON a.servicio_cita = s.id
WHERE a.fecha BETWEEN :fecha_inicio AND :fecha_fin
GROUP BY s.nombre
ORDER BY indice_uso DESC;

-- RFC4 - MOSTRAR LA UTILIZACIÓN DE SERVICIOS DE EPSANDES POR UN AFILIADO DADO, EN UN PERIODO DADO
SELECT s.nombre AS servicio, a.fecha, m.nombre AS medico, i.nombre AS IPS
FROM Agendas a
JOIN Servicios s ON a.servicio_cita = s.id
JOIN Medicos m ON a.medico_cita = m.registro_medico
JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico
JOIN IPS i ON ce.nit = i.nit
WHERE a.paciente_cita = :id_afiliado
AND a.estado IN ('agendada', 'terminada')
AND a.fecha BETWEEN :fecha_inicio AND :fecha_fin
ORDER BY a.fecha;



