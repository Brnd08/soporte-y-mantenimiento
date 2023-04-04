<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
    Object sesionActiva = request.getAttribute("sesion activa");
    if (sesionActiva != null)
        if((boolean)sesionActiva)
            response.sendRedirect("/dashboard");
        else{
            response.sendRedirect("/login");
        }

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
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../../bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/index.css" rel="stylesheet">
    <title>Title</title>
</head>
<body>
<div class="container">
    <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
        <div class="col-md-3 mb-2 mb-md-0">
            <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
                <img src="../../images/bearbikesLogo.jpg" alt="logo bearbikes">
            </a>
        </div>
        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
            <li><a href="/" class="nav-link px-2 link-secondary">Home</a></li>
            <li><a href="/dashboard#" class="nav-link px-2">Dashboard</a></li>
            <li><a href="/faqs" class="nav-link px-2">FAQs</a></li>
            <li><a href="/#about" class="nav-link px-2">About</a></li>
        </ul>
        <div class="col-md-3 text-end">
            <button type="button" class="btn btn-outline-primary me-2">Login</button>
        </div>
    </header>
</div>

<div class="container col-xl-10 col-xxl-8 px-4 py-5" style="padding-top: .8rem!important;">
    <div class="row align-items-center g-lg-5 py-5">
        <div class="col-lg-7 text-center text-lg-start">
            <h1 class="display-4 fw-bold lh-1 text-body-emphasis mb-3">Inicia Sesión en tu Cuenta</h1>
            <p class="col-lg-10 fs-4">Debemos verificar tu sesión antes de continuar. Usa las credenciales que te fueron
                anteriormente proporcionadas</p>
            <%
                if (mensajeError != null) {
                    out.print(plantillaMensajeError.replace("$ContenidoMensaje", mensajeError));
                }
            %>
        </div>
        <div class="col-md-10 mx-auto col-lg-5">
            <form method="post" action="" class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="email" name="email" placeholder="nombre@ejemplo.com"
                           required maxlength="40">
                    <label for="email">Correo electronico</label>
                    <div class="invalid-feedback">
                        Proporciona tu email
                    </div>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña"
                           required maxlength="30">
                    <label for="password">Contraseña</label>
                    <div class="invalid-feedback">
                        Proporciona tu contraseña
                    </div>
                </div>
                <button class="w-100 btn btn-lg btn-primary" type="submit">Sign up</button>
                <hr class="my-4">
                <small class="text-body-secondary">By clicking Sign up, you agree to the terms of use.</small>
            </form>
        </div>
    </div>
</div>
<script src="../../bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
%>
