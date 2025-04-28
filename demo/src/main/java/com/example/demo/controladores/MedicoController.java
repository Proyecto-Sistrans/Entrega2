package com.example.demo.controladores;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.repositorio.MedicoRepository;

@RestController
public class MedicoController {
    @Autowired
    private MedicoRepository repository;

    @GetMapping("/medico")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] info = repository.darMedicos();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            m.put("registro_medico", o[0]); 
            m.put("identificacion", o[1]); 
            m.put("tipo_documento",  o[2]); 
            m.put("nombre",  o[3]); 
            m.put("especialidad",  o[4]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/medico/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        repository.insertarMedico(
            body.get("registro_medico"), 
            body.get("identificacion"), 
            body.get("tipo_documento"),
            body.get("nombre"),
            body.get("especialidad")
        );

        return ResponseEntity.ok("Médico creado correctamente");
    }
}
