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

    boolean mostrarModuloAsistente = usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.ASISTENTE) ||
            usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.GERENTE_SOPORTE);
    boolean mostrarModuloSoporte =
            usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.GERENTE_SOPORTE) ||
                    usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.INGENIERO_SOPORTE);
    boolean mostrarModuloMantenimiento =
            usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.GERENTE_SOPORTE) ||
                    usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.INGENIERO_SOPORTE) ||
                    usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO) ||
                    usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO);
    boolean mostrarModuloEditor = usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.EDITOR) ||
            usuarioSesion.getTipoUsuario().equals(Usuario.TipoUsuario.GERENTE_SOPORTE);

    request.setAttribute("mostrarModuloAsistente", mostrarModuloAsistente);
    request.setAttribute("mostrarModuloSoporte", mostrarModuloSoporte);
    request.setAttribute("mostrarModuloMantenimiento", mostrarModuloMantenimiento);
    request.setAttribute("mostrarModuloEditor", mostrarModuloEditor);


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
            <li><a href="/dashboard" class="nav-link px-2">Dashboard</a></li>
            <li><a href="/faqs" class="nav-link px-2">FAQs</a></li>
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

        <%-- ----------------------------------ALERT BIENVENIDA----------------------------------------------------%>
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Hola <%=usuarioSesion.getTipoUsuario().toString().replace("_", " ")%> <%=usuarioSesion.getNombre()%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>


        <%-- ----------------------------------MODULO GENERAL----------------------------------------------------%>
<%--        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4"--%>
<%--              id="moduloGeneral">--%>
<%--            <hr>--%>
<%--            <h1>General</h1>--%>
<%--            <hr>--%>
<%--            &lt;%&ndash; ----------------------------------ASISTENTE MOSTRAR REPORTES--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion_mostrar_registros">--%>
<%--                <jsp:include page="dashboardForms/asistente/MostrarRegistros.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--        </main>--%>


        <%-- ----------------------------------MODULO ASISTENTE----------------------------------------------------%>
<%--        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4"--%>
<%--              id="moduloAsistente" <% if (!mostrarModuloAsistente) { %>--%>
<%--              style="display: none;" <% } %>>--%>
<%--            <hr>--%>
<%--            <h1>ASISTENTE</h1>--%>
<%--            <hr>--%>
<%--            &lt;%&ndash; ----------------------------------ASISTENTE NUEVO REPORTE--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-nuevo-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.ASISTENTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/asistente/AñadirReporte.jsp"/>--%>
<%--                <br>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--        </main>--%>

        <%-- ----------------------------------MODULO SOPORTE----------------------------------------------------%>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloSoporte" <% if (!mostrarModuloSoporte) { %>
              style="display: none;" <% } %>>
            <hr>
            <h1>SOPORTE</h1>
            <hr>
            <%-- ----------------------------------TABLA SOPORTE----------------------------------------------------%>
            <div id="seccion_tabla_soporte">
                <jsp:include page="dashboardForms/soporte/TablasSoporte.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO ASIGNAR REPORTE----------------------------------------------------%>
<%--            <div id="seccion-asignar-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/soporte/AsignarIngenieroSoporte.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMULARIO SOLUCION REPORTE--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-solucionar-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/soporte/ReportesAsignados.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------DEVOLVER SOLUCION REPORTE--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-devolver-reporte-soporte" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/soporte/Solucionados.jsp"/>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            <br>--%>
<%--            <br>--%>
        </main>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4"
              id="moduloMantenimiento" <% if (!mostrarModuloMantenimiento) { %>
              style="display: none;" <% } %>>
            <hr>
            <h1>MANTENIMIENTO</h1>
            <hr>
            <%-- ----------------------------------TABLA SOPORTE----------------------------------------------------%>
            <div id="seccion_tabla_mantenimiento">
                <jsp:include page="dashboardForms/mantenimiento/TablasMantenimiento.jsp"/>
                <br>
                <hr>
                <br>
            </div>
            <%-- ----------------------------------FORMULARIO ASIGNAR GERENTE MANTENIMIENTO----------------------------------------------------%>
<%--            <div id="seccion-asignar-reporte-mantenimiento-gerente" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/AsignarGerenteMantenimiento.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMULARIO ASIGNAR INGENIERO MANTENIMIENTO--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-asignar-reporte-mantenimiento-ingeniero" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/AsignarIngenieroMantenimiento.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMUALRIO SOLUCION REPORTE MANTENIMIENTO --------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-resolver-reporte-mantenimiento-asignado" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_MANTENIMIENTO)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/ReportesAsignados.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMUALRIO INFORMAR REPORTE MANTENIMIENTO SOLUCIONADO a GERENTE SOPORTE--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-informar-reporte-mantenimiento-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/InformarGerenteSoporteSolucionados.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMUALRIO DEVOLVER REPORTE MANTENIMIENTO SOLUCIONADO--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-asignar-ingeniero-soporte-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_MANTENIMIENTO)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/AsignarImplementado.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
<%--            &lt;%&ndash; ----------------------------------FORMUALRIO DEVOLVER REPORTE MANTENIMIENTO SOLUCIONADO--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-devolver-reporte-mantenimiento-solucionado" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/mantenimiento/Solucionados.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
            <br>
        </main>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4" id="moduloFaqs" <% if (!mostrarModuloEditor) { %>
              style="display: none;" <% } %>>
            <hr>
            <h1>FAQs</h1>
            <hr>
            <%-- ----------------------------------DESPLEGAR FAQs REGISTRADAS----------------------------------------------------%>
            <div id="seccion_tabla_mantenimiento" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>
                 style="display: none;" <% } %>>

                <jsp:include page="dashboardForms/faqs/MostrarFaqs.jsp"/>
                <br>
                <hr>
                <br>
            </div>
<%--            &lt;%&ndash; ----------------------------------FORMULARIO AÑADIR FAQ--------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-añadir_faq" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>--%>
<%--                 style="display: none;" <% } %> >--%>
<%--                <jsp:include page="dashboardForms/faqs/AñadirFaq.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>

<%--            &lt;%&ndash; ----------------------------------FORMUALRIO AÑADIR FAQ desde reporte cerrado --------------------------------------------------&ndash;%&gt;--%>
<%--            <div id="seccion-añadir_faq_reporte" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>--%>
<%--                 style="display: none;" <% } %>>--%>
<%--                <jsp:include page="dashboardForms/faqs/AñadirFaqDesdeReporte.jsp"/>--%>
<%--                <br>--%>
<%--                <hr>--%>
<%--                <br>--%>
<%--            </div>--%>
            <br>
        </main>


    </div>
</div>
<script src="../../bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
