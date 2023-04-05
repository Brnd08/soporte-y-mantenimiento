package com.bearbikes.maintenance_support.modelo.peticiones;

import java.util.Optional;

public record PeticionAsignarReporte(Optional<Integer> idUsuario, int idReporte, String tipoReporte) {
}
