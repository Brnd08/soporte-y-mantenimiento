package com.bearbikes.maintenance_support.modelo.peticiones;

import com.bearbikes.maintenance_support.modelo.Reporte;

public record PeticionRegistroReporte(String emailUsuario, String nombreReporte, Reporte.TipoReporte tipoReporte, String preguntaReporte) {
}
