package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioFaqs;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioReportes;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioUsuarios;
import com.bearbikes.maintenance_support.modelo.usuarios.Usuario;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.sql.SQLException;
import java.util.List;

@Controller
@CrossOrigin
public class ControladorActualizar {

    @Autowired
    private final RepositorioReportes repositorioReportes;
    @Autowired
    private final RepositorioFaqs repositorioFaqs;
    @Autowired
    private final RepositorioUsuarios repositorioUsuarios;

    public ControladorActualizar(RepositorioReportes repositorioReportes, RepositorioFaqs repositorioFaqs, RepositorioUsuarios repositorioUsuarios) {

        this.repositorioReportes = repositorioReportes;
        this.repositorioFaqs = repositorioFaqs;
        this.repositorioUsuarios = repositorioUsuarios;
    }

    @GetMapping("/soporte/{seccion}/{idReporte}")
    public String regresarActualizadoSoporte(
            @PathVariable String seccion, @PathVariable int idReporte,
            HttpServletResponse response, HttpSession session) {
        System.out.println("Actualizar soporte seccion ==>" + seccion + "reporte Modificar ==> " + idReporte);
        cargarVariablesSession(session);

        switch (seccion) {
            case "asignarIngenieroSoporte" -> {
                List<Reporte> reportesAbiertos = (List<Reporte>) session.getAttribute("reportes-soporte-abiertos");
                session.removeAttribute("reportes-soporte-abiertos");
                Reporte recuperado = null;
                for (Reporte reporteAbierto : reportesAbiertos)
                    if (reporteAbierto.getId() == idReporte) {
                        recuperado = reporteAbierto;
                        break;
                    }

                if (recuperado != null)
                    session.setAttribute("reportes-soporte-abiertos", List.of(recuperado));
                else
                    session.setAttribute("reportes-soporte-abiertos", reportesAbiertos);

                return "dashboardForms/soporte/AsignarIngenieroSoporte";
            }
            case "resolverAsignado" -> {
                List<Reporte> reportesAsignados = (List<Reporte>) session.getAttribute("reportes-soporte-asignados");
                session.removeAttribute("reportes-soporte-asignados");
                Reporte recuperado = null;
                for (Reporte reporteAsignado : reportesAsignados)
                    if (reporteAsignado.getId() == idReporte) {
                        recuperado = reporteAsignado;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-soporte-asignados", List.of(recuperado));
                else
                    session.setAttribute("reportes-soporte-asignados", reportesAsignados);
                return "dashboardForms/soporte/ReportesAsignados";
            }
            case "devolverSolucionado" -> {

                List<Reporte> reportesSolucionados = (List<Reporte>) session.getAttribute("reportes-solucionados-soporte");
                session.removeAttribute("reportes-solucionados-soporte");
                Reporte recuperado = null;
                for (Reporte reporteResuelto : reportesSolucionados)
                    if (reporteResuelto.getId() == idReporte) {
                        recuperado = reporteResuelto;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-solucionados-soporte", List.of(recuperado));
                else
                    session.setAttribute("reportes-solucionados-soporte", reportesSolucionados);

                return "dashboardForms/soporte/Solucionados";
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
        return null;
    }


    @GetMapping("/mantenimiento/{seccion}/{idReporte}")
    public String regresarActualizadoMantenimiento(
            @PathVariable String seccion, @PathVariable int idReporte,
            HttpServletResponse response, HttpSession session) {
        System.out.println("Actualizar mantenimiento seccion ==>" + seccion + "reporte Modificar ==> " + idReporte);
        cargarVariablesSession(session);

        switch (seccion) {
            case "asignarGerenteMantenimiento" -> {
                List<Reporte> reportesAbiertos = (List<Reporte>) session.getAttribute("reportes-mantenimiento-abiertos");
                session.removeAttribute("reportes-soporte-abiertos");
                Reporte recuperado = null;
                for (Reporte reporteAbierto : reportesAbiertos)
                    if (reporteAbierto.getId() == idReporte) {
                        recuperado = reporteAbierto;
                        break;
                    }

                if (recuperado != null)
                    session.setAttribute("reportes-soporte-abiertos", List.of(recuperado));
                else
                    session.setAttribute("reportes-soporte-abiertos", reportesAbiertos);

                return "dashboardForms/mantenimiento/AsignarGerenteMantenimiento";
            }
            case "asignarIngenieroMantenimiento" -> {
                List<Reporte> reportesProceso = (List<Reporte>) session.getAttribute("reportes-mantenimiento-en-proceso");
                session.removeAttribute("reportes-mantenimiento-en-proceso");
                Reporte recuperado = null;
                for (Reporte reporteProceso : reportesProceso)
                    if (reporteProceso.getId() == idReporte) {
                        recuperado = reporteProceso;
                        break;
                    }

                if (recuperado != null)
                    session.setAttribute("reportes-mantenimiento-en-proceso", List.of(recuperado));
                else
                    session.setAttribute("reportes-mantenimiento-en-proceso", reportesProceso);

                return "dashboardForms/mantenimiento/AsignarIngenieroMantenimiento";
            }
            case "resolverReporte" -> {
                List<Reporte> reportesAsignados = (List<Reporte>) session.getAttribute("reportes-mantenimiento-asignados");
                session.removeAttribute("reportes-mantenimiento-asignados");
                Reporte recuperado = null;
                for (Reporte reporteAsignado : reportesAsignados)
                    if (reporteAsignado.getId() == idReporte) {
                        recuperado = reporteAsignado;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-mantenimiento-asignados", List.of(recuperado));
                else
                    session.setAttribute("reportes-mantenimiento-asignados", reportesAsignados);
                return "dashboardForms/mantenimiento/ReportesAsignados";
            }

            case "informarProgramado" -> {

                List<Reporte> reportesSolucionados = (List<Reporte>) session.getAttribute("reportes-solucionados-mantenimiento");
                session.removeAttribute("reportes-solucionados-mantenimiento");
                Reporte recuperado = null;
                for (Reporte reporteProgramado : reportesSolucionados)
                    if (reporteProgramado.getId() == idReporte) {
                        recuperado = reporteProgramado;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-solucionados-mantenimiento", List.of(recuperado));
                else
                    session.setAttribute("reportes-solucionados-mantenimiento", reportesSolucionados);

                return "dashboardForms/mantenimiento/InformarGerenteSoporteSolucionados";
            }

            case "asignarImplementado" -> {

                List<Reporte> reportesSolucionados = (List<Reporte>) session.getAttribute("reportes-mantenimiento-implementados");
                session.removeAttribute("reportes-mantenimiento-implementados");
                Reporte recuperado = null;
                for (Reporte reporteImplementado : reportesSolucionados)
                    if (reporteImplementado.getId() == idReporte) {
                        recuperado = reporteImplementado;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-mantenimiento-implementados", List.of(recuperado));
                else
                    session.setAttribute("reportes-mantenimiento-implementados", reportesSolucionados);

                return "dashboardForms/mantenimiento/AsignarImplementado";
            }


            case "devolverImplementado" -> {

                List<Reporte> reportesSolucionados = (List<Reporte>) session.getAttribute("reportes-verificados-mantenimiento");
                session.removeAttribute("reportes-verificados-mantenimiento");
                Reporte recuperado = null;
                for (Reporte reporteResuelto : reportesSolucionados)
                    if (reporteResuelto.getId() == idReporte) {
                        recuperado = reporteResuelto;
                        break;
                    }
                if (recuperado != null)
                    session.setAttribute("reportes-verificados-mantenimiento", List.of(recuperado));
                else
                    session.setAttribute("reportes-verificados-mantenimiento", reportesSolucionados);

                return "dashboardForms/mantenimiento/Solucionados";
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
        return null;
    }


    @GetMapping("/editor/{idReporte}")
    public String regresarActualizadoEditor(@PathVariable int idReporte, HttpServletResponse response, HttpSession session) {
        System.out.println("Actualizar editor reporte añadir ==> " + idReporte);
        cargarVariablesSession(session);
        List<Reporte> reportesCerrados = (List<Reporte>) session.getAttribute("reportes-cerrados");
        session.removeAttribute("reportes-cerrados");
        Reporte recuperado = null;
        for (Reporte reporteCerrado : reportesCerrados)
            if (reporteCerrado.getId() == idReporte) {
                recuperado = reporteCerrado;
                break;
            }

        session.setAttribute("reportes-cerrados", (recuperado != null) ? List.of(recuperado) : reportesCerrados);
        response.setStatus(HttpServletResponse.SC_OK);
        return "dashboardForms/faqs/AñadirFaqDesdeReporte";
    }


    private void cargarVariablesSession(HttpSession session) {

        try {
            Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
            session.setAttribute("reportes-soporte-abiertos", repositorioReportes.obtenerReportesPorTipoYStatus(
                    Reporte.StatusReporte.ABIERTO, Reporte.TipoReporte.SIN_ESPECIFICAR));
            session.setAttribute("ingenieros-soporte", repositorioUsuarios.obtenerPorTipoUsuario(
                    Usuario.TipoUsuario.INGENIERO_SOPORTE));
            session.setAttribute("usuarios-registrados", repositorioUsuarios.obtenerPorTipoUsuario(
                    Usuario.TipoUsuario.USUARIO));
            session.setAttribute("reportes-soporte-asignados",
                    repositorioReportes.obtenerReportesSoporteAsignados(usuarioActivo.getId()));
            session.setAttribute("reportes-solucionados-soporte",
                    repositorioReportes.obtenerReportesSoporteSolucionados());
            session.setAttribute("reportes-solucionados-mantenimiento",
                    repositorioReportes.obtenerReportesMantenimientoSolucionados());
            session.setAttribute("reportes-verificados-mantenimiento",
                    repositorioReportes.obtenerReportesMantenimientoVerificados());
            session.setAttribute("reportes-registrados", repositorioReportes.obtenerReportesRegistrados());
            session.setAttribute("reportes-cerrados",
                    repositorioReportes.obtenerReportesPorStatus(Reporte.StatusReporte.CERRADO));
            session.setAttribute("faqs-registradas", repositorioFaqs.obtenerFaqsRegistradas());
            session.setAttribute("reportes-mantenimiento-abiertos", repositorioReportes.obtenerReportesPorTipoYStatus(
                    Reporte.StatusReporte.ABIERTO, Reporte.TipoReporte.SIN_ESPECIFICAR));
            session.setAttribute("reportes-mantenimiento-en-proceso", repositorioReportes.obtenerReportesPorTipoYStatus(Reporte.StatusReporte.EN_PROCESO, Reporte.TipoReporte.MANTENIMIENTO));
            session.setAttribute("reportes-mantenimiento-asignados", repositorioReportes.obtenerReportesPorTipoYStatus(Reporte.StatusReporte.EN_PROGRAMACIÓN, Reporte.TipoReporte.MANTENIMIENTO));
            session.setAttribute("reportes-mantenimiento-implementados", repositorioReportes.obtenerReportesPorTipoYStatus(Reporte.StatusReporte.IMPLEMENTADO_MANTENIMIENTO, Reporte.TipoReporte.MANTENIMIENTO));
            session.setAttribute("gerentes-mantenimiento", repositorioUsuarios.obtenerPorTipoUsuario(
                    Usuario.TipoUsuario.GERENTE_MANTENIMIENTO));
            session.setAttribute("ingenieros-mantenimiento", repositorioUsuarios.obtenerPorTipoUsuario(
                    Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO));


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
