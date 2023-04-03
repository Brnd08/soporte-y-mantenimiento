package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.usuarios.Usuario;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class ControladorDashboard {
    @GetMapping("/dashboard")
    public String mostrarDashboard(Model model, HttpSession session) {
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");

        if(usuarioActivo==null || rolesUsuario==null){
            return "redirect:/login";
        }

        session.setAttribute("modulos disponibles", rolesUsuario);

        return "dashboard";
    }
    @PostMapping("/dashboard")
    public String añadirReporte(Model model, HttpSession session){
        model.addAttribute("sesion activa", true);
        Usuario usuarioActivo = (Usuario) session.getAttribute("usuario sesión");
        List<Usuario.TipoUsuario> rolesUsuario = (List<Usuario.TipoUsuario>) session.getAttribute("roles");
        if(usuarioActivo==null || rolesUsuario==null){
            return "redirect:/login";
        }

        return "dashboard";
    }
}
