package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.modelo.peticiones.PeticionLogin;
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

@Controller()
public class ControladorPrincipal {

    @Autowired
    private final RepositorioUsuarios repositorioUsuarios;

    public ControladorPrincipal(RepositorioUsuarios repositorioUsuarios) {
        this.repositorioUsuarios = repositorioUsuarios;
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
}
