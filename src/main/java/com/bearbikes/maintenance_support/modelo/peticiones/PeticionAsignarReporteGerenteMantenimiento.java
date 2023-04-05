package com.bearbikes.maintenance_support.modelo.peticiones;

import java.util.Optional;

public record PeticionAsignarReporteGerenteMantenimiento(Optional<Integer> idUsuario, int idReporte) {
}
