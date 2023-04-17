<%@ page import="com.bearbikes.maintenance_support.modelo.Reporte" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%
    //    int idReporteAsignarIng_gSoporte = Integer.parseInt(request.getParameter("idReporteAsignarIng_gSoporte"));

    List<Reporte> reportesAbiertos = (List<Reporte>) session.getAttribute("reportes-soporte-abiertos");

    List<Reporte> reportesRegistrados = (List<Reporte>) session.getAttribute("reportes-registrados");
    System.out.println("reportes registrados => " + reportesRegistrados);

    String errorRegistro = (String) session.getAttribute("errorRegistro");
    System.out.println(errorRegistro);

    String exitoRegistro = (String) session.getAttribute("exitoRegistro");
    System.out.println(exitoRegistro);

    List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");

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
<h2>Tabla Soporte</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <%
        out.print("<button type='submit' style='width: fit-content!important; display: " + (modulos.contains(Usuario.TipoUsuario.ASISTENTE) ? "inline-block;" : "none;") + "'  class='botonAñadirReporte w-100 btn btn-lg btn-primary'>Nuevo Reporte</button>");
        out.print("<button type='submit' style='width: fit-content!important; display: " + (modulos.contains(Usuario.TipoUsuario.EDITOR) ? "inline-block;" : "none;") + "'  class='botonAñadirFaq w-100 btn btn-lg btn-primary'>Nueva Faq</button>");
    %>
    <div class="table-responsive">
        <table class="table table-striped-columns table-responsive-sm table-hover" style="text-align: center">
            <thead class="table-dark">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">EMAIL</th>
                <th scope="col">NOMBRE</th>
                <th scope="col">STATUS</th>
                <th scope="col">PREGUNTA</th>
                <th scope="col">SOLUCION</th>
                <th scope="col">FECHA</th>
                <th scope="col">TIPO</th>
                <th scope="col">ENVIADO</th>
                <th scope="col">GERENTE<br>SOPORTE</th>
                <th scope="col">INGENIERO<br>SOPORTE</th>
                <th scope="col">EDITOR</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Reporte reporteRegistrado : reportesRegistrados) {
                    out.print(
                            "<tr>" +
                                    "<td>" + reporteRegistrado.getId() + "</td>" +
                                    "<td>" + reporteRegistrado.getEmailUsuario() + "</td>" +
                                    "<td>" + reporteRegistrado.getNombre() + "</td>" +
                                    "<td>" + reporteRegistrado.getStatus() + "</td>" +
                                    "<td>" + reporteRegistrado.getPregunta() + "</td>" +
                                    "<td>" + reporteRegistrado.getSolucion() + "</td>" +
                                    "<td>" + reporteRegistrado.getFechaReporte() + "</td>" +
                                    "<td>" + reporteRegistrado.getTipo() + "</td>" +
                                    "<td>" + reporteRegistrado.getEnviado() + "</td>" +
                                    "<td>" +
                                    "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.ABIERTO) ? "block;" : "none;") + "'  class='botonAsignarIngeniero_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Asignar Ingeniero</button>" +
                                    "</td>" +
                                    "<td>" +
                                    "<button type='submit' style='display: " +
                                    (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.EN_PROCESO) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.SOPORTE) ? "block;" : "none;") +
                                    "'  class='botonResolverReporte_ingSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Resolver Reporte</button>" +

                                    "<button type='submit' style='display: " +
                                    (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.SOLUCIONADO) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.SOPORTE) ? "block;" : "none;") +
                                    "'  class='botonDevolverReporte_ingSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Devolver Reporte</button>" +
                                    "</td>" +
                                    "<td>" +
                                    "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.CERRADO) ? "block;" : "none;") + "'  class='botonAñadirComoFaqSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Publicar</button>" +
                                    "</td>" +
                                    "</tr>"
                    );
                }
            %>

            </tbody>
        </table>
    </div>
    <div id="divToasts">
        <div aria-live="polite" aria-atomic="true"
             class="d-flex justify-content-center align-items-center w-100">

            <div id="botonAsignarIngeniero_gerenteSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAsignarIngeniero_gerenteSoporteBodyToast">
                    <jsp:include page="AsignarIngenieroSoporte.jsp"/>
                </div>
            </div>

            <div id="botonResolverReporte_ingSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonResolverReporte_ingSoporteBodyToast">
                    <jsp:include page="ReportesAsignados.jsp"/>
                </div>
            </div>
            <div id="botonDevolverReporte_ingSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonDevolverReporte_ingSoporteBodyToast">
                    <jsp:include page="Solucionados.jsp"/>
                </div>
            </div>
            <div id="botonAñadirComoFaqSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAñadirComoFaqSoporteBodyToast">
                    <jsp:include page="/WEB-INF/view/dashboardForms/faqs/AñadirFaqDesdeReporte.jsp"/>
                </div>
            </div>
            <div id="botonAñadirReporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAñadirReporteBodyToast">
                    <jsp:include page="/WEB-INF/view/dashboardForms/asistente/AñadirReporte.jsp"/>
                </div>
            </div>
            <div id="botonAñadirFaqToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAñadirFaqBodyToast">
                    <jsp:include page="/WEB-INF/view/dashboardForms/asistente/AñadirReporte.jsp"/>
                </div>
            </div>
        </div>
        <script type="module">
            // Asignar Ingeniero
            const botonesAsignarIngeniero_gerenteSoporte = document.getElementsByClassName('botonAsignarIngeniero_gerenteSoporte');
            if (botonesAsignarIngeniero_gerenteSoporte) {
                const instanciaToastMostrar = document.getElementById('botonAsignarIngeniero_gerenteSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonesAsignarIngeniero_gerenteSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonAsignarIngeniero_gerenteSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/soporte/asignarIngenieroSoporte/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('actualizar sesion aqui con el reporte #' + evt.target.value);
                        })
                );
            }

            // Resolver Reporte
            const botonResolverReporte_ingSoporte = document.getElementsByClassName('botonResolverReporte_ingSoporte');
            if (botonResolverReporte_ingSoporte) {
                const instanciaToastMostrar = document.getElementById('botonResolverReporte_ingSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonResolverReporte_ingSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonResolverReporte_ingSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/soporte/resolverAsignado/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('actualizar sesion aqui con el reporte resolver #' + evt.target.value);
                        })
                );
            }

            // Devolver Reporte
            const botonDevolverReporte_ingSoporte = document.getElementsByClassName('botonDevolverReporte_ingSoporte');
            if (botonDevolverReporte_ingSoporte) {
                const instanciaToastMostrar = document.getElementById('botonDevolverReporte_ingSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonDevolverReporte_ingSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonDevolverReporte_ingSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/soporte/devolverSolucionado/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('actualizar sesion aqui con el reporte devolver #' + evt.target.value);
                        })
                );
            }
            // Publicar como Faq
            const botonAñadirComoFaqSoporte = document.getElementsByClassName('botonAñadirComoFaqSoporte');
            if (botonAñadirComoFaqSoporte) {
                const instanciaToastMostrar = document.getElementById('botonAñadirComoFaqSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonAñadirComoFaqSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonAñadirComoFaqSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/editor/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('actualizar sesion aqui con el reporte publicar #' + evt.target.value);
                        })
                );
            }
            // Nuevo Reporte
            const botonAñadirReporte = document.getElementsByClassName('botonAñadirReporte');
            if (botonAñadirReporte) {
                const instanciaToastMostrar = document.getElementById('botonAñadirReporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonAñadirReporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            toastMostrar.show()
                            console.log('añadir')
                        })
                );
            }

            // Nuevo Reporte
            const botonAñadirFaq = document.getElementsByClassName('botonAñadirFaq');
            if (botonAñadirFaq) {
                const instanciaToastMostrar = document.getElementById('botonAñadirFaqToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonAñadirFaq).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            toastMostrar.show()
                            console.log('añadir faq')
                        })
                );
            }

        </script>
    </div>

</div>
<%-------------------------------------------------------CONFIGURACION TOASTS--%>
