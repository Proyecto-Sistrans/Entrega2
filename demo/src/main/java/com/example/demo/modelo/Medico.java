package com.example.demo.modelo;

import com.example.demo.modelo.Afiliado.TipoDocumento;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="medicos")
public class Medico {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String registroMedico;
    private String identificacion;
    private TipoDocumento tipoDocumento;
    private String nombre;
    private String especialidad;

    public Medico(String identificacion, TipoDocumento tipoDocumento, String nombre, String especialidad) {
        this.identificacion = identificacion;
        this.tipoDocumento = tipoDocumento;
        this.nombre = nombre;
        this.especialidad = especialidad;
    }

    public Medico () 
    {;}

    //Getters
    public String getRegistroMedico() {
        return registroMedico;
    }
    public String getIdentificacion() {
        return identificacion;
    }
    public TipoDocumento getTipoDocumento() {
        return tipoDocumento;
    }
    public String getNombre() {
        return nombre;
    }
    public String getEspecialidad() {
        return especialidad;
    }

    //Setters
    public void setRegistroMedico(String registroMedico) {
        this.registroMedico = registroMedico;
    }
    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
    public void setTipoDocumento(TipoDocumento tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }


}
