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


%>
<html lang="es" data-bs-theme="auto">
<head>

    <link rel="icon" href="../../images/bearbikesIcon.ico">
    <script src="../../bootstrap/color-modes.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>

    <link href="../../css/index.css" rel="stylesheet">

    <link href="../../bootstrap/bootstrap.min.css" rel="stylesheet">

    <link href="../../css/dashboard.css" rel="stylesheet">
    <style>
        hr#seccion-hr {
            background-color: #70add9;
            height: .8em;
        }
    </style>
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
            <a href="/login" class="btn btn-outline-primary me-2">Login</a>
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

        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Hola <%=usuarioSesion.getTipoUsuario().toString().replace("_", " ")%> <%=usuarioSesion.getNombre()%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

        </div>


        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4"
              id="moduloAsistente" <% if (!modulos.contains(Usuario.TipoUsuario.ASISTENTE)) { %>
              style="display: none;" <% } %>>

            <hr id="seccion-hr">
            <h1>ASISTENTE</h1>
            <hr id="seccion-hr">
            <%-- ----------------------------------ASISTENTE MOSTRAR REPORTES----------------------------------------------------%>
            <div id="seccion_mostrar_registros">
                <jsp:include page="dashboardForms/asistente/MostrarRegistros.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------ASISTENTE NUEVO REPORTE----------------------------------------------------%>
            <div id="seccion-nuevo-reporte-soporte">
                <jsp:include page="dashboardForms/asistente/AñadirReporte.jsp"/>
                <br>
                <br>
            </div>
        </main>


        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloSoporte">

            <hr id="seccion-hr">
            <h1>SOPORTE</h1>
            <hr id="seccion-hr">
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
            <br>
            <br>
        </main>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloMantenimiento">

            <hr id="seccion-hr">
            <h1>MATENIMIENTO</h1>
            <hr id="seccion-hr">
            <%-- ----------------------------------FORMULARIO ASIGNAR GERENTE MANTENIMIENTO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-gerente" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/mantenimiento/AsignarGerenteMantenimiento.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO ASIGNAR INGENIERO MANTENIMIENTO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-ingeniero" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/mantenimiento/AsignarIngenieroMantenimiento.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO SOLUCION REPORTE MANTENIMIENTO ----------------------------------------------------%>
            <div id="seccion-resolver-reporte-mantenimiento-asignado" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO INFORMAR REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-informar-reporte-mantenimiento-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO ASIGNAR REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-asignar-reporte-mantenimiento-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMUALRIO DEVOLVER REPORTE MANTENIMIENTO SOLUCIONADO----------------------------------------------------%>
            <div id="seccion-devolver-reporte-mantenimiento-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <br>
        </main>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloFaqs">
            <hr id="seccion-hr">
            <h1>FAQs</h1>
            <hr id="seccion-hr">
            <%-- ----------------------------------DESPLEGAR FAQs REGISTRADAS----------------------------------------------------%>
            <div id="seccion_mostrar_faqs" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/faqs/MostrarFaqs.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO AÑADIR FAQ----------------------------------------------------%>
            <div id="seccion-añadir_faq" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>
                 style="display: none;" <% } %> >
                <jsp:include page="dashboardForms/faqs/AñadirFaq.jsp"/>
                <br>
                <hr>
                <br>
            </div>

            <%-- ----------------------------------FORMUALRIO AÑADIR FAQ desde reporte cerrado ----------------------------------------------------%>
            <div id="seccion-añadir_faq_reporte" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>
                 style="display: none;" <% } %>>
                <jsp:include page="dashboardForms/faqs/AñadirFaqDesdeReporte.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <br>
        </main>


    </div>
</div>


<script src="../../bootstrap/bootstrap.bundle.min.js"></script>


<%--<script src="../../js/dashboard.js"></script>--%>
</body>
</html>