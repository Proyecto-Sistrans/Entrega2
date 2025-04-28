package com.example.demo.repositorio;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.modelo.Orden;

public interface OrdenRepository extends JpaRepository<Orden, String> {
    
    @Query(value= "SELECT * FROM Ordenes", nativeQuery = true)
    Object[][] darOrdens();

    @Query(value= "SELECT * FROM orden WHERE id = ?1", nativeQuery = true)
    Orden darOrdenPorId(@Param("id") String id);

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO Ordenes (numero, estado, fecha, descripcion, prescritaPor, prescritaPara) VALUES (:numero, :estado, TO_DATE(:fecha,'YYYY-MM-DD HH24:MI:SS'), :descripcion, :prescritaPor, :prescritaPara)", nativeQuery = true)
    void insertarOrden(@Param("numero") String numero, @Param("estado") String estado, @Param("fecha") String fecha, @Param("descripcion") String descripcion, @Param("prescritaPor") String prescritaPor, @Param("prescritaPara") String prescritaPara);

    @Modifying
    @Transactional
    @Query(value= "UPDATE orden SET id = :id, fecha = :fecha, idServicio = :idServicio, idAfiliado = :idAfiliado, idMedico = :idMedico, idOrden = :idOrden, idRecepcionista = :idRecepcionista WHERE id = :id", nativeQuery = true)
    void actualizarOrden(@Param("id") String id, @Param("fecha") String fecha, @Param("idServicio") String idServicio, @Param("idAfiliado") String idAfiliado, @Param("idMedico") String idMedico, @Param("idOrden") String idOrden, @Param("idRecepcionista") String idRecepcionista);
    
}
