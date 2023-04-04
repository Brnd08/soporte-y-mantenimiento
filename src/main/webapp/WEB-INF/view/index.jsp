<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../../bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/index.css" rel="stylesheet">
    <title>Inicio</title>
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
            <li><a href="/dashboard" class="nav-link px-2">Dashboard</a></li>
            <li><a href="/faqs" class="nav-link px-2">FAQs</a></li>
            <li><a href="#about" class="nav-link px-2">About</a></li>
        </ul>

        <div class="col-md-3 text-end">
            <a href="/login" class="btn btn-outline-primary me-2">Login</a>
        </div>
    </header>
</div>

<div id="about" class="container col-xxl-8 px-4 py-5">
    <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
        <div class="col-10 col-sm-8 col-lg-6">
            <img src="../../images/Soporte_y_mantenimiento.png" class="d-block mx-lg-auto img-fluid"
                 alt="Bootstrap Themes" width="700" height="500" loading="lazy">
        </div>
        <div class="col-lg-6">
            <h1 class="display-5 fw-bold text-body-emphasis lh-1 mb-3">Proyecto Soporte y Mantenimiento</h1>
            <p class="lead">Nuestro equipo
            <ul>
                <li><a href="https://github.com/AnetQuiroz" target="_blank">Anet</a></li>
                <li><a href="https://github.com/Mau439yt" target="_blank">Mau</a></li>
                <li><a href="https://github.com/Proximalbag3226" target="_blank">Luis</a></li>
                <li><a href="https://github.com/Brnd08" target="_blank">Brandon</a></li>
            </ul>
            </p>
            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                <a href="/login" class="btn btn-primary btn-lg px-4 me-md-2">Comencemos</a>
            </div>
        </div>
    </div>
</div>


<script src="../../bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
