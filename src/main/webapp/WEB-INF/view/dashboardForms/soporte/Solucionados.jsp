<%@ page import="com.bearbikes.maintenance_support.modelo.Reporte" %>
<%@ page
        import="java.util.List" %><%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<%
    List<Reporte> reportesResueltos = (List<Reporte>) session.getAttribute("reportes-solucionados-soporte");
    System.out.println("reportesResueltos " + reportesResueltos);

    String errorDevolucionReporteSoporte = (String) session.getAttribute("errorDevolucionReporteSoporte");
    System.out.println(errorDevolucionReporteSoporte);
    String exitoDevolucionReporteSoporte = (String) session.getAttribute("exitoDevolucionReporteSoporte");
    System.out.println(exitoDevolucionReporteSoporte);

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
<h2>Devolver solucion al Usuario</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/devolver-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- SELECT REPORTE A DEVOLVER ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="idReporte" id="reporteAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A DEVOLVER</option>
                <%
                    if (reportesResueltos != null) {
                        for (Reporte reporteResuelto : reportesResueltos) {

                            out.print(
                                    "<option value='" + reporteResuelto.getId() + "' >" + "REPORTE #" + reporteResuelto.getId() +"</option>"+
                                    "<option disabled > &nbsp;&nbsp;&nbsp; Nombre Reporte: " + reporteResuelto.getNombre() +"</option>"+
                                    "<option disabled > &nbsp;&nbsp;&nbsp; Email Usuario: " + reporteResuelto.getEmailUsuario() +"</option>"+
                                    "<option disabled > &nbsp;&nbsp;&nbsp; Pregunta: " + reporteResuelto.getPregunta() +"</option>"+
                                    "<option disabled > &nbsp;&nbsp;&nbsp; Solucion: " + reporteResuelto.getSolucion() +"</option>"+
                                    "<option disabled > &nbsp;&nbsp;&nbsp; Status: " + reporteResuelto.getStatus() +"</option>"

                            );
                        }
                    }
                %>

            </select>
            <label for="reporteAsignado">Reporte Resolver</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Enviar Solucion</button>
    </form>



    <%
        if (errorDevolucionReporteSoporte != null) {
            out.print(plantillaMensajeError.replace("$ContenidoMensaje", errorDevolucionReporteSoporte));
            session.removeAttribute("errorDevolverReporte");
        }
        if (exitoDevolucionReporteSoporte != null) {
            out.print(plantillaMensajeExito.replace("$ContenidoMensaje", exitoDevolucionReporteSoporte));
            session.removeAttribute("exitoDevolverReporte");
        }

    %>
</div>