package com.example.demo.controladores;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.repositorio.AfiliadoRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@RestController
public class AfiliadoController {
    @Autowired
    private AfiliadoRepository repository;

    @GetMapping("/afiliados")
    public ResponseEntity<List<Map<String, Object>>> obtenerTodos() {
        Object[][] afiliados = repository.darAfiliados();
        List<Map<String, Object>> Json = new ArrayList<>();
        for(Object[] o : afiliados){
            Map<String, Object> m = new HashMap<>();
            m.put("id", o[0]); 
            m.put("tipoDocumento", o[1]); 
            m.put("nombre", o[2]); 
            m.put("nacimiento", o[3]); 
            m.put("direccion",  o[4]); 
            m.put("telefono",  o[5]); 
            Json.add(m);
        }
        return ResponseEntity.ok(Json);
    }

    @PostMapping("/afiliados/crear")
    public ResponseEntity<String> crear(@RequestBody Map<String, String> body) {
        repository.insertarAfiliado(
            body.get("identificacion"), 
            body.get("tipodocumento"), 
            body.get("nombre"), 
            body.get("fechanacimiento"), 
            body.get("direccion"), 
            body.get("telefono")
        );

        return ResponseEntity.ok("Afiliado creado correctamente");
    }
    
}
