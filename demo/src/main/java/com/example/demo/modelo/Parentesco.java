package com.example.demo.modelo;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name="parentescos")
public class Parentesco {
    
    @EmbeddedId
    private ParentescoPK pk;

    public Parentesco() { }  

    public Parentesco(ParentescoPK pk) {
        this.pk = pk;
    }

    public ParentescoPK getPk() {
        return pk;
    }

    public void setPk(ParentescoPK pk) {
        this.pk = pk;
    }

    @Override
    public String toString() {
        return "Parentesco{" +
                "pk=" + pk +
                '}';
    }
}
