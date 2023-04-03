package com.bearbikes.maintenance_support.modelo.repositorio;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionAsignarReporteSoporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionRegistroReporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionSolucionSoporte;
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
     *
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

    public Reporte obtenerReportePorId(int idReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE id_reporte = (?);";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, idReporte);
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReporte(resultSet);
    }

    public List<Reporte> obtenerRepotesSoporteAsignados(int idUsuario) throws SQLException {
        String sentencia = "SELECT DISTINCT id_reporte FROM usuario_reporte WHERE id_usuario = (?);";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, idUsuario);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Reporte> reportesAsignados = new ArrayList<>();
        while (resultSet.next()) {
            reportesAsignados.add(obtenerReportePorId(resultSet.getInt("id_reporte")));
        }
        return reportesAsignados;
    }

    public List<Reporte> obtenerRepotesMantenimiento(Reporte.StatusReporte statusReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = (?) AND tipo_reporte = 'MANTENIMIENTO';";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, statusReporte.name());
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public boolean asignarReporte(PeticionAsignarReporteSoporte peticionAsignarReporteSoporte, int idUsuario) throws SQLException {
        String sentencia =
                """
                            insert into usuario_reporte values ((?), (?));
                        """;
        int otroUsuarioId = peticionAsignarReporteSoporte.idUsuario().orElse(idUsuario);
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, otroUsuarioId != 0 ? otroUsuarioId : idUsuario);
        preparedStatement.setInt(2, peticionAsignarReporteSoporte.idReporte());
        int modificados = preparedStatement.executeUpdate();

        String sentencia2 =
                """
                            UPDATE reportes SET status_reporte = 'SOLUCIONADO_SOPORTE' where id_reporte = (?);
                        """;
        PreparedStatement preparedStatement2 = connectionBdd.prepareStatement(sentencia2);
        preparedStatement2.setInt(1, peticionAsignarReporteSoporte.idReporte());
        int modificados2 = preparedStatement.executeUpdate();
        return modificados == 1 && modificados2 == 1;
    }

    public boolean añadirReporte(PeticionRegistroReporte reporteAñadir) throws SQLException {
        String sentencia =
                """
                        INSERT INTO reportes (email_usuario, nombre_reporte, status_reporte, pregunta_reporte, tipo_reporte) values
                        	((?), (?), (?), (?), (?));
                        """;
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, reporteAñadir.email());
        preparedStatement.setString(2, reporteAñadir.nombre());
        preparedStatement.setString(3, Reporte.StatusReporte.ABIERTO_SOPORTE.name());
        preparedStatement.setString(4, reporteAñadir.pregunta());
        preparedStatement.setString(5, reporteAñadir.tipoReporte());
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }

    public boolean solucionarReporteSoporte(PeticionSolucionSoporte peticionSolucionSoporte) throws SQLException {
        String sentencia =
                """
                            UPDATE reportes SET solucion_reporte = (?), status_reporte = 'SOLUCIONADO_SOPORTE'  WHERE id_reporte = (?);
                        """;

        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, peticionSolucionSoporte.solucion());
        preparedStatement.setInt(2, peticionSolucionSoporte.idReporte());
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }

    public List<Reporte> obtenerReportesSoporteSolucionados() throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = 'SOLUCIONADO_SOPORTE' AND tipo_reporte = 'SOPORTE';";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
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
                Reporte.StatusReporte statusReporte = Reporte.StatusReporte.valueOf(rs.getString("status_reporte"));
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
