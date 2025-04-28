package com.example.demo.controladores;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.autoconfigure.pulsar.PulsarProperties.Transaction;
//import org.springframework.data.jpa.repository.Modifying;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.example.demo.modelo.Agenda;
import com.example.demo.repositorio.AgendaRepository;
import com.example.demo.services.DisponibilidadService;
import com.example.demo.services.AgendamientoService;


@RestController
public class AgendaController {
    @Autowired
    private AgendaRepository repository;

    @Autowired
    private DisponibilidadService DisponibilidadService;

    @Autowired
    private AgendamientoService AgendamientoService;

    @GetMapping("/agenda")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] info = repository.darAgendas();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            
            m.put("fecha", o[0]); 
            m.put("duracion", o[1]); 
            m.put("estado",  o[2]); 
            m.put("paciente_cita",  o[3]); 
            m.put("medico_cita",  o[4]); 
            m.put("servicio_cita",  o[5]); 
            m.put("orden_cita",  o[6]); 
            m.put("id",  o[7]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    //RF7 modificado para que no sea necesario un paciente para crear una cita
    @PostMapping("/agenda/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        // fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita
        repository.insertarAgenda(
            body.get("fecha"), 
            body.get("duracion"), 
            body.get("estado"),
            body.get("paciente_cita"),
            body.get("medico_cita"),
            body.get("servicio_cita"),
            body.get("orden_cita")
        );

        return ResponseEntity.ok("Agenda creada correctamente");
    }

    @PostMapping("/RF8")
    public ResponseEntity<String> rf8(@RequestBody Map<String, String> body) {
        repository.cerrarAgenda(
            body.get("id")
        );
        return ResponseEntity.ok("Agenda cerrada correctamente");
    }


    @PostMapping("/RFC1")
    public ResponseEntity<List<Map<String, Object>>> rfc1(@RequestBody Map<String, String> body) {
        // fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita
        Object[][] info = repository.RFC1(
            body.get("codigoServicio")
        );

        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            
            m.put("servicio", o[0]); 
            m.put("fecha", o[1]); 
            m.put("ips",  o[2]); 
            m.put("medico",  o[3]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/RFC2")
    public ResponseEntity<List<Map<String, Object>>> rfc2(@RequestBody Map<String, String> body) {
        // fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita
        Object[][] info = repository.RFC2(
            body.get("fechaInicio"),
            body.get("fechaFin")
        );

        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            
            m.put("nombre", o[0]); 
            m.put("count", o[1]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/RFC3")
    public ResponseEntity<List<Map<String, Object>>> rfc3(@RequestBody Map<String, String> body) {
        // fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita
        Object[][] info = repository.RFC3(
            body.get("fechaInicio"),
            body.get("fechaFin")
        );

        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            
            m.put("nombre", o[0]); 
            m.put("indice de uso", o[1]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/RFC4")
    public ResponseEntity<List<Map<String, Object>>> rfc4(@RequestBody Map<String, String> body) {
        // fecha, duracion, estado, paciente_cita, medico_cita, servicio_cita, orden_cita
        Object[][] info = repository.RFC4(
            body.get("identificacion"),
            body.get("fechaInicio"),
            body.get("fechaFin")
        );

        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            
            m.put("servicio", o[0]); 
            m.put("fecha", o[1]); 
            m.put("ips",  o[2]); 
            m.put("medico",  o[3]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

   @PostMapping("/RF9")
    public ResponseEntity<?> rf9(@RequestBody Map<String, String> body) {
        try {
            String agendaId = body.get("agendaId");
            String pacienteId = body.get("pacienteId");
            String ordenId = body.get("ordenId");

            // Llamar al servicio para agendar el servicio
            Agenda agendada = AgendamientoService.agendarServicio(agendaId, ordenId, pacienteId);

            // Convertir la agenda a un Map para la respuesta
            Map<String, Object> response = new HashMap<>();
            response.put("id", agendada.getId());
            response.put("estado", agendada.getEstado());
            response.put("fecha", agendada.getFecha());
            response.put("orden", agendada.getOrdenCita());

            return ResponseEntity.ok(response);
        } catch (ResponseStatusException e) {
            // Manejar excepciones y devolver el mensaje de error correspondiente
            return ResponseEntity.status(e.getStatusCode()).body(e.getReason());
        } catch (Exception e) {
            // Manejar cualquier otro error inesperado
            return ResponseEntity.status(500).body("Error interno: " + e.getMessage());
        }
    }

    //Métodos para el RF9
    @PostMapping("/agendarServicio")
    public ResponseEntity<String> consultaDisponibilidad(@RequestBody Map<String, String> body) {
        try {
            //Object[][] info= AgendamientoService.
            return ResponseEntity.ok("Consulta realizada correctamente");
        } catch(Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResponseEntity.status(500).body("Error en la consulta: " + e.getMessage());
        }
    }




    //Métodos de consulta RFC5 y RFC6
    

    @PostMapping("/consultaAgenda_readCommitted")
    public ResponseEntity<?> consultaAgenda_readCommitted(@RequestBody Map<String, String> body) {
        try{
            Object[][] info= DisponibilidadService.consultarAgendasReadCommitted(
                body.get("codigoServicio"),
                body.get("codigoMedico"),
                body.get("fechaInicio"),
                body.get("fechaFin")
            );
            List<Map<String, Object>> Json = new ArrayList<>();
            for(Object[] o : info){
                Map<String, Object> m = new HashMap<>();
                
                m.put("servicio", o[0]); 
                m.put("fecha", o[1]); 
                m.put("medico",  o[2]); 
                Json.add(m);
            }           
            return ResponseEntity.ok(Json);
        }
        catch(Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResponseEntity.status(500).body("Error en la consulta: " + e.getMessage());
        }
    }

    @PostMapping("/consultaAgenda_serializable")
    public ResponseEntity<?> consultaAgenda_serializable(@RequestBody Map<String, String> body) {
        try{
            Object[][] info= DisponibilidadService.consultarAgendasSerializable(
                body.get("codigoServicio"),
                body.get("codigoMedico"),
                body.get("fechaInicio"),
                body.get("fechaFin")
            );
            List<Map<String, Object>> Json = new ArrayList<>();
            for(Object[] o : info){
                Map<String, Object> m = new HashMap<>();
                
                m.put("servicio", o[0]); 
                m.put("fecha", o[1]); 
                m.put("medico",  o[2]); 
                Json.add(m);
            }           
            return ResponseEntity.ok(Json);
        }
        catch(Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResponseEntity.status(500).body("Error en la consulta: " + e.getMessage());
        }
    }
    
}
