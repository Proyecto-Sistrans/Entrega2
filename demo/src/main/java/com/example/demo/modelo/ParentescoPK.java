package com.example.demo.modelo;

import java.io.Serializable;
import jakarta.persistence.*;


@Embeddable
public class ParentescoPK implements Serializable{
    
    @JoinColumn(name="afiliado", referencedColumnName="id")
    @OneToOne
    private Afiliado afiliado;

    @JoinColumn(name="familiar", referencedColumnName="id")
    @OneToOne
    private Afiliado familiar;

    public ParentescoPK(Afiliado afiliado, Afiliado familiar) {
        super();
        this.afiliado = afiliado;
        this.familiar = familiar;
    }

    public Afiliado getAfiliado() {
        return afiliado;
    }

    public void setAfiliado(Afiliado afiliado) {
        this.afiliado = afiliado;
    }

    public Afiliado getFamiliar() {
        return familiar;
    }

    public void setFamiliar(Afiliado familiar) {
        this.familiar = familiar;
    }

}
