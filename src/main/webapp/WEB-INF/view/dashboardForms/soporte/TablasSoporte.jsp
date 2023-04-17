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
                <th scope="col" style="display: <%=(modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE))? "inherited;" : "none;"%>">GERENTE<br>SOPORTE</th>
                <th scope="col" style="display: <%=(modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE))? "inherited;" : "none;"%>">INGENIERO<br>SOPORTE</th>
                <th scope="col" style="display: <%=(modulos.contains(Usuario.TipoUsuario.EDITOR))? "inherited;" : "none;"%>">EDITOR</th>
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
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE))? "inherited;" : "none;") +"'>" +
                                        "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.ABIERTO) ? "block;" : "none;") + "'  class='botonAsignarIngeniero_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Asignar Ingeniero</button>" +
                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE))? "inherited;" : "none;") +"'>" +
                                        "<button type='submit' style='display: " +
                                        (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.EN_PROCESO) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.SOPORTE) ? "block;" : "none;") +
                                        "'  class='botonResolverReporte_ingSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Resolver Reporte</button>" +
    
                                        "<button type='submit' style='display: " +
                                        (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.SOLUCIONADO) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.SOPORTE) ? "block;" : "none;") +
                                        "'  class='botonDevolverReporte_ingSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Devolver Reporte</button>" +
                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE))? "inherited;" : "none;") +"'>" +
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
