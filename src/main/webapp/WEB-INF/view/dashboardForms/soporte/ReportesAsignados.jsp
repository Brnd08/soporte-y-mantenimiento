<%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<h2>Resolver Asignado</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/registro-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX REPORTE A ASIGNAR ----------------------------------------------------%>

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
        <%--     ------------------------------------   RESPUESTA REPORTE --%>

        <div class="form-floating mb-3">
            <textarea id="pregunta" name="pregunta" class="form-control" id="exampleFormControlTextarea1"
                      rows="5" placeholder="No se muestran correctamente todos los campos en el formulario"
                      required maxlength="100"></textarea>
            <label for="pregunta">Pregunta/solicitud del usuario</label>
            <div class="invalid-feedback">
                Proporciona la pregunta/solcitud que indico el usuario
            </div>
        </div>
        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir reporte</button>
    </form>
</div>