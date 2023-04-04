<%@ page
        import="com.bearbikes.maintenance_support.Utils" %><%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<%

    String exitoAgregarFaq1 = (String) session.getAttribute("exitoAgregarFaq1");
    System.out.println(exitoAgregarFaq1);
    String errorAgregarFaq1 = (String) session.getAttribute("errorAgregarFaq1");
    System.out.println(errorAgregarFaq1);

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

<h2>Añadir nueva FAQ</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/agregar-faq"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%--     ------------------------------------   PREGUNTA --%>

        <div class="form-floating mb-3">
            <textarea id="pregunta" name="pregunta" class="form-control"
                      rows="5" placeholder="¿Porque no puedo iniciar sesion?"
                      required maxlength="100"></textarea>
            <label for="pregunta">Pregunta Frecuente</label>
            <div class="invalid-feedback">
                Proporciona la pregunta/solcitud que indico el usuario
            </div>
        </div>
        <%--     ------------------------------------   RESPUESTA --%>

        <div class="form-floating mb-3">
            <textarea id="respuesta" name="respuesta" class="form-control"
                      rows="5" placeholder="Porque no estas registrado dahh"
                      required maxlength="100"></textarea>
            <label for="respuesta">Respuesta Pregunta</label>
            <div class="invalid-feedback">
                Proporciona solucion/respuesta a la pregunta
            </div>
        </div>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir FAQ</button>
    </form>
    <%
        if (errorAgregarFaq1 != null) {
            out.print(plantillaMensajeError.replace("$ContenidoMensaje", errorAgregarFaq1));
            session.removeAttribute("errorResolucionReporteSoporte");
        }
        if (exitoAgregarFaq1 != null) {
            out.print(plantillaMensajeExito.replace("$ContenidoMensaje", exitoAgregarFaq1));
            session.removeAttribute("errorResolucionReporteSoporte");
        }

    %>
</div>