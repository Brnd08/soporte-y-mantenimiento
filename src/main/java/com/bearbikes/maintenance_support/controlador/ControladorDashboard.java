package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionAsignarReporteSoporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionDevolverReporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionRegistroReporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionSolucionSoporte;
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
    private final RepositorioUsuarios repositorioUsuarios;
    @Autowired
//    private final EmailService servicioEmails;


    public ControladorDashboard(RepositorioReportes repositorioReportes,
                                RepositorioUsuarios repositorioUsuarios
//                                EmailService servicioEmails
    ) {
        this.repositorioReportes = repositorioReportes;
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

        try {
            session.setAttribute("reportes-soporte-abiertos", repositorioReportes.obtenerRepotesMantenimiento(Reporte.StatusReporte.ABIERTO_SOPORTE));
            session.setAttribute("ingenieros-soporte", repositorioUsuarios.obtenerPorTipoUsuario(Usuario.TipoUsuario.INGENIERO_SOPORTE));
            session.setAttribute("reportes-soporte-asignados", repositorioReportes.obtenerRepotesSoporteAsignados(usuarioActivo.getId()));
            session.setAttribute("reportes-solucionados-soporte", repositorioReportes.obtenerReportesSoporteSolucionados());


        } catch (SQLException e) {
            e.printStackTrace();
        }


        return "dashboard";
    }

    @PostMapping("/dashboard")
    public String añadirReporte(Model model, HttpSession session) {
        model.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if (usuarioActivo == null || rolesUsuario == null) {
            return "redirect:/login";
        }

        return "dashboard";
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


        return "dashboard";
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
            boolean asignacionExitosa = repositorioReportes.asignarReporte(peticionAsignarReporteSoporte
                    , usuarioActivo.getId());
            System.out.println("asignacionExitosa? =>" + asignacionExitosa);
            session.setAttribute("exitoAsignacionReporteSoporte", "se asigno correctamente al usuario");
        } catch (SQLException e) {
            session.setAttribute("errorAsignacionReporteSoporte", e.getMessage());

            System.out.println(e.getMessage());
            e.printStackTrace();
        }


        return "dashboard";
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


        return "dashboard";
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

            boolean asignacionExitosa = repositorioReportes.solucionarReporteSoporte(peticionDevolverReporte);
            System.out.println("solcion exitosa ? =>" + asignacionExitosa);
            session.setAttribute("exitoResolucionReporteSoporte", "Se guardo la solucion correctamente");
        } catch (SQLException e) {
            session.setAttribute("errorResolucionReporteSoporte", e.getMessage());

            System.out.println(e.getMessage());
            e.printStackTrace();
        }


        return "dashboard";
    }
}
