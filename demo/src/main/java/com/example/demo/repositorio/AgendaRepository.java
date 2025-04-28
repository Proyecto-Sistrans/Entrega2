package com.example.demo.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.modelo.Agenda;


public interface AgendaRepository extends JpaRepository<Agenda, String> {
    
    @Query(value= "SELECT fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita, id FROM Agendas", nativeQuery = true)    
    Object[][] darAgendas();

    @Query(value= "SELECT * FROM agendas WHERE id = ?1", nativeQuery = true)
    Agenda darAgendaPorId(@Param("id") String id);

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO Agendas (fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita) VALUES (TO_DATE(:fecha,'YYYY-MM-DD HH24:MI:SS'), :duracion, :estado, :paciente_cita, :medico_cita, :servicio_cita, :orden_cita)", nativeQuery = true)
    void insertarAgenda(@Param("fecha") String fecha,@Param("duracion") String duracion,@Param("estado") String estado, @Param("paciente_cita") String paciente_cita, @Param("medico_cita") String medico_cita,@Param("servicio_cita") String servicio_cita,@Param("orden_cita") String orden_cita);

    @Modifying
    @Transactional
    @Query(value= "UPDATE Agendas SET estado = 'terminada' WHERE id = :id", nativeQuery = true)
    void cerrarAgenda(@Param("id") String id);

    @Modifying
    @Transactional
    @Query(value= "DELETE FROM agendas WHERE id = :id", nativeQuery = true)
    void eliminarAgenda(@Param("id") String id);

    @Query(value = "SELECT s.nombre AS servicio_nombre, " +
                   "       a.fecha AS fecha_disponibilidad, " +
                   "       ips.nombre AS ips_nombre, " +
                   "       m.nombre AS medico_nombre " +
                   "FROM Agendas a " +
                   "JOIN Servicios s ON a.servicio_cita = s.id " +
                   "JOIN Medicos m ON a.medico_cita = m.registro_medico " +
                   "JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico " +
                   "JOIN IPS ips ON ce.nit = ips.nit " +
                   "WHERE a.servicio_cita = :codigoServicio " +
                   "AND a.fecha BETWEEN SYSDATE AND SYSDATE + 28 " +
                   "ORDER BY a.fecha ASC",
           nativeQuery = true)
    Object[][] RFC1(@Param("codigoServicio") String codigoServicio);

    @Query(value = "SELECT * FROM ( " +
        "    SELECT s.nombre AS servicio_nombre, COUNT(*) AS total_solicitudes " +
        "    FROM Agendas a " +
        "    JOIN Servicios s ON a.servicio_cita = s.id " +
        "    WHERE a.fecha BETWEEN TO_DATE(:fechaInicio, 'YYYY-MM-DD') " +
        "                      AND TO_DATE(:fechaFin, 'YYYY-MM-DD') " +
        "    GROUP BY s.nombre " +
        "    ORDER BY total_solicitudes DESC " +
        ") WHERE ROWNUM <= 20",
    nativeQuery = true)
    Object[][] RFC2(@Param("fechaInicio") String fechaInicio,
                                        @Param("fechaFin") String fechaFin);

    @Query(value = "SELECT s.nombre AS servicio, " +
               "       CASE " +
               "         WHEN used = 0 THEN 0 " +
               "         ELSE available/used " +
               "       END AS indice_uso " +
               "FROM Servicios s " +
               "LEFT JOIN ( " +
               "    SELECT a.servicio_cita, " +
               "           SUM(CASE WHEN a.estado = 'disponible' THEN 1 ELSE 0 END) available, " +
               "           SUM(CASE WHEN a.estado <> 'disponible' THEN 1 ELSE 0 END) used " +
               "    FROM Agendas a " +
               "    WHERE a.fecha BETWEEN TO_DATE(:fechaInicio, 'YYYY-MM-DD') " +
               "                    AND TO_DATE(:fechaFin, 'YYYY-MM-DD') " +
               "    GROUP BY a.servicio_cita " +
               ") ag ON s.id = ag.servicio_cita",
       nativeQuery = true)
    Object[][] RFC3(@Param("fechaInicio") String fechaInicio,
                                      @Param("fechaFin") String fechaFin);

    @Query(value = "SELECT s.nombre AS servicio_nombre, " +
                   "       a.fecha AS fecha_disponibilidad, " +
                   "       ips.nombre AS ips_nombre, " +
                   "       m.nombre AS medico_nombre " +
                   "FROM Agendas a " +
                   "JOIN Servicios s ON a.servicio_cita = s.id " +
                   "JOIN Medicos m ON a.medico_cita = m.registro_medico " +
                   "JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico " +
                   "JOIN IPS ips ON ce.nit = ips.nit " +
                   "WHERE a.fecha BETWEEN TO_DATE(:fechaInicio, 'YYYY-MM-DD') AND  TO_DATE(:fechaFin, 'YYYY-MM-DD') " +
                   "AND a.paciente_cita = :identificacion " +
                   "ORDER BY a.fecha ASC",
           nativeQuery = true)
    Object[][] RFC4(@Param("identificacion") String identificacion, @Param("fechaInicio") String fechaInicio, @Param("fechaFin") String fechaFin);




    // Requerimiento RFC9 pre
    @Query(value = "SELECT s.nombre AS servicio, " +
               "       a.fecha AS disponibilidad, " +
               "       m.nombre AS medico, " +
               "       i.nombre AS ips " +
               "FROM Agendas a " +
               "JOIN Servicios s ON a.servicio_cita = s.id " +
               "JOIN Medicos m ON a.medico_cita = m.registro_medico " +
               "JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico " +
               "JOIN IPS i ON ce.nit = i.nit " +
               "WHERE a.estado = 'disponible' " +
               "AND (:codigoServicio IS NULL OR a.servicio_cita = :codigoServicio) " +
               "AND (:codigoMedico IS NULL OR a.medico_cita = :codigoMedico) " +
               "AND a.fecha BETWEEN TO_DATE(:fechaInicio, 'YYYY-MM-DD') AND ADD_MONTHS(TO_DATE(:fechaInicio, 'YYYY-MM-DD'), 1) " +
               "ORDER BY a.fecha",
       nativeQuery = true)
    Object[][] consultaDisponibilidad(@Param("codigoServicio") String codigoServicio, 
                    @Param("codigoMedico") String codigoMedico, 
                    @Param("fechaInicio") String fechaInicio);

    
        @Modifying
        @Transactional
        @Query(value = "UPDATE Agendas SET estado = 'AGENDADA', paciente_cita = :afiliadoId, orden_cita = :ordenId " +
                       "WHERE id = :agendaId AND estado = 'disponible'", nativeQuery = true)
        int registrarAgendamiento(@Param("agendaId") String agendaId, 
                                  @Param("afiliadoId") String afiliadoId, 
                                  @Param("ordenId") String ordenId);
         


    
    // Requerimientos de consulta RFC5 y RFC6
    @Query(value = "SELECT s.nombre AS servicio, " +
               "       a.fecha AS disponibilidad, " +
               "       m.nombre AS medico, " +
               "       i.nombre AS ips " +
               "FROM Agendas a " +
               "JOIN Servicios s ON a.servicio_cita = s.id " +
               "JOIN Medicos m ON a.medico_cita = m.registro_medico " +
               "JOIN Contratados_En ce ON m.registro_medico = ce.registro_medico " +
               "JOIN IPS i ON ce.nit = i.nit " +
               "WHERE a.estado = 'disponible' " +
               "AND (:codigoServicio IS NULL OR a.servicio_cita = :codigoServicio) " +
               "AND (:codigoMedico IS NULL OR a.medico_cita = :codigoMedico) " +
               "AND a.fecha BETWEEN TO_DATE(:fechaInicio, 'YYYY-MM-DD') AND  TO_DATE(:fechaFin, 'YYYY-MM-DD') " +
               "ORDER BY a.fecha",
       nativeQuery = true)
    Object[][] consultaAgenda(@Param("codigoServicio") String codigoServicio, 
                    @Param("codigoMedico") String codigoMedico, 
                    @Param("fechaInicio") String fechaInicio, 
                    @Param("fechaFin") String fechaFin);



}
