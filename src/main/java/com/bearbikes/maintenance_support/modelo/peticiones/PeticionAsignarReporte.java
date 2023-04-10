package com.bearbikes.maintenance_support.modelo.peticiones;

import java.util.Optional;

public record PeticionAsignarReporteSoporte(Optional<Integer> idUsuario, int idReporte, String tipoReporte) {
}
