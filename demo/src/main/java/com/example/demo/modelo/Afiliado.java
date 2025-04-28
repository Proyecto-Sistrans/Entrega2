package com.example.demo.modelo;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="afiliados")
public class Afiliado {
    
    @Id 
    @GeneratedValue(strategy = GenerationType.AUTO)

    private String id;
    private TipoDocumento tipoDocumento;
    private String nombre;
    private Date fechaNacimiento;
    private String direccion;
    private String telefono;
    
    enum TipoDocumento {
        RC, CC, TI, CE
    }


    public Afiliado(TipoDocumento tipoDocumento, String nombre, Date fechaNacimiento, String direccion, String telefono) {  
        //El id se genera automáticamente debido a la anotación @GeneratedValue
        this.tipoDocumento = tipoDocumento;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.direccion = direccion;
        this.telefono = telefono;

    }
    
    public Afiliado () 
    {;}

    //Getters
    public String getId() {
        return id;
    }
    public TipoDocumento getTipoDocumento() {
        return tipoDocumento;
    }
    public String getNombre() {
        return nombre;
    }
    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }
    public String getDireccion() {
        return direccion;
    }
    public String getTelefono() {
        return telefono;
    }

    //Setters
    public void setId(String id) {
        this.id = id;
    }
    public void setTipoDocumento(TipoDocumento tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
  
    

}