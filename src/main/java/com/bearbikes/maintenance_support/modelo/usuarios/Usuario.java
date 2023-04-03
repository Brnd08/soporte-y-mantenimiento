package com.bearbikes.maintenance_support.modelo.usuarios;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@ToString
/*
 * Clase padre de la cual heredan todos los usuarios;
 */
public abstract class Usuario {
    protected int id;
    protected String email;
    protected String contraseña;

    protected String nombre;
    protected TipoUsuario tipoUsuario;

    public Usuario(String email, String contraseña, String nombre, TipoUsuario tipoUsuario) {
        this.email = email;
        this.contraseña = contraseña;
        this.nombre = nombre;
        this.tipoUsuario = tipoUsuario;
    }
    public String toStringMostrar() {
        final StringBuilder sb = new StringBuilder();
        sb.append("email='").append(email).append('\'');
        sb.append(", nombre='").append(nombre).append('\'');
        sb.append(", tipoUsuario=").append(tipoUsuario);
        return sb.toString();
    }

    /**
     * Regresa una lista conteniendo todos los roles asumibles por el usuario.
     *
     * @return Lista de objetos {@link TipoUsuario} conteniendo los roles.
     * @see TipoUsuario
     */
    public List<TipoUsuario> obtenerRoles() {
        return
                switch (tipoUsuario) {
                    case ASISTENTE, INGENIERO_MANTENIMIENTO, INGENIERO_SOPORTE, EDITOR -> List.of(tipoUsuario);
                    case GERENTE_MANTENIMIENTO -> List.of(tipoUsuario, TipoUsuario.INGENIERO_MANTENIMIENTO);
                    case GERENTE_SOPORTE -> List.of(TipoUsuario.values());
                    default -> null;
                };
    }

    /**
     * Constantes describiendo los diferentes roles de los objetos tipo {@link Usuario}
     * @see Usuario
     */
    public enum TipoUsuario {
        GERENTE_MANTENIMIENTO,
        GERENTE_SOPORTE,
        INGENIERO_SOPORTE,
        INGENIERO_MANTENIMIENTO,
        ASISTENTE,
        EDITOR

    }
}
