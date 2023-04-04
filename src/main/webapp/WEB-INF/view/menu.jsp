<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%@ page import="static com.bearbikes.maintenance_support.modelo.usuarios.Usuario.*" %>
<%@ page import="java.util.List" %>
<%
    List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");
    System.out.println("modulos menu => " + modulos);
%>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-body-tertiary sidebar collapse"
     style="width: fit-content; top: 0px;">
    <div class="position-sticky pt-3 sidebar-sticky">
        <%-- --------------------------------------------------------MENU ASISTENTE------------------------------%>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
            <span>ASISTENTE</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.ASISTENTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion_mostrar_registros">
                    <span data-feather="file-plus" style="height:20px; width:36px;"class="align-text-bottom text-info"></span>
                    Mostrar Reportes
                </a>
            </li>
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.ASISTENTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion-nuevo-reporte-soporte">
                    <span data-feather="file-plus" style="height:20px; width:36px;"class="align-text-bottom text-info"></span>
                    Añadir Reporte
                </a>
            </li>
        </ul>
        <%-- ----------------------------------MENU SOPORTE----------------------------------------------------%>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
            <span>SOPORTE DE SOFTWARE</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item"<% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion-asignar-reporte-soporte">
                    <span data-feather="user-check" style="height:20px; width:36px;"class="align-text-bottom text-danger"></span>
                    Asignar Ingeniebrio
                </a>
            </li>
            <li class="nav-item" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion-solucionar-reporte-soporte">
                    <span data-feather="file-text"style="height:20px; width:36px;"class="align-text-bottom text-danger"></span>
                    Reportes Asignados
                </a>
            </li>
            <li class="nav-item" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion-devolver-reporte-soporte">
                    <span data-feather="send" style="height:20px; width:36px;"class="align-text-bottom text-danger"></span>
                    Enviar de vuelta
                </a>
            </li>
        </ul>


        <%-- --------------------------------------------------------MENU MANTENIMIENTO------------------------------%>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
            <span>MANTENIMIENTO <br>DE SOFTWARE</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.GERENTE_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#seccion-asignar-reporte-mantenimiento-gerente">
                    <span data-feather="user-check"style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Asignar Gerente<br> Mantenimiento
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"<% if (!modulos.contains(TipoUsuario.GERENTE_MANTENIMIENTO)) { %>
                   style="display: none;" <% } %>>
                    <span data-feather="user-check" style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Asignar Ingeniero<br> Mantenimiento
                </a>
            </li>
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.INGENIERO_MANTENIMIENTO)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#">
                    <span data-feather="file-text" style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Reportes Asignados
                </a>
            </li>
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.GERENTE_MANTENIMIENTO)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#">
                    <span data-feather="check-square" style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Mantenimientos<br> Programados
                </a>
            </li>
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.GERENTE_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#">
                    <span data-feather="check-square" style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Mantenimientos<br> Implementados
                </a>
            </li>
            <li class="nav-item"<% if (!modulos.contains(TipoUsuario.INGENIERO_SOPORTE)) { %>
                style="display: none;" <% } %>>
                <a class="nav-link" href="#">
                    <span data-feather="send" style="height:20px; width:36px;"class="align-text-bottom text-secondary"></span>
                    Enviar de vuelta
                </a>
            </li>
        </ul>
        <%--             ------------------------------------------MENU EDITOR  ---------------------------------------------------%>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
            <span>SECCION FAQ's</span>
            <%--                    <a class="link-secondary" href="#" aria-label="Add a new report">--%>
            <%--                        <span data-feather="plus-circle" class="align-text-bottom"></span>--%>
            <%--                    </a>--%>
        </h6>
        <ul class="nav flex-column mb-2" <% if (!modulos.contains(Usuario.TipoUsuario.EDITOR)) { %>
            style="display: none;" <% } %>>
            <li class="nav-item">
                <a class="nav-link" href="#seccion_mostrar_faqs">
                    <span data-feather="user-check"style="height:20px; width:36px;"class="align-text-bottom text-success"></span>
                    Mostrar FAQ's
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#seccion-añadir_faq">
                    <span data-feather="file-plus" style="height:20px; width:36px;"class="align-text-bottom text-success"></span>
                    Añadir FAQ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#seccion-añadir_faq_reporte">
                    <span data-feather="user-check" style="height:20px; width:36px;"class="align-text-bottom text-success"></span>
                    Nueva FAQ desde <br>reporte
                </a>
            </li>

        </ul>
    </div>
    <script src="../../js/feather.min.js"></script>
    <script>
        feather.replace()
    </script>
</nav>