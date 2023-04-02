package com.bearbikes.maintenance_support.modelo.usuarios;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class GerenteSoporte extends Usuario{

    public GerenteSoporte(String email, String contraseña, String nombre){
        super(email, contraseña, nombre, TipoUsuario.GERENTE_SOPORTE);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("GerenteSoporte{");
        sb.append("id=").append(id);
        sb.append(", email='").append(email).append('\'');
        sb.append(", contraseña='").append(contraseña).append('\'');
        sb.append(", nombre='").append(nombre).append('\'');
        sb.append(", tipoUsuario=").append(tipoUsuario);
        sb.append('}');
        return sb.toString();
    }
}