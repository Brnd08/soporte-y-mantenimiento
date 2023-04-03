<%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<h2>Devolver Solucionados</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/registro-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- SELECT REPORTE A DEVOLVER ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="tipoReporte" id="reporteAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A RESOLVER</option>
                <option value="1">1 REPORTE NOMBRE PREGUNTA</option>
                <option value="2">2 REPORTE NOMBRE PREGUNTA</option>
            </select>
            <label for="reporteAsignado">Reporte Resolver</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir reporte</button>
    </form>
</div>