﻿
<%@ page import="java.util.List" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.Faq" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %><%
    List<Faq> faqsRegistradas = (List<Faq>) session.getAttribute("faqs-registradas");
    System.out.println("faqs Registradas => " + faqsRegistradas);
    List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");
%>
<h2>Faqs Registradas</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <%out.print("<button type='submit' style='width: fit-content!important; display: " + (modulos.contains(Usuario.TipoUsuario.EDITOR) ? "inline-block;" : "none;") + "'  class='botonAñadirFaq w-100 btn btn-lg btn-primary'>Nueva Faq</button>");%>
    <div class="table-responsive">
        <table class="table table-striped-columns table-responsive-sm table-hover" style="text-align: center">
            <thead class="table-dark">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">PREGUNTA</th>
                <th scope="col">SOLUCION</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(Faq faqRegistrada: faqsRegistradas){
                    out.print(
                            "<tr>"+
                                    "<td>"+ faqRegistrada.getId() +"</td>" +
                                    "<td>"+ faqRegistrada.getPregunta()+"</td>" +
                                    "<td>"+ faqRegistrada.getSolucion()+"</td>" +
                                    "</tr>"
                    );
                }
            %>
            </tbody>
        </table>
    </div>
</div>
