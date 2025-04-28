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

import com.example.demo.repositorio.ServicioRepository;

@RestController
public class ServicioController {

    @Autowired
    private ServicioRepository repository;

    @GetMapping("/servicio")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] ips = repository.darServicios();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : ips){
            Map<String, Object> m = new HashMap<>();
            m.put("id", o[0]); 
            m.put("tipo_servicio", o[1]); 
            m.put("nombre",  o[2]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/servicio/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        repository.insertarServicio(
            body.get("id"), 
            body.get("tipo_servicio"), 
            body.get("nombre")
        );

        return ResponseEntity.ok("Servicio creado correctamente");
    }

    @GetMapping("/servicio/ips")
    public ResponseEntity<List<Map<String, Object>>> obtenerRelaciones() {
        Object[][] info = repository.darRelaciones();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            m.put("nit", o[0]); 
            m.put("servicio_id", o[1]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/servicio/ips/asignar")
    public ResponseEntity<String> asignar(@RequestBody Map<String, String> body) {
        repository.asignar(
            body.get("nit"), 
            body.get("servicio_id")
        );

        return ResponseEntity.ok("Asignación creada correctamente");
    }
    
}
