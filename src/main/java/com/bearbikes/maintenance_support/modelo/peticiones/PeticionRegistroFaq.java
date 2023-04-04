package com.bearbikes.maintenance_support.modelo.peticiones;


import java.util.Optional;

public record PeticionRegistroFaq(Optional<Integer> idReporte, Optional<String> pregunta, Optional<String> respuesta) {
}
