<%@ page import="com.bearbikes.maintenance_support.modelo.Reporte" %>
<%@ page
        import="java.util.List" %><%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<%
    List<Reporte> reportesAsignadosIngeniero = (List<Reporte>) session.getAttribute("reportes-mantenimiento-asignados");
    System.out.println("reportes asignados " + reportesAsignadosIngeniero);

    String errorResolucionReporteSoporte = (String) session.getAttribute("errorResolucionReporteMantenimiento");
    System.out.println(errorResolucionReporteSoporte);

    String exitoResolucionReporteSoporte = (String) session.getAttribute("exitoResolucionReporteMantenimiento");
    System.out.println(exitoResolucionReporteSoporte);

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
                    "    $ContenidoMensaje " +
                    "  </div>\n" +
                    "</div>";


%>

<h2>Resolver Reporte Mantenimiento Asignado</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/solucion-reporte-mantenimiento"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX REPORTE A ASIGNAR ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="idReporte" id="reporteAsignadoIngenieroMantenimiento" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A RESOLVER</option>
                <%
                    if (reportesAsignadosIngeniero != null) {
                        for (Reporte reporteAsignadoIngenieroMantenimiento : reportesAsignadosIngeniero) {
                            out.print(
                                    "<option value='" + reporteAsignadoIngenieroMantenimiento.getId() + "' >" + "REPORTE #" + reporteAsignadoIngenieroMantenimiento.getId() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Nombre Reporte: " + reporteAsignadoIngenieroMantenimiento.getNombre() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Email Usuario: " + reporteAsignadoIngenieroMantenimiento.getEmailUsuario() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Pregunta: " + reporteAsignadoIngenieroMantenimiento.getPregunta() +"</option>"+
                                            "<option disabled > &nbsp;&nbsp;&nbsp; Status: " + reporteAsignadoIngenieroMantenimiento.getStatus() +"</option>"
                            );
                        }
                    }

                %>
            </select>
            <label for="reporteAsignadoIngenieroMantenimiento">Reporte Resolver</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <%--     ------------------------------------   RESPUESTA REPORTE --%>

        <div class="form-floating mb-3">
            <textarea id="solucion-soporte-mantenimiento" name="solucion" class="form-control"
                      rows="5" placeholder="No se muestran correctamente todos los campos en el formulario"
                      required maxlength="100"></textarea>
            <label for="solucion-soporte-mantenimiento">Solucion al problema</label>
            <div class="invalid-feedback">
                Proporciona la solucion que implementaste
            </div>
        </div>
        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir Solución</button>
    </form>

    <%
        if (errorResolucionReporteSoporte != null) {
            out.print(plantillaMensajeError.replace("$ContenidoMensaje", errorResolucionReporteSoporte));
            session.removeAttribute("errorResolucionReporteSoporte");
        }
        if (exitoResolucionReporteSoporte != null) {
            out.print(plantillaMensajeExito.replace("$ContenidoMensaje", exitoResolucionReporteSoporte));
            session.removeAttribute("errorResolucionReporteSoporte");
        }

    %>
</div>