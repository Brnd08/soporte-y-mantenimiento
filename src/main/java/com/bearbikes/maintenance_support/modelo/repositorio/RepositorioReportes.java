package com.bearbikes.maintenance_support.modelo.repositorio;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionAsignarReporteGerenteMantenimiento;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionAsignarReporteSoporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionDevolverReporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionRegistroReporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionSolucionMantenimiento;
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

    public List<Reporte> obtenerReportesRegistrados() throws SQLException {
        String sentencia = "SELECT * FROM reportes order by tipo_reporte, status_reporte;";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public List<Reporte> obtenerReportesPorTipoYStatus(String tipoReporte) throws SQLException {
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
        if (resultSet.next())
            return MapeadorReportes.mapearReporte(resultSet);
        else
            throw new RuntimeException("No se encontro ningun reporte con el id => " + idReporte);
    }

    public List<Reporte> obtenerReportesSoporteAsignados(int idUsuario) throws SQLException {
        String sentencia = "SELECT distinct usuario_reporte.id_reporte, reportes.status_reporte FROM usuario_reporte, reportes WHERE usuario_reporte.id_usuario = (?) and usuario_reporte.id_reporte=reportes.id_reporte AND reportes.status_reporte = 'EN_PROCESO_SOPORTE';";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, idUsuario);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Reporte> reportesAsignados = new ArrayList<>();
        while (resultSet.next()) {
            reportesAsignados.add(obtenerReportePorId(resultSet.getInt("id_reporte")));
        }
        return reportesAsignados;
    }

    public List<Reporte> obtenerReportesPorTipoYStatus(Reporte.StatusReporte statusReporte,
            Reporte.TipoReporte tipoReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = (?) AND tipo_reporte = (?);";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, statusReporte.name());
        preparedStatement.setString(2, tipoReporte.name());
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public List<Reporte> obtenerReportesPorStatus(Reporte.StatusReporte statusReporte) throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = (?) ;";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, statusReporte.name());
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public boolean asignarReporte(PeticionAsignarReporteSoporte peticionAsignarReporteSoporte, int idUsuario)
            throws SQLException {
        String sentencia = """
                    insert into usuario_reporte values ((?), (?));
                """;
        System.out.println(peticionAsignarReporteSoporte);
        int otroUsuarioId = peticionAsignarReporteSoporte.idUsuario().orElse(idUsuario);
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, otroUsuarioId != 0 ? otroUsuarioId : idUsuario);
        preparedStatement.setInt(2, peticionAsignarReporteSoporte.idReporte());
        int modificados = preparedStatement.executeUpdate();

        Reporte reporteAsignar = obtenerReportePorId(otroUsuarioId);
        Reporte.StatusReporte status =(reporteAsignar.getTipo()).equals(Reporte.TipoReporte.SOPORTE)  ?
                Reporte.StatusReporte.EN_PROCESO_SOPORTE:
                Reporte.StatusReporte.PENDIENTE_MANTENIMIENTO;

        String sentencia2 = """
                    UPDATE reportes SET status_reporte = (?) where id_reporte = (?);
                """;
        PreparedStatement preparedStatement2 = connectionBdd.prepareStatement(sentencia2);
        preparedStatement2.setString(1, status.name());
        preparedStatement2.setInt(2, peticionAsignarReporteSoporte.idReporte());
        int modificados2 = preparedStatement2.executeUpdate();
        return modificados == 1 && modificados2 == 1;
    }

    public boolean añadirReporte(PeticionRegistroReporte reporteAñadir) throws SQLException {
        String sentencia = """
                INSERT INTO reportes (email_usuario, nombre_reporte, status_reporte, pregunta_reporte, tipo_reporte) values
                	((?), (?), (?), (?), (?));
                """;
        Reporte.StatusReporte status = Reporte.TipoReporte.valueOf(reporteAñadir.tipoReporte()).equals(Reporte.TipoReporte.SOPORTE)  ?
                Reporte.StatusReporte.ABIERTO_SOPORTE:
                Reporte.StatusReporte.RECIBIDO_MANTENIMIENTO;
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, reporteAñadir.email());
        preparedStatement.setString(2, reporteAñadir.nombre());
        preparedStatement.setString(3, status.name());
        preparedStatement.setString(4, reporteAñadir.pregunta());
        preparedStatement.setString(5, reporteAñadir.tipoReporte());
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }
    
    public boolean solucionarReporteMantenimiento(PeticionSolucionMantenimiento peticionSolucionSoporte) throws SQLException {
        String sentencia = """
                    UPDATE reportes SET solucion_reporte = (?), status_reporte = 'EN_IMPLEMENTACION_MANTENIMIENTO'  WHERE id_reporte = (?);
                """;

        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, peticionSolucionSoporte.solucion());
        preparedStatement.setInt(2, peticionSolucionSoporte.idReporte());
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }

    public boolean solucionarReporteSoporte(PeticionSolucionSoporte peticionSolucionSoporte) throws SQLException {
        String sentencia = """
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
    public List<Reporte> obtenerReportesMantenimientoSolucionados() throws SQLException {
        String sentencia = "SELECT * FROM reportes WHERE status_reporte = 'EN_IMPLEMENTACION_MANTENIMIENTO' AND tipo_reporte = 'MANTENIMIENTO';";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        ResultSet resultSet = preparedStatement.executeQuery();
        return MapeadorReportes.mapearReportes(resultSet);
    }

    public boolean devolverReporte(PeticionDevolverReporte peticionDevolverReporte) throws SQLException {
        String sentencia = """
                UPDATE reportes SET status_reporte = 'CERRADO'  WHERE id_reporte = (?);
                """;

        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, peticionDevolverReporte.idReporte());
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }

    public static class MapeadorReportes {
        public static List<Reporte> mapearReportes(ResultSet rs) throws SQLException {
            List<Reporte> listaReportes = new ArrayList<>();
            while (rs.next()) {
                listaReportes.add(mapearReporte(rs));
            }
            if (listaReportes.isEmpty())
                System.out.println("La lista recupertada esta vacia :((");
            return listaReportes;

        }

        public static Reporte mapearReporte(ResultSet rs) throws SQLException {
            Reporte reporteObtenido = null;

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
                    enviado);

            return reporteObtenido;

        }
    }

    public boolean asignarReporteMantenimientoAGerenteMantenimiento(
            PeticionAsignarReporteGerenteMantenimiento peticionAsignarReporteGerenteMantenimiento, int idUsuario)
            throws SQLException {
        String sentencia = """
                    insert into usuario_reporte values ((?), (?));
                """;
        int otroUsuarioId = peticionAsignarReporteGerenteMantenimiento.idUsuario().orElse(idUsuario);
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, otroUsuarioId != 0 ? otroUsuarioId : idUsuario);
        preparedStatement.setInt(2, peticionAsignarReporteGerenteMantenimiento.idReporte());
        int modificados = preparedStatement.executeUpdate();

        String sentencia2 = """
                    UPDATE reportes SET status_reporte = 'PENDIENTE_MANTENIMIENTO' where id_reporte = (?);
                """;
        PreparedStatement preparedStatement2 = connectionBdd.prepareStatement(sentencia2);
        preparedStatement2.setInt(1, peticionAsignarReporteGerenteMantenimiento.idReporte());
        int modificados2 = preparedStatement2.executeUpdate();
        return modificados == 1 && modificados2 == 1;
    }

    public boolean asignarReporteMantenimientoAIngenieroMantenimiento(
            PeticionAsignarReporteGerenteMantenimiento peticionAsignarReporteGerenteMantenimiento, int idUsuario)
            throws SQLException {
        String sentencia = """
                    insert into usuario_reporte values ((?), (?));
                """;
        int otroUsuarioId = peticionAsignarReporteGerenteMantenimiento.idUsuario().orElse(idUsuario);
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, otroUsuarioId != 0 ? otroUsuarioId : idUsuario);
        preparedStatement.setInt(2, peticionAsignarReporteGerenteMantenimiento.idReporte());
        int modificados = preparedStatement.executeUpdate();

        String sentencia2 = """
                    UPDATE reportes SET status_reporte = 'ASIGNADO_MANTENIMIENTO' where id_reporte = (?);
                """;
        PreparedStatement preparedStatement2 = connectionBdd.prepareStatement(sentencia2);
        preparedStatement2.setInt(1, peticionAsignarReporteGerenteMantenimiento.idReporte());
        int modificados2 = preparedStatement2.executeUpdate();
        return modificados == 1 && modificados2 == 1;
    }
}
