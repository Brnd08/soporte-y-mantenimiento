package com.bearbikes.maintenance_support.modelo.repositorio;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionRegistroReporte;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class RepositorioReportes {


    private Connection connectionBdd;


    public RepositorioReportes() throws SQLException {
        this.connectionBdd = new BaseDeDatos().getConnection();
    }

    /**
     * Obtiene reportes por su tipo
     * @param tipoReporte
     * @return
     * @throws SQLException
     */
    public List<Reporte> obtenerRepotesMantenimiento(String tipoReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE tipo_reporte = (?);";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, tipoReporte);
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    /**
     * Obtiene reportes por su status
     * @param statusReporte
     * @return
     * @throws SQLException
     */
    public List<Reporte> obtenerRepotesMantenimiento(Reporte.StatusReporte statusReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = (?);";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, statusReporte.name());
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public boolean añadirReporte (PeticionRegistroReporte reporteAñadir) throws SQLException {
        String sentencia =
                            """
                            INSERT INTO reportes (email_usuario, nombre_reporte, status_reporte, pregunta_reporte, tipo_reporte) values
                            	((?), (?), (?), (?), (?));
                            """;
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, reporteAñadir.emailUsuario());
        preparedStatement.setString(2, reporteAñadir.nombreReporte());
        preparedStatement.setString(3, Reporte.StatusReporte.ABIERTO_SOPORTE.name());
        preparedStatement.setString(4, reporteAñadir.preguntaReporte());
        preparedStatement.setString(5, reporteAñadir.tipoReporte().name());
        int modificados = preparedStatement.executeUpdate();
        return modificados==1;
    }



    public static class MapeadorReportes {
        public static List<Reporte> mapearReportes(ResultSet rs) throws SQLException {
            List<Reporte> listaReportes = new ArrayList<>();
            while (!rs.isLast()) {
                listaReportes.add(mapearReporte(rs));
            }
            return listaReportes;
        }

        public static Reporte mapearReporte(ResultSet rs) throws SQLException {
            Reporte reporteObtenido;
            //    id_reporte int primary key auto_increment,
//    email_usuario varchar(30) not null,
//    nombre_reporte varchar(20)not null,
//    status_reporte varchar(30) not null references statusReportes(status),
//    pregunta_reporte varchar(100) not null,
//    solucion_reporte varchar(150) default 'Solución Pendiente',
//    fecha_reporte timestamp not null default now(),
//    tipo_reporte varchar(30) references statusReportes(tipo_reporte),
//    envi

            if (rs.next()) {
                int idReporte = (rs.getInt("id_reporte"));
                String emailUsuario = rs.getString("email_usuario");
                String nombreReporte = rs.getString("nombre_reporte");
                Reporte.StatusReporte statusReporte = Reporte.StatusReporte.valueOf(rs.getString("email_usuario"));
                String preguntaReporte = rs.getString("pregunta_reporte");
                String solucionReporte = rs.getString("solucion_reporte");
                Date fechaReporte = rs.getDate("fecha_reporte");
                Reporte.TipoReporte tipoReporte = Reporte.TipoReporte.valueOf(rs.getString("tipo_reporte"));
                boolean enviado = rs.getBoolean("enviado");
                reporteObtenido = new Reporte(
                        idReporte,
                        emailUsuario,
                        nombreReporte,
                        statusReporte,
                        preguntaReporte,
                        solucionReporte,
                        fechaReporte,
                        tipoReporte,
                        enviado
                );
                return reporteObtenido;

            } else
                throw new SQLException("No se recupero ningun reporte");
        }
    }
}
