<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
    Object sesionActiva = request.getAttribute("sesion activa");
    if (sesionActiva != null)
        if (!(boolean) sesionActiva) {
            response.sendRedirect("/login");
        }


    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario sesión");
    System.out.println("usuario Dashboard =>" + usuarioSesion);

    List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");
    System.out.println("modulos Dashboard => " + modulos);

    String mensajeError = (String) request.getAttribute("Mensaje de Error");

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

%>
<html lang="es" data-bs-theme="auto">
<head>
    <script src="../../bootstrap/color-modes.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>

    <link href="../../css/index.css" rel="stylesheet">

    <link href="../../bootstrap/bootstrap.min.css" rel="stylesheet">

    <link href="../../css/dashboard.css" rel="stylesheet">
</head>
<body>
<jsp:include page="darkmode.jsp"/>

<header class="navbar navbar-light sticky-top bg-light flex-md-nowrap p-0 shadow">

    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-nav">
        <div class="nav-item text-nowrap">
        </div>
    </div>
</header>
<div class="container">
    <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
        <div class="col-md-3 mb-2 mb-md-0">
            <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
                <img src="../../images/bearbikesLogo.jpg" alt="logo">
            </a>
        </div>
        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
            <li><a href="/" class="nav-link px-2 link-secondary">Home</a></li>
            <li><a href="#" class="nav-link px-2">Features</a></li>
            <li><a href="/FAQs" class="nav-link px-2">FAQs</a></li>
            <li><a href="/#about" class="nav-link px-2">About</a></li>
        </ul>
        <div class="col-md-3 text-end">
            <button type="button" class="btn btn-outline-primary me-2">Login</button>
        </div>
    </header>
</div>

<div class="container-fluid">
    <div class="row">
        <%-- ----------------------------------MENU NAVEGACION----------------------------------------------------%>
        <div id="navbar">
            <br><br>
            <jsp:include page="menu.jsp"/>
        </div>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloSoporte">
            <%-- ----------------------------------FORMULARIO NUEVO REPORTE----------------------------------------------------%>
            <div id="seccion-nuevo-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.ASISTENTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/AñadirReporte.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO ASIGNAR REPORTE----------------------------------------------------%>
            <div id="seccion-asignar-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/AsignarIngenieroSoporte.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO SOLUCION REPORTE----------------------------------------------------%>
            <div id="seccion-solucionar-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/ReportesAsignados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------DEVOLVER SOLUCION REPORTE----------------------------------------------------%>
            <div id="seccion-devolver-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
            </div>

        </main>
        <br>
        <hr style="background-color: red; height: 1em">
        <br>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloMantenimiento">
            <%-- ----------------------------------FORMULARIO ASIGNAR GERENTE MANTENIMIENTO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-gerente" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/mantenimiento/AsignarGerenteMantenimiento.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO ASIGNAR INGENIERO MANTENIMIENTO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-ingeniero">
                <jsp:include page="dashboardForms/mantenimiento/AsignarIngenieroMantenimiento.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO SOLUCION REPORTE MANTENIMIENTO ----------------------------------------------------%>
            <div id="seccion-resolver-reporte-mantenimiento-asignado">
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO INFORMAR REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-informar-reporte-mantenimiento-solucionado">
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO ASIGNAR REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-solucionado">
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO DEVOLVER REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-devolver-reporte-mantenimiento-solucionado">
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <br>
        </main>


        <%--            <div class="table-responsive">--%>
        <%--                <table class="table table-striped table-sm">--%>
        <%--                    <thead>--%>
        <%--                    <tr>--%>
        <%--                        <th scope="col">#</th>--%>
        <%--                        <th scope="col">Header</th>--%>
        <%--                        <th scope="col">Header</th>--%>
        <%--                        <th scope="col">Header</th>--%>
        <%--                        <th scope="col">Header</th>--%>
        <%--                    </tr>--%>
        <%--                    </thead>--%>
        <%--                    <tbody>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,001</td>--%>
        <%--                        <td>random</td>--%>
        <%--                        <td>data</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>text</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,002</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>irrelevant</td>--%>
        <%--                        <td>visual</td>--%>
        <%--                        <td>layout</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,003</td>--%>
        <%--                        <td>data</td>--%>
        <%--                        <td>rich</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>tabular</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,003</td>--%>
        <%--                        <td>information</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>illustrative</td>--%>
        <%--                        <td>data</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,004</td>--%>
        <%--                        <td>text</td>--%>
        <%--                        <td>random</td>--%>
        <%--                        <td>layout</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,005</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>irrelevant</td>--%>
        <%--                        <td>text</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,006</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>illustrative</td>--%>
        <%--                        <td>rich</td>--%>
        <%--                        <td>data</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,007</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>tabular</td>--%>
        <%--                        <td>information</td>--%>
        <%--                        <td>irrelevant</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,008</td>--%>
        <%--                        <td>random</td>--%>
        <%--                        <td>data</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>text</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,009</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>irrelevant</td>--%>
        <%--                        <td>visual</td>--%>
        <%--                        <td>layout</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,010</td>--%>
        <%--                        <td>data</td>--%>
        <%--                        <td>rich</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>tabular</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,011</td>--%>
        <%--                        <td>information</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>illustrative</td>--%>
        <%--                        <td>data</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,012</td>--%>
        <%--                        <td>text</td>--%>
        <%--                        <td>placeholder</td>--%>
        <%--                        <td>layout</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,013</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>irrelevant</td>--%>
        <%--                        <td>text</td>--%>
        <%--                        <td>visual</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,014</td>--%>
        <%--                        <td>dashboard</td>--%>
        <%--                        <td>illustrative</td>--%>
        <%--                        <td>rich</td>--%>
        <%--                        <td>data</td>--%>
        <%--                    </tr>--%>
        <%--                    <tr>--%>
        <%--                        <td>1,015</td>--%>
        <%--                        <td>random</td>--%>
        <%--                        <td>tabular</td>--%>
        <%--                        <td>information</td>--%>
        <%--                        <td>text</td>--%>
        <%--                    </tr>--%>
        <%--                    </tbody>--%>
        <%--                </table>--%>
        <%--            </div>--%>

    </div>
</div>


<script src="../../bootstrap/bootstrap.bundle.min.js"></script>

<script src="../../js/feather.min.js"
        integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE"
        crossorigin="anonymous"></script>
<script src="../../js/dashboard.js"></script>
</body>
</html>
