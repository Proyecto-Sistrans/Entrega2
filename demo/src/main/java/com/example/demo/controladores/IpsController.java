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

import com.example.demo.repositorio.IPSRepository;

@RestController
public class IpsController {

    @Autowired
    private IPSRepository repository;

    @GetMapping("/ips")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] ips = repository.darIPSs();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : ips){
            Map<String, Object> m = new HashMap<>();
            m.put("nit", o[0]); 
            m.put("nombre", o[1]); 
            m.put("direccion",  o[2]); 
            m.put("telefono",  o[3]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/ips/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        repository.insertarIPS(
            body.get("nit"), 
            body.get("nombre"), 
            body.get("direccion"), 
            body.get("telefono")
        );

        return ResponseEntity.ok("IPS creado correctamente");
    }
    
}
