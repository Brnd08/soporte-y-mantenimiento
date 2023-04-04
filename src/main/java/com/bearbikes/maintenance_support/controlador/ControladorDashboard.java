package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.*;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioFaqs;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioReportes;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioUsuarios;
import com.bearbikes.maintenance_support.modelo.usuarios.Usuario;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.SQLException;
import java.util.List;

@Controller
public class ControladorDashboard {
    @Autowired
    private final RepositorioReportes repositorioReportes;
    @Autowired
    private final RepositorioFaqs repositorioFaqs;
    @Autowired
    private final RepositorioUsuarios repositorioUsuarios;

    @Autowired
//    private final EmailService servicioEmails;


    public ControladorDashboard(RepositorioReportes repositorioReportes,
                                RepositorioUsuarios repositorioUsuarios,
                                RepositorioFaqs repositorioFaqs
//                                EmailService servicioEmails
    ) {
        this.repositorioReportes = repositorioReportes;
        this.repositorioFaqs = repositorioFaqs;
//        this.servicioEmails = servicioEmails;
        this.repositorioUsuarios = repositorioUsuarios;
    }


    @GetMapping("/dashboard")
    public String mostrarDashboard(Model model, HttpSession session) {
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }
        session.setAttribute("modulos disponibles", rolesUsuario);

        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }

    @PostMapping("/dashboard")
    public String añadirReporte(Model model, HttpSession session) {
        model.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }
        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }

    @PostMapping("/nuevo-reporte")
    public String nuevoReporte(Model parametros, HttpSession session, @ModelAttribute PeticionRegistroReporte peticionRegistroReporte) {
        parametros.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        System.out.println(peticionRegistroReporte);
        try {
            boolean registroExitoso = repositorioReportes.añadirReporte(peticionRegistroReporte);
            System.out.println("Registro exitosos? =>" + registroExitoso);
            session.setAttribute("exitoRegistro", "se añadio el reporte satisfactoriamente");
        } catch (SQLException e) {
            session.setAttribute("errorRegistro", e.getMessage());

            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }


    @PostMapping("/asignar-ingenierio-soporte")
    public String asignarReporte(Model parametros, HttpSession session, @ModelAttribute PeticionAsignarReporteSoporte peticionAsignarReporteSoporte) {
        parametros.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        System.out.println(peticionAsignarReporteSoporte);
        try {
            boolean asignacionExitosa = repositorioReportes.asignarReporte(peticionAsignarReporteSoporte, usuarioActivo.getId());
            System.out.println("asignacionExitosa? =>" + asignacionExitosa);
            session.setAttribute("exitoAsignacionReporteSoporte", "se asigno correctamente al usuario");
        } catch (SQLException e) {
            session.setAttribute("errorAsignacionReporteSoporte", e.getMessage());

            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }

    @PostMapping("/solucion-reporte")
    public String solucionarSoporte(Model parametros, HttpSession session, @ModelAttribute PeticionSolucionSoporte peticionSolucionSoporte) {
        parametros.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        System.out.println(peticionSolucionSoporte);
        try {
            boolean asignacionExitosa = repositorioReportes.solucionarReporteSoporte(peticionSolucionSoporte);
            System.out.println("solcion exitosa ? =>" + asignacionExitosa);
            session.setAttribute("exitoResolucionReporteSoporte", "Se guardo la solucion correctamente");
        } catch (SQLException e) {
            session.setAttribute("errorResolucionReporteSoporte", e.getMessage());

            System.out.println(e.getMessage());
            e.printStackTrace();
        }

        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }

    @PostMapping("/devolver-reporte")
    public String enviarReportePorEmail(Model parametros, HttpSession session, @ModelAttribute PeticionDevolverReporte peticionDevolverReporte) {
        parametros.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        System.out.println(peticionDevolverReporte);
        try {

            boolean asignacionExitosa = repositorioReportes.devolverReporte(peticionDevolverReporte);
            System.out.println("devolucion exitosa ? =>" + asignacionExitosa);
            session.setAttribute("exitoDevolucionReporteSoporte", "Se devolvio el reporte y se cerro correctamente");
        } catch (SQLException e) {
            session.setAttribute("errorDevolucionReporteSoporte", e.getMessage());
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }

    @PostMapping("/agregar-faq")
    public String agregarNuevaFaq(Model parametros, HttpSession session, @ModelAttribute PeticionRegistroFaq peticionRegistroFaq) {
        parametros.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        System.out.println(peticionRegistroFaq);
        try {
            boolean registroFaqExitoso;
            if (peticionRegistroFaq.idReporte().isPresent()) {

                registroFaqExitoso = repositorioFaqs.publicarReporteComoFaq(peticionRegistroFaq);
                session.setAttribute("exitoAgregarFaq", "Se añadio la faq exitosamente");
            } else {
                registroFaqExitoso = repositorioFaqs.añadirFaq(peticionRegistroFaq);
                session.setAttribute("exitoAgregarFaq1", "Se añadio la faq exitosamente");
            }
            System.out.println("registro faq exitosa ? =>" + registroFaqExitoso);
        } catch (SQLException e) {
            if (peticionRegistroFaq.idReporte().isPresent())
                session.setAttribute("errorAgregarFaq", e.getMessage());
            else
                session.setAttribute("errorAgregarFaq1", e.getMessage());
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return dashboardConAtributosDeSesion(session, usuarioActivo);
    }


    private String dashboardConAtributosDeSesion(HttpSession session, Usuario usuarioActivo) {
        try {
            session.setAttribute("reportes-soporte-abiertos", repositorioReportes.obtenerReportesPorTipoYStatus(
                    Reporte.StatusReporte.ABIERTO_SOPORTE, Reporte.TipoReporte.SOPORTE));
            session.setAttribute("ingenieros-soporte", repositorioUsuarios.obtenerPorTipoUsuario(
                    Usuario.TipoUsuario.INGENIERO_SOPORTE));
            session.setAttribute("reportes-soporte-asignados", repositorioReportes.obtenerReportesSoporteAsignados(usuarioActivo.getId()));
            session.setAttribute("reportes-solucionados-soporte", repositorioReportes.obtenerReportesSoporteSolucionados());
            session.setAttribute("reportes-registrados", repositorioReportes.obtenerReportesRegistrados());
            session.setAttribute("reportes-cerrados", repositorioReportes.obtenerReportesPorStatus(Reporte.StatusReporte.CERRADO));
            session.setAttribute("faqs-registradas", repositorioFaqs.obtenerFaqsRegistradas());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "dashboard";
    }

}
