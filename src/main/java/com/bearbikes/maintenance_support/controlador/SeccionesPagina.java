package com.bearbikes.maintenance_support.controlador;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionLogin;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller()
public class SeccionesPagina {

    @GetMapping(value = {"/", "mainPage", "mainpage"})
    public String paginaInicial(){
        return "index";
    }

    @GetMapping("/login")
    public String formulariologin(Model parametros){
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@ModelAttribute PeticionLogin peticionLogin, Model parametros){
        System.out.println(peticionLogin);
        Connection conectionBdd = null;
        PreparedStatement preparedStatement = null;
        try{

            String sql = "SELECT * FROM prueba1;";
            conectionBdd = new BaseDeDatos().getConnection();
            preparedStatement = conectionBdd.prepareStatement(sql);

            ResultSet consultabdd = preparedStatement.executeQuery();
            List<Object> resultadosBdd = new ArrayList<>();
            while(consultabdd.next()){
                resultadosBdd.add(consultabdd.getString("id"));
            }
            parametros.addAttribute("resultados", resultadosBdd);
            System.out.println(resultadosBdd);
        }catch(SQLException e){
            parametros.addAttribute("Mensaje de Error", e.getMessage());
        }

        return "login";
    }
}
