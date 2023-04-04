<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - Preguntas frecuentes</title>
    <!-- Enlace al archivo CSS de Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container">
    <div class="faq-header text-center">
        <h1>Preguntas Frecuentes</h1>
    </div>
    <div class="accordion" id="faqAccordion">
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
                <button class="accordion-button collapsed bg-primary text-white" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    Pregunta 1
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                 data-bs-parent="#faqAccordion">
                <div class="accordion-body bg-light">
                    Respuesta a la pregunta 1.
                </div>
            </div>
        </div>
        <!-- Agregar más preguntas y respuestas aquí -->
    </div>
</div>
<!-- Enlace al archivo JS de Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>