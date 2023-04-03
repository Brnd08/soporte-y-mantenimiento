<%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<h2>Añadir nueva FAQ</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/registro-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%--     ------------------------------------   PREGUNTA  --%>
        <div class="form-floating mb-3">
            <textarea id="pregunta" name="pregunta" class="form-control"
                      rows="5" placeholder="No se muestran correctamente todos los campos en el formulario"
                      required maxlength="100"></textarea>
            <label for="pregunta">Pregunta/solicitud</label>
            <div class="invalid-feedback">
                Proporciona la pregunta/solcitud
            </div>
        </div>
        <%--     ------------------------------------   RESPUESTA --%>
        <div class="form-floating mb-3">
            <textarea id="respuesta" name="respuesta" class="form-control"
                      rows="5" placeholder="No se muestran correctamente todos los campos en el formulario"
                      required maxlength="100"></textarea>
            <label for="respuesta">Respuesta Pregunta</label>
            <div class="invalid-feedback">
                Proporciona la respuesta a la pregunta
            </div>
        </div>
        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir FAQ</button>
    </form>
</div>