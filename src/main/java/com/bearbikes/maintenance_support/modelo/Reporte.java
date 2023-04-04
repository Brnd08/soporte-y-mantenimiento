package com.bearbikes.maintenance_support.modelo;

import lombok.*;

import java.sql.Date;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Reporte {
    private int id;
    private String emailUsuario;
    private String nombre;
    private StatusReporte status;
    private String pregunta;
    private String solucion;
    private Date fechaReporte;
    private TipoReporte tipo;

    private boolean enviado;

    public boolean getEnviado(){
        return this.enviado;
    }

    public String toStringMostrar() {
        final StringBuilder sb = new StringBuilder();
        sb.append(id).append(" | ");
        sb.append(nombre).append(" | ");
        sb.append(pregunta).append(" | ");
        sb.append(tipo);
        return sb.toString();
    }

    public String toStringMostrar2() {
        final StringBuilder sb = new StringBuilder();
        sb.append("emailUsuario: ").append(emailUsuario).append(",<hr>");
        sb.append("nombre: ").append(nombre).append(",<hr>");
        sb.append("pregunta: ").append(pregunta).append(",<hr>");
        sb.append("solucion: ").append(solucion).append(",<hr>");
        sb.append("status:").append(status);
        return sb.toString();
    }

    public Reporte (String emailUsuario, String nombreReporte, TipoReporte tipoReporte, String pregunta){
        this.emailUsuario = emailUsuario;
        this.nombre = nombreReporte;
        this.tipo = tipoReporte;
        this.pregunta = pregunta;
    }
//    id_reporte int primary key auto_increment,
//    email_usuario varchar(30) not null,
//    nombre_reporte varchar(20)not null,
//    status_reporte varchar(30) not null references statusReportes(status),
//    pregunta_reporte varchar(100) not null,
//    solucion_reporte varchar(150) default 'Solución Pendiente',
//    fecha_reporte timestamp not null default now(),
//    tipo_reporte varchar(30) references statusReportes(tipo_reporte),
//    enviado boolean default false


    public enum TipoReporte {
        MANTENIMIENTO,
        SOPORTE
    }
    public enum StatusReporte {
        ABIERTO_SOPORTE,
        EN_PROCESO_SOPORTE,
        CERRADO,
        SOLUCIONADO_SOPORTE,
        RECIBIDO_MANTENIMIENTO,
        PENDIENTE_MANTENIMIENTO,
        ASIGNADO_MANTENIMIENTO,
        EN_IMPLEMENTACION_MANTENIMIENTO,
        IMPLEMENTADO_MANTENIMIENTO
    }

}
