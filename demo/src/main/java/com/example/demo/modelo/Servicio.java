package com.example.demo.modelo;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="servicios")
public class Servicio {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String nombre;
    private TipoServicio tipo; 

    enum TipoServicio {
        GENERAL, ESPECIALISTA, CONTROL, URGENCIAS, EXAMEN, TERAPIA, HOSPITALIZACION, PROCEDIMIENTO_ESPECIALIZADO
    }
 
    public Servicio(String nombre, TipoServicio tipo) {
        this.nombre = nombre;
        this.tipo = tipo;
    }

    public Servicio () 
    {;}

    //Getters
    public String getId() {
        return id;
    }
    public String getNombre() {
        return nombre;
    }
    public TipoServicio getTipo() {
        return tipo;
    }

    //Setters
    public void setId(String id) {
        this.id = id;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setTipo(TipoServicio tipo) {
        this.tipo = tipo;
    }

}
