package com.bearbikes.maintenance_support.modelo.repositorio;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.usuarios.*;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
@Repository
public class RepositorioUsuarios {
    private Connection connectionBdd;


    public RepositorioUsuarios() throws SQLException {
        this.connectionBdd = new BaseDeDatos().getConnection();
    }



    public List<Usuario> obtenerPorTipoUsuario(Usuario.TipoUsuario tipo) throws SQLException {
        String sql = "select * from usuarios WHERE tipo_usuario = (?);";
        PreparedStatement preparedStatement= connectionBdd.prepareStatement(sql);
        preparedStatement.setString(1, tipo.name());
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorUsuarios.mapearUsuarios(resultSet);
    }


    public Usuario iniciarSesion(String email, String password) throws SQLException {
        String sentenciaLogin = "SELECT * FROM usuarios WHERE email_usuario = (?) AND password_usuario = (?);";
        PreparedStatement preparedStatement= connectionBdd.prepareStatement(sentenciaLogin);
        preparedStatement.setString(1, email);
        preparedStatement.setString(2, password);

        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorUsuarios.mapearUsuario(resultSet);
    }


    public static class MapeadorUsuarios{
        public static List<Usuario> mapearUsuarios(ResultSet rs) throws SQLException {
            List<Usuario> listaUsuarios = new ArrayList<>();
            while(!rs.isLast()){
                listaUsuarios.add(mapearUsuario(rs));
            }
            return listaUsuarios;
        }

        public static Usuario mapearUsuario(ResultSet rs) throws SQLException {
            Usuario usuarioObtenido;

            if (rs.next()){
                Usuario.TipoUsuario tipoUsuario = Usuario.TipoUsuario.valueOf(rs.getString("tipo_usuario"));
                String contraseña =  (rs.getString("password_usuario"));
                String nombre =  (rs.getString("nombre_usuario"));
                String email =  (rs.getString("email_usuario"));

                switch (tipoUsuario){
                    case USUARIO -> usuarioObtenido = new UsuarioSimple(email, contraseña, nombre);
                    case EDITOR -> usuarioObtenido = new Editor(email, contraseña, nombre);
                    case ASISTENTE -> usuarioObtenido = new Asistente(email, contraseña, nombre);
                    case GERENTE_SOPORTE -> usuarioObtenido = new GerenteSoporte(email, contraseña, nombre);
                    case INGENIERO_SOPORTE -> usuarioObtenido = new IngenieroSoporte(email, contraseña, nombre);
                    case GERENTE_MANTENIMIENTO -> usuarioObtenido = new GerenteMantenimiento(email, contraseña, nombre);
                    case INGENIERO_MANTENIMIENTO -> usuarioObtenido = new IngenieroMantenimiento(email, contraseña, nombre);
                    default -> throw new SQLException("Se recupero un tipo de usuario invalido");
                }
                int id =  (rs.getInt("id_usuario"));
                usuarioObtenido.setId(id);
                return usuarioObtenido;

            }else
                throw new SQLException("No se recupero ningun usuario");
        }
    }
}
