package com.bearbikes.maintenance_support.modelo.usuarios;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class UsuarioSimple extends Usuario{

    public UsuarioSimple(String email, String contraseña, String nombre){
        super(email, contraseña, nombre, TipoUsuario.USUARIO);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Editor{");
        sb.append("id=").append(id);
        sb.append(", email='").append(email).append('\'');
        sb.append(", contraseña='").append(contraseña).append('\'');
        sb.append(", nombre='").append(nombre).append('\'');
        sb.append(", tipoUsuario=").append(tipoUsuario);
        sb.append('}');
        return sb.toString();
    }
}