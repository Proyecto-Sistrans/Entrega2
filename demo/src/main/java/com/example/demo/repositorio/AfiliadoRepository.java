package com.example.demo.repositorio;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.modelo.Afiliado;

public interface AfiliadoRepository extends JpaRepository<Afiliado, String> {
    
    @Query(value= "SELECT * FROM afiliados", nativeQuery = true)
    Object[][] darAfiliados();

    @Query(value= "SELECT * FROM afiliados WHERE id = ?1", nativeQuery = true)
    Afiliado darAfiliadoPorId(@Param("id") String id);

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO afiliados (identificacion, tipo_documento, nombre, fecha_nacimiento, direccion, telefono, contribuyente, parentesco) " +
                   "VALUES (:identificacion, :tipoDocumento, :nombre, TO_DATE(:fechaNacimiento, 'YYYY-MM-DD'), :direccion, :telefono, NULL, NULL)", 
           nativeQuery = true)
    void insertarAfiliado(@Param("identificacion") String identificacion,
                          @Param("tipoDocumento") String tipoDocumento,
                          @Param("nombre") String nombre,
                          @Param("fechaNacimiento") String fechaNacimiento,
                          @Param("direccion") String direccion,
                          @Param("telefono") String telefono);
    
    @Modifying
    @Transactional
    @Query(value= "UPDATE afiliados SET nombre = :nombre, tipoDocumento = :tipoDocumento, fechaNacimiento = :fechaNacimiento, direccion = :direccion, telefono = :telefono WHERE id = :id", nativeQuery = true)
    void actualizarAfiliado(@Param("id") String id, @Param("nombre") String nombre, @Param("tipoDocumento") String tipoDocumento, @Param("fechaNacimiento") String fechaNacimiento, @Param("direccion") String direccion, @Param("telefono") String telefono);


    @Modifying
    @Transactional
    @Query(value= "DELETE FROM afiliados WHERE id = :id", nativeQuery = true)
    void eliminarAfiliado(@Param("id") String id);
}
