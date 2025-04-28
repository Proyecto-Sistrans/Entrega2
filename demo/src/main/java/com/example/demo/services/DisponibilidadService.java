package com.example.demo.services;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repositorio.AgendaRepository;

@Service
public class DisponibilidadService {

    private AgendaRepository agendaRepository;

    public DisponibilidadService(AgendaRepository agendaRepository) {
        this.agendaRepository = agendaRepository;
    }

    @Transactional(isolation= Isolation.SERIALIZABLE, readOnly=true)
    public Object[][] consultarAgendasSerializable(String codigoServicio, String codigoMedico, String fechaInicio, String fechaFin) { 
        try {
            Thread.sleep(30000);
            Object[][] info = agendaRepository.consultaAgenda(codigoServicio, codigoMedico, fechaInicio, fechaFin);
            return info;
        } catch (InterruptedException e) {
            e.printStackTrace();
            return null;
        } 
    }

    @Transactional(isolation= Isolation.READ_COMMITTED, readOnly=true)
    public Object[][] consultarAgendasReadCommitted(String codigoServicio, String codigoMedico, String fechaInicio, String fechaFin) { 
        try {
            Thread.sleep(30000);
            Object[][] info = agendaRepository.consultaAgenda(codigoServicio, codigoMedico, fechaInicio, fechaFin);
            return info;
        } catch (InterruptedException e) {
            e.printStackTrace();
            return null;
        } 
    }
    
}
