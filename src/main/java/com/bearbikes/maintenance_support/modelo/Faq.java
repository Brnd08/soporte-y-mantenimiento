package com.bearbikes.maintenance_support.modelo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Faq {
    private int id;
    private String pregunta;
    private String solucion;
}
