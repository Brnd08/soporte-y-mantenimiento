<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%

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
            <li><a href="#" class="nav-link px-2">Features</a></li>
            <li><a href="/FAQs" class="nav-link px-2">FAQs</a></li>
            <li><a href="/#about" class="nav-link px-2">About</a></li>
        </ul>
        <div class="col-md-3 text-end">
            <button type="button" class="btn btn-outline-primary me-2">Login</button>
        </div>
    </header>
</div>

<div class="container col-xl-10 col-xxl-8 px-4 py-5">
    <div class="row align-items-center g-lg-5 py-5">
        <div class="col-lg-7 text-center text-lg-start">
            <h1 class="display-4 fw-bold lh-1 text-body-emphasis mb-3">Inicia Sesión en tu Cuenta</h1>
            <p class="col-lg-10 fs-4">Debemos verificar tu sesión antes de continuar. Usa las credenciales que te fueron
                anteriormente proporcionadas</p>
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
                <c:if test="${resultados}">
                    <div>Este elemento HTML se mostrará si miVariable está presente en el modelo</div>
                </c:if>
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
