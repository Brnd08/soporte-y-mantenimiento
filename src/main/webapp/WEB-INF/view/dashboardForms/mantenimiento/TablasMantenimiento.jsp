<%@ page import="com.bearbikes.maintenance_support.modelo.Reporte" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%
    List<Reporte> reportesRegistrados = (List<Reporte>) session.getAttribute("reportes-registrados");
    System.out.println("reportes registrados => " + reportesRegistrados);

    String errorRegistro = (String) session.getAttribute("errorRegistro");
    System.out.println(errorRegistro);

    String exitoRegistro = (String) session.getAttribute("exitoRegistro");
    System.out.println(exitoRegistro);

    List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");
%>
<h2>Tabla Mantenimiento</h2>
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
                <th scope="col" style="display: <%=(modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO))? "inherited;" : "none;"%>">GERENTE<br>MANTENIMIENTO</th>
                <th scope="col" style="display: <%=(modulos.contains(Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO))? "inherited;" : "none;"%>">INGENIERO<br>MANTENIMIENTO</th>
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
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE))? "inherited;" : "none;") +"'>" + // GERENTE SOPORTE
                                        "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.ABIERTO) ? "block;" : "none;") + "'  class='botonAsignarGerente_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Asignar Gerente</button>" +
                                        "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.IMPLEMENTADO_MANTENIMIENTO) ? "block;" : "none;") + "'  class='botonAsignarImplementado_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Asignar Reporte Implementado</button>" +
                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO))? "inherited;" : "none;") + "'>" + //GERENTE MANTENIMIENTO
                                        "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.EN_PROCESO) ? "block;" : "none;") + "'  class='botonAsignarIngenieroMantenimiento_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Asignar Ingeniero Mantenimiento</button>" +
                                        "<button type='submit' style='display: " + (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.PROGRAMADO) ? "block;" : "none;") + "'  class='botonInformarIngeniero_gerenteSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Reportar Programado</button>" +
                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO))? "inherited;" : "none;") +"'>" + // INGENIERO MANTENIMIENTO
                                        "<button type='submit' style='display: " +
                                        (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.EN_PROGRAMACIÓN) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.MANTENIMIENTO) ? "block;" : "none;") +
                                        "'  class='botonResolverReporte_ingMantenimiento w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Resolver Reporte</button>" +

                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE))? "inherited;" : "none;") +"'>" + // INGENIERO SOPORTE
                                        "<button type='submit' style='display: " +
                                        (reporteRegistrado.getStatus().equals(Reporte.StatusReporte.VERIFICADO) && reporteRegistrado.getTipo().equals(Reporte.TipoReporte.MANTENIMIENTO) ? "block;" : "none;") +
                                        "'  class='botonDevolverReporteMantenimiento_ingSoporte w-100 btn btn-lg btn-primary' value ='" + reporteRegistrado.getId() + "'>Devolver Reporte</button>" +
                                    "</td>" +
                                    "<td style = 'display: "+ ((modulos.contains(Usuario.TipoUsuario.EDITOR))? "inherited;" : "none;") +"'>" +
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

            <div id="botonAsignarGerente_gerenteSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAsignarGerente_gerenteSoporteBodyToast">
                    <jsp:include page="AsignarGerenteMantenimiento.jsp"/>
                </div>
            </div>

            <div id="botonAsignarIngenieroMantenimiento_gerenteSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAsignarIngenieroMantenimiento_gerenteSoporteBodyToast">
                    <jsp:include page="AsignarIngenieroMantenimiento.jsp"/>
                </div>
            </div>

            <div id="botonResolverReporte_ingMantenimientoToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonResolverReporte_ingMantenimientoBodyToast">
                    <jsp:include page="ReportesAsignados.jsp"/>
                </div>
            </div>
            <div id="botonInformarIngeniero_gerenteSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonInformarIngeniero_gerenteSoporteBodyToast">
                    <jsp:include page="InformarGerenteSoporteSolucionados.jsp"/>
                </div>
            </div>
            <div id="botonAsignarImplementado_gerenteSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonAsignarImplementado_gerenteSoporteBodyToast">
                    <jsp:include page="AsignarImplementado.jsp"/>
                </div>
            </div>
            <div id="botonDevolverReporteMantenimiento_ingSoporteToast" class="toast" role="alert" aria-live="assertive"
                 aria-atomic="true" data-bs-autohide="false" style="width: 80%;">
                <div class="toast-header">
                    <strong class="me-auto"></strong><small></small> <%-- necesarias para mostrar el boton de cerrar en la posición correct --%>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="botonDevolverReporteMantenimiento_ingSoporteBodyToast">
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
            // Asignar Gerente Soporte
            const botonesAsignarIngeniero_gerenteSoporte = document.getElementsByClassName('botonAsignarGerente_gerenteSoporte');
            if (botonesAsignarIngeniero_gerenteSoporte) {
                const instanciaToastMostrar = document.getElementById('botonAsignarGerente_gerenteSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonesAsignarIngeniero_gerenteSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonAsignarGerente_gerenteSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/asignarGerenteMantenimiento/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('asignarGerenteMantenimiento con el reporte #' + evt.target.value);
                        })
                );
            }

            // Asignar Ingeniero mantenimiento
            const botonAsignarIngenieroMantenimiento_gerenteSoporte = document.getElementsByClassName('botonAsignarIngenieroMantenimiento_gerenteSoporte');
            if (botonAsignarIngenieroMantenimiento_gerenteSoporte) {
                const instanciaToastMostrar = document.getElementById('botonAsignarIngenieroMantenimiento_gerenteSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonAsignarIngenieroMantenimiento_gerenteSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonAsignarIngenieroMantenimiento_gerenteSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/asignarIngenieroMantenimiento/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('asignar Ing manteniemiento con el reporte #' + evt.target.value);
                        })
                );
            }

            // Resolver Reporte
            const botonResolverReporte_ingMantenimiento = document.getElementsByClassName('botonResolverReporte_ingMantenimiento');
            if (botonResolverReporte_ingMantenimiento) {
                const instanciaToastMostrar = document.getElementById('botonResolverReporte_ingMantenimientoToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonResolverReporte_ingMantenimiento).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonResolverReporte_ingMantenimientoBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/resolverReporte/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log(' resolver #' + evt.target.value);
                        })
                );
            }

            // Informar Programado
            const botonInformarIngeniero_gerenteSoporte = document.getElementsByClassName('botonInformarIngeniero_gerenteSoporte');
            if (botonInformarIngeniero_gerenteSoporte) {
                const instanciaToastMostrar = document.getElementById('botonInformarIngeniero_gerenteSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonInformarIngeniero_gerenteSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonInformarIngeniero_gerenteSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/informarProgramado/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log(' informarProgramado #' + evt.target.value);
                        })
                );
            }
            // verificar implementado
            const botonAsignarImplementado_gerenteSoporte = document.getElementsByClassName('botonAsignarImplementado_gerenteSoporte');
            if (botonAsignarImplementado_gerenteSoporte) {
                const instanciaToastMostrar = document.getElementById('botonAsignarImplementado_gerenteSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonAsignarImplementado_gerenteSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonAsignarImplementado_gerenteSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/asignarImplementado/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log(' asignarImplementado #' + evt.target.value);
                        })
                );
            }

            // Devolver Reporte
            const botonDevolverReporteMantenimiento_ingSoporte = document.getElementsByClassName('botonDevolverReporteMantenimiento_ingSoporte');
            if (botonDevolverReporteMantenimiento_ingSoporte) {
                const instanciaToastMostrar = document.getElementById('botonDevolverReporteMantenimiento_ingSoporteToast');
                const toastMostrar = bootstrap.Toast.getOrCreateInstance(instanciaToastMostrar);
                Array.from(botonDevolverReporteMantenimiento_ingSoporte).forEach( // usar array from ya que las constante no es un iterable o lista en si
                    botonAsignarIngeniero =>
                        botonAsignarIngeniero.addEventListener('click', evt => {
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    var formularioAsignar = document.getElementById("botonDevolverReporteMantenimiento_ingSoporteBodyToast");
                                    formularioAsignar.innerHTML = this.responseText;
                                    toastMostrar.show();
                                }
                            };
                            xmlhttp.open("GET", "/mantenimiento/devolverImplementado/" + evt.target.value, true);
                            xmlhttp.send();
                            console.log('devolverImplementado con el reporte devolver #' + evt.target.value);
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
