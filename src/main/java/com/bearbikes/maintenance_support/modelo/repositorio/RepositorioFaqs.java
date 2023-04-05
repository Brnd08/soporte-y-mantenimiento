package com.bearbikes.maintenance_support.modelo.repositorio;

import com.bearbikes.maintenance_support.bdd.BaseDeDatos;
import com.bearbikes.maintenance_support.modelo.Faq;
import com.bearbikes.maintenance_support.modelo.peticiones.PeticionRegistroFaq;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.bearbikes.maintenance_support.modelo.repositorio.RepositorioFaqs.MapeadorFaqs.mapearFaqs;

@Repository
public class RepositorioFaqs{

    private Connection connectionBdd;


    public RepositorioFaqs() throws SQLException {
        this.connectionBdd = new BaseDeDatos().getConnection();
    }


    public List<Faq> obtenerFaqsRegistradas() throws SQLException {
        String sentencia = "SELECT * FROM faqs;";
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        ResultSet resultSet = preparedStatement.executeQuery();
        return mapearFaqs(resultSet);
    }

    public boolean añadirFaq(PeticionRegistroFaq peticionRegistroFaq) throws SQLException {
        String sentencia =
                        """
                        INSERT INTO faqs (pregunta, respuesta)
                        VALUES ((?), (?));
                        """;
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setString(1, peticionRegistroFaq.pregunta().orElseThrow(() -> new RuntimeException("Se intentto crear un faq sin pregunda")));
        preparedStatement.setString(2, peticionRegistroFaq.respuesta().orElseThrow(() -> new RuntimeException("Se intentto crear un faq sin repuesta")));
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }

    public boolean publicarReporteComoFaq(PeticionRegistroFaq peticionRegistroFaq) throws SQLException {
        String sentencia =
                """
                INSERT INTO faqs (pregunta, respuesta)
                    SELECT pregunta_reporte, solucion_reporte
                    FROM reportes
                    WHERE id_reporte = (?);
                """;
        PreparedStatement preparedStatement = connectionBdd.prepareStatement(sentencia);
        preparedStatement.setInt(1, peticionRegistroFaq.idReporte().orElseThrow(() -> new RuntimeException("Se intento publicar un reporte inexitente")));
        int modificados = preparedStatement.executeUpdate();
        return modificados == 1;
    }



    public static class MapeadorFaqs {
        public static List<Faq> mapearFaqs(ResultSet rs) throws SQLException {
            List<Faq> listaReportes = new ArrayList<>();
            while (rs.next()) {
                listaReportes.add(mapearFaq(rs));
            }
            if(listaReportes.isEmpty())
                System.out.println("La lista recupertada esta vacia :((");
            return listaReportes;


        }

        public static Faq mapearFaq(ResultSet rs) throws SQLException {
            Faq faqRecuperada = null;

            faqRecuperada = new Faq(
                    rs.getInt("id_pregunta"),
                    rs.getString("pregunta"),
                    rs.getString("respuesta")
            );

            return faqRecuperada;

        }
    }
}