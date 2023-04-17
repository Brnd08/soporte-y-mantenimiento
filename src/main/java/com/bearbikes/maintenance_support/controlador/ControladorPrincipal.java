package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.Reporte;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionLogin;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioFaqs;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioReportes;
import com.bearbikes.maintenance_support.modelo.repositorio.RepositorioUsuarios;
import com.bearbikes.maintenance_support.modelo.usuarios.GerenteSoporte;
import com.bearbikes.maintenance_support.modelo.usuarios.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.SQLException;
import java.util.List;

@Controller()
public class ControladorPrincipal {
    @Autowired
    private final RepositorioReportes repositorioReportes;
    @Autowired
    private final RepositorioFaqs repositorioFaqs;
    @Autowired
    private final RepositorioUsuarios repositorioUsuarios;

    public ControladorPrincipal(RepositorioReportes repositorioReportes,
                                RepositorioUsuarios repositorioUsuarios,
                                RepositorioFaqs repositorioFaqs
    ) {
        this.repositorioReportes = repositorioReportes;
        this.repositorioFaqs = repositorioFaqs;
        this.repositorioUsuarios = repositorioUsuarios;
    }

    @PostMapping(value = {"/pruebas"})
    public void actualizarSession(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        int idReporte = Integer.parseInt(request.getParameter("idReporte"));
        System.out.println("id reporte = " + idReporte);

        session.setAttribute("reportes-soporte-abiertos-modificado", true);

        List<Reporte> reportesAbiertos = (List<Reporte>) session.getAttribute("reportes-soporte-abiertos");
        Reporte recuperado = null;
        for (Reporte reporteAbierto : reportesAbiertos) {
            recuperado = reporteAbierto.getId() == idReporte ? reporteAbierto : null;
        }
        if (recuperado != null) {
            session.setAttribute("reportes-soporte-abiertos", List.of(recuperado));
            session.setAttribute("reportes-soporte-abiertos-modificado", true);

        } else
            session.setAttribute("reportes-soporte-abiertos-modificado", false);

        System.out.println("bye");
        response.setStatus(HttpStatus.OK.value());

    }

    @GetMapping(value = {"/",})
    public String paginaInicial() {
        return "index";
    }

    @GetMapping("/login")
    public String formulariologin(Model parametros) {
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@ModelAttribute PeticionLogin peticionLogin, Model parametros, HttpSession session) {
        try {
            Usuario recuperado = repositorioUsuarios.iniciarSesion(peticionLogin.email(), peticionLogin.password());
            parametros.addAttribute("sesion activa", true);
            session.setAttribute("usuario sesión", recuperado);
            session.setAttribute("roles", recuperado.obtenerRoles());
            System.out.println(recuperado);
        } catch (SQLException e) {
            parametros.addAttribute("Mensaje de Error", e.getMessage());
        }
        return "login";
    }

    @GetMapping("/faqs")
    public String regresarFaqs(HttpSession session) {
        try {
            session.setAttribute("faqs-registradas", repositorioFaqs.obtenerFaqsRegistradas());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Faqs";
    }


    @GetMapping("/pruebas")
    public String prueba(HttpSession session) {
        Usuario usuarioActivo = new GerenteSoporte("gerente@soporte.com", "contraseña", "carlos");
        añadirDatos(session, usuarioActivo);
        return "dashboardForms/AsignarIngenieroSoporte";
    }


    private void añadirDatos(HttpSession session, Usuario usuarioActivo) {
        try {
            boolean reportes_soporte_abiertos_modificado = session.getAttribute("reportes-soporte-abiertos-modificado") != null && (boolean) session.getAttribute("reportes-soporte-abiertos-modificado");
            if (!reportes_soporte_abiertos_modificado)
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
