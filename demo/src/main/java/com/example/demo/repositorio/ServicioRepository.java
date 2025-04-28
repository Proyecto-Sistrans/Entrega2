package com.example.demo.repositorio;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.modelo.Servicio;

public interface ServicioRepository extends JpaRepository<Servicio, String> {
    
    @Query(value= "SELECT * FROM servicios", nativeQuery = true)
    Object[][] darServicios();

    @Query(value= "SELECT * FROM servicios WHERE id = ?1", nativeQuery = true)
    Servicio darServicioPorId(@Param("id") String id);

    @Query(value= "SELECT * FROM Ips_Prestacion", nativeQuery = true)
    Object[][] darRelaciones();

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO Ips_Prestacion (nit, servicio_id) VALUES (:nit, :servicio_id)", nativeQuery = true)
    void asignar(@Param("nit") String nit, @Param("servicio_id") String servicio_id);

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO servicios (id, tipo_servicio, nombre) VALUES (:id, :tipo_servicio, :nombre)", nativeQuery = true)
    void insertarServicio(@Param("id") String id, @Param("tipo_servicio") String tipo_servicio, @Param("nombre") String nombre);

    @Modifying
    @Transactional
    @Query(value= "UPDATE servicios SET nombre = :nombre, descripcion = :descripcion, tipo = :tipo, idIps = :idIps WHERE id = :id", nativeQuery = true)
    void actualizarServicio(@Param("id") String id, @Param("nombre") String nombre, @Param("descripcion") String descripcion, @Param("tipo") String tipo, @Param("idIps") String idIps);
    
}
