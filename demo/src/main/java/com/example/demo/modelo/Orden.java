package com.example.demo.modelo;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="ordenes")
public class Orden {

      
    @Id 
    @GeneratedValue(strategy = GenerationType.AUTO)

    private String numero; //Número único de la orden
    private Date fecha; // Fecha de la orden
    private EstadoOrden estado;
    private String descripcion; 

    enum EstadoOrden {
        VIGENTE, CANCELADA, COMPLETADA
    }
    
    public Orden(Date fecha, EstadoOrden estado, String descripcion) {
        this.fecha = fecha;
        this.estado = estado;
        this.descripcion = descripcion;
    }

    public Orden () 
    {;}

    //Getters
    public String getNumero() {
        return numero;
    }
    public Date getFecha() {
        return fecha;
    }
    public EstadoOrden getEstado() {
        return estado;
    }
    public String getDescripcion() {
        return descripcion;
    }

    //Setters
    public void setNumero(String numero) {
        this.numero = numero;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public void setEstado(EstadoOrden estado) {
        this.estado = estado;
    }   
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    
}
