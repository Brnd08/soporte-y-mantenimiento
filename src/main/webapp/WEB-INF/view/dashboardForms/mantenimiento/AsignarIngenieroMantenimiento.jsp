﻿<%@ page import="java.util.List" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.Reporte" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.GerenteMantenimiento" %><%-- ---------------------------------- FORMULARIO ASIGNAR INGENIEBRIO----------------------------------------------------%>

<%
    List<Reporte> reportesAsignados = (List<Reporte>) session.getAttribute("reportes-mantenimiento-asignados");
    System.out.println(reportesAsignados);

    List<Usuario> ingenierosMantenimientoDisponibles = (List<Usuario>) session.getAttribute("ingenieros-mantenimiento");
    System.out.println(ingenierosMantenimientoDisponibles);


    String errorAsignacionGerenteSoporte = (String) session.getAttribute("errorAsignacionIngenieroMantenimiento");
    System.out.println(errorAsignacionGerenteSoporte);

    String exitoAsignacionGerenteSoporte = (String) session.getAttribute("exitoAsignacionIngenieroMantenimiento");
    System.out.println(exitoAsignacionGerenteSoporte);

    String plantillaMensajeError =
            "                   <svg xmlns='http://www.w3.org/2000/svg' style='display: none;'>\n" +
                    "                        <symbol id='exclamation-triangle-fill' viewBox='0 0 16 16'>\n" +
                    "                            <path d='M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z'/>\n" +
                    "                        </symbol>\n" +
                    "                   </svg>\n" +
                    "                   <div class='alert alert-danger d-flex align-items-center ' role='alert'>\n" +
                    "                        <svg class='bi flex-shrink-0 me-2' role='img' aria-label='Danger:' style='height: 1em; width: 1em'>\n" +
                    "                            <use xlink:href='#exclamation-triangle-fill'/>\n" +
                    "                        </svg>\n" +
                    "                        <div>$ContenidoMensaje</div>\n" +
                    "                   </div>";
    String plantillaMensajeExito =
            "                   <svg xmlns='http://www.w3.org/2000/svg' style='display: none;'>\n" +
                    "                        <symbol id=\"check-circle-fill\" viewBox=\"0 0 16 16\">\n" +
                    "    <path d=\"M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z\"/>\n" +
                    "  </symbol>" +
                    "                   </svg>\n" +
                    "                   <div class=\"alert alert-success d-flex align-items-center\" role=\"alert\">\n" +
                    "  <svg style='height: 1em; width: 1em' class=\"bi flex-shrink-0 me-2\" role=\"img\" aria-label=\"Success:\"><use xlink:href=\"#check-circle-fill\"/></svg>\n" +
                    "  <div>\n" +
                    "    $ContenidoMensaje "+
                    "  </div>\n" +
                    "</div>";

%>

﻿<%-- ---------------------------------- FORMULARIO ASIGNAR INGENIEBRIO----------------------------------------------------%>
<h2>Asignar Reporte a ingeniero mantenimiento</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/asignar-reporte-ingeniero-mantenimiento"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX AUTOASIGNAR----------------------------------------------------%>
        <div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="autoAsignarseIngenieroMantenimiento" checked>
                <label class="form-check-label" for="autoAsignarseIngenieroMantenimiento">Autoasignarse Reporte</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="asignarOtroIngenieroMantenimiento">
                <label class="form-check-label" for="asignarOtroIngenieroMantenimiento">Asignar a otro gerente Mantenimiento</label>
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX USUARIO A ASIGNAR ----------------------------------------------------%>

        <div id="divIngenieroMantenimientoAsignar" class="form-floating mb-3" style="display: none">
            <select name="idUsuario" id="ingenieroMantenimientoAsignado" class="form-control"
                    placeholder="Reporte formulario index" required disabled>
                <option disabled>SELECCIONA EL INGENIERO A ASIGNAR</option>
                <%
                    if (ingenierosMantenimientoDisponibles != null) {
                        for (Usuario gerenteMantenimientoDisponible : ingenierosMantenimientoDisponibles) {
                            out.print(
                                    "<option value='" + gerenteMantenimientoDisponible.getId() + "' >" + "INGENIERO MANTENIMIENTO #" + gerenteMantenimientoDisponible.getId() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Nombre Ingeniero Mantenimiento: " + gerenteMantenimientoDisponible.getNombre() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Tipo Usuario: " + gerenteMantenimientoDisponible.getTipoUsuario() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Email: " + gerenteMantenimientoDisponible.getEmail() +"</option>"
                            );
                        }
                    }

                %>
            </select>
            <label for="ingenieroMantenimientoAsignado">Usuario asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX REPORTE A ASIGNAR ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="idReporte" id="reporteMantenimientoAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A ASIGNAR</option>
                <%
                    if (reportesAsignados != null) {
                        for (Reporte reporteAsignado : reportesAsignados) {
                            out.print(
                                    "<option value='" + reporteAsignado.getId() + "' >" + "REPORTE #" + reporteAsignado.getId() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Nombre Reporte: " + reporteAsignado.getNombre() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Email Usuario: " + reporteAsignado.getEmailUsuario() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Pregunta: " + reporteAsignado.getPregunta() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Status: " + reporteAsignado.getStatus() +"</option>"
                            );
                        }
                    }

                %>
            </select>
            <label for="reporteMantenimientoAsignado">Reporte asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>

        <script>
            const checkboxasignarOtroIngenieroMantenimiento = document.getElementById("asignarOtroIngenieroMantenimiento");
            const checkboxAutoAsignarIngenieroMantenimiento = document.getElementById("autoAsignarseIngenieroMantenimiento");
            const divIngenieroMantenimientoAsignar = document.getElementById("divIngenieroMantenimientoAsignar");
            const ingenieroMantenimientoAsignado = document.getElementById("ingenieroMantenimientoAsignado");

            checkboxasignarOtroIngenieroMantenimiento.addEventListener("change", ev => {
                divIngenieroMantenimientoAsignar.style.display = 'inherit';
                ingenieroMantenimientoAsignado.disabled = false;
            })
            checkboxAutoAsignarIngenieroMantenimiento.addEventListener("change", ev => {
                divIngenieroMantenimientoAsignar.style.display = 'none';
                ingenieroMantenimientoAsignado.disabled = true;
            })
        </script>

        <%-- ---------------------------------- SCRIPT OCULTAR CHECKBOX ----------------------------------------------------%>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Asignar</button>


    </form>

    <%
        if (errorAsignacionGerenteSoporte != null) {
            out.print(plantillaMensajeError.replace("$ContenidoMensaje", errorAsignacionGerenteSoporte));
            session.removeAttribute("errorAsignacionGerenteSoporte");
        }
        if (exitoAsignacionGerenteSoporte != null) {
            out.print(plantillaMensajeExito.replace("$ContenidoMensaje", exitoAsignacionGerenteSoporte));
            session.removeAttribute("exitoAsignacionGerenteSoporte");
        }

    %>
</div>
