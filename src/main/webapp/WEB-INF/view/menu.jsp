﻿
<%@ page import="com.bearbikes.maintenance_support.modelo.usuarios.Usuario" %>
<%@ page import="static com.bearbikes.maintenance_support.modelo.usuarios.Usuario.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %><%--navbar menu--%>
<%
  List<Usuario.TipoUsuario> modulos = (List<Usuario.TipoUsuario>) session.getAttribute("modulos disponibles");
  System.out.println("modulos menu => " + modulos);
%>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-body-tertiary sidebar collapse"
     style="width: fit-content; top: 0px;">
  <div class="position-sticky pt-3 sidebar-sticky">
    <%-- ----------------------------------MENU SOPORTE----------------------------------------------------%>
    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
      <span>SOPORTE DE SOFTWARE</span>
      <%--                    <a class="link-secondary" href="#" aria-label="Add a new report">--%>
      <%--                        <span data-feather="plus-circle" class="align-text-bottom"></span>--%>
      <%--                    </a>--%>
    </h6>
    <ul class="nav flex-column mb-2">
      <li class="nav-item" <% if(!modulos.contains(TipoUsuario.ASISTENTE)) { %> style="display: none;" <% } %>>
        <a class="nav-link" href="#seccion-nuevo-reporte-soporte">
          <span data-feather="file-plus" class="align-text-bottom"></span>
          Añadir Reporte
        </a>
      </li>
      <li class="nav-item"<% if (!modulos.contains(Usuario.TipoUsuario.GERENTE_SOPORTE)) { %> style="display: none;" <% } %>>
        <a class="nav-link" href="#seccion-asignar-reporte-soporte">
          <span data-feather="user-check" class="align-text-bottom"></span>
          Asignar Ingeniebrio
        </a>
      </li>
      <li class="nav-item" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %> style="display: none;" <% } %>>
        <a class="nav-link" href="#seccion-solucionar-reporte-soporte">
          <span data-feather="file-text" class="align-text-bottom"></span>
          Reportes Asignados
        </a>
      </li>
      <li class="nav-item" <% if (!modulos.contains(Usuario.TipoUsuario.INGENIERO_SOPORTE)) { %> style="display: none;" <% } %>>
        <a class="nav-link" href="#seccion-devolver-reporte-soporte">
          <span data-feather="send" class="align-text-bottom"></span>
          Enviar de vuelta
        </a>
      </li>
    </ul>
    <%-- --------------------------------------------------------MENU MANTENIMIENTO------------------------------%>
    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
      <span>MANTENIMIENTO <br>DE SOFTWARE</span>
      <%--                    <a class="link-secondary" href="#" aria-label="Add a new report">--%>
      <%--                        <span data-feather="plus-circle" class="align-text-bottom"></span>--%>
      <%--                    </a>--%>
    </h6>
    <ul class="nav flex-column mb-2">
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="file-plus" class="align-text-bottom"></span>
          Añadir Reporte
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="user-check" class="align-text-bottom"></span>
          Asignar Gerente<br> Mantenimiento
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="user-check" class="align-text-bottom"></span>
          Asignar Ingeniero<br> Mantenimiento
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="file-text" class="align-text-bottom"></span>
          Reportes Asignados
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="check-square" class="align-text-bottom"></span>
          Mantenimientos<br> Programados
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="check-square" class="align-text-bottom"></span>
          Mantenimientos<br> Implementados
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="send" class="align-text-bottom"></span>
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
    <ul class="nav flex-column mb-2">
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="file-plus" class="align-text-bottom"></span>
          Añadir FAQ
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="user-check" class="align-text-bottom"></span>
          Mostrar FAQ's
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <span data-feather="user-check" class="align-text-bottom"></span>
          Nueva FAQ desde <br>reporte
        </a>
      </li>

    </ul>
  </div>
</nav>