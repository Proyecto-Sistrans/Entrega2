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

import com.example.demo.repositorio.OrdenRepository;

@RestController
public class OrdenController {

    @Autowired
    private OrdenRepository repository;

    @GetMapping("/orden")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] info = repository.darOrdens();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : info){
            Map<String, Object> m = new HashMap<>();
            m.put("numero", o[0]); 
            m.put("estado", o[1]); 
            m.put("fecha",  o[2]); 
            m.put("descripcion",  o[3]); 
            m.put("prescritaPor",  o[4]); 
            m.put("prescritaPara",  o[5]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/orden/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        repository.insertarOrden(
            body.get("numero"), 
            body.get("estado"), 
            body.get("fecha"),
            body.get("descripcion"),
            body.get("prescritaPor"),
            body.get("prescritaPara")
        );

        return ResponseEntity.ok("Orden creada correctamente");
    }
}
