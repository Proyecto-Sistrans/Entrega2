package com.example.demo.repositorio;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.modelo.Parentesco;
import com.example.demo.modelo.ParentescoPK;


public interface ParentescoRepository extends JpaRepository<Parentesco, ParentescoPK> {
    
    @Query(value= "SELECT * FROM parentesco", nativeQuery = true)
    Collection<Parentesco> darParentescos();

    @Query(value= "SELECT * FROM parentesco WHERE id = ?1", nativeQuery = true)
    Parentesco darParentescoPorId(@Param("id") String id);

    @Modifying
    @Transactional
    @Query(value= "INSERT INTO parentesco (nombre) VALUES (:nombre)", nativeQuery = true)
    void insertarParentesco(@Param("nombre") String nombre);

    @Modifying
    @Transactional
    @Query(value= "UPDATE parentesco SET nombre = :nombre WHERE id = :id", nativeQuery = true)
    void actualizarParentesco(@Param("id") String id, @Param("nombre") String nombre);
    
}
