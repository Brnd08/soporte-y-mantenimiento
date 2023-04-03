
<h2>Añadir FAQ desde reporte cerrado</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/registro-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX USUARIO A ASIGNAR ----------------------------------------------------%>
        <div class="form-floating mb-3">
            <select name="tipoReporte" id="reporteCerrado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE PARA PUBLICARLO</option>
                <option value="1">1 REPORTE NOMBRE PREGUNTA SOLUCION</option>
                <option value="2">2 REPORTE NOMBRE PREGUNTA SOLUCION</option>
            </select>
            <label for="reporteCerrado">Reporte A publicar</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir FAQ</button>
    </form>
</div>