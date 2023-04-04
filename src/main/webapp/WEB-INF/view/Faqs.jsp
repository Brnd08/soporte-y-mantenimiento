<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bearbikes.maintenance_support.modelo.Faq" %>
<%
    List<Faq> faqsRegistradas = (List<Faq>) session.getAttribute("faqs-registradas");
    System.out.println("faqs Registradas => " + faqsRegistradas);

    String plantillaFaq =
            "<br><div class='accordion-item'><h2 class='accordion-header' id='heading$id'><button class='accordion-button collapsed bg-primary text-white' type='button'data-bs-toggle='collapse' data-bs-target='#collapse$id' aria-expanded='true' aria-controls='collapse$id'>$id.- $pregunta </button></h2><div id='collapse$id' class='accordion-collapse collapse' aria-labelledby='heading$id' data-bs-parent='#faqAccordion'> <div class='accordion-body bg-light'>$solucion</div></div></div>";
%>
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
            <li><a href="/#about" class="nav-link px-2">About</a></li>
        </ul>

        <div class="col-md-3 text-end">
            <a href="/login" class="btn btn-outline-primary me-2">Login</a>
        </div>
    </header>
</div>

<div class="container my-5">
    <div class="faq-header text-center">
        <h1>Preguntas Frecuentes</h1>
    </div>
    <div class="accordion" id="faqAccordion">

        <%
            for (Faq faqRegistrada : faqsRegistradas) {
                out.print(
                        plantillaFaq
                                .replace("$id", String.valueOf(faqRegistrada.getId()))
                                .replace("$pregunta", faqRegistrada.getPregunta())
                                .replace("$solucion", faqRegistrada.getSolucion())
                );
            }
        %>

        <!-- Agregar más preguntas y respuestas aquí -->
    </div>
</div>


<script src="../../bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
