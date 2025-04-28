package com.example.demo.services;

import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.example.demo.modelo.Agenda;
import com.example.demo.modelo.Orden;
import com.example.demo.repositorio.AgendaRepository;
import com.example.demo.repositorio.OrdenRepository;



@Service
public class AgendamientoService {

    AgendaRepository agendaRepository;
    OrdenRepository ordenRepository;
    
    public AgendamientoService(AgendaRepository agendaRepository) {
        this.agendaRepository = agendaRepository;
        this.ordenRepository = ordenRepository;
    }
    
    /**
     * RF9: Agendar un servicio de salud de manera transaccional.
     *
     * @param agendaId  el id del espacio en la agenda elegido por el usuario
     * @param ordenId   el número de la orden de servicio (puede ser null para servicios sin orden)
     * @param afiliadoId el identificador del afiliado que agenda la cita
     * @return la agenda actualizada con estado "agendada"
     * @throws ResponseStatusException si el espacio ya no está disponible o la orden no existe
     */
    @Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = ResponseStatusException.class)
    public Agenda agendarServicio(String agendaId, String ordenId, String afiliadoId, String fecha, String medicoId) {
        // 1. Confirmar que la orden existe (si aplica)
        if (ordenId != null) {
            Optional<Orden> optOrden = ordenRepository.findById(ordenId.toString());

                if (!optOrden.isPresent()) {
                    throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "La orden " + ordenId + " no existe");
                }
            }

            // 2. Obtener la agenda y confirmar disponibilidad
            Agenda agenda = agendaRepository.darAgendaPorId(agendaId);
            if (agenda == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El espacio de agenda " + agendaId + " no existe");
            }


            int updatedRows = agendaRepository.registrarAgendamiento(agendaId, afiliadoId, ordenId, fecha, medicoId);

             // 3. Verificar si se realizó la actualización
            if (updatedRows == 0) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "El espacio de agenda ya no está disponible");
             }
         
             // 4. Retornar la agenda actualizada
            return agendaRepository.darAgendaPorId(agendaId); 
            }

}
