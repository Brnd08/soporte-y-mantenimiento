<%-- ---------------------------------- FORMULARIO ASIGNAR INGENIEBRIO----------------------------------------------------%>
<h2>Asignar a Gerente Mantenimiento</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/asignar-ingenierio-matenimiento"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX AUTOASIGNAR----------------------------------------------------%>
        <div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gerenteMantenimientoAsignado" id="autoAsignarseGerenteMantenimeinto" checked>
                <label class="form-check-label" for="autoAsignarseGerenteMantenimeinto">Autoasignarse Reporte</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gerenteMantenimientoAsignado" id="asignarGerenteMantenimiento">
                <label class="form-check-label" for="asignarGerenteMantenimiento">Asignar Gerente Mantenimiento</label>
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX USUARIO A ASIGNAR ----------------------------------------------------%>

        <div id="divGerenteMantenimientoAsignar" class="form-floating mb-3" style="display: none">
            <select name="tipoReporte" id="gerenteAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL USUARIO A ASIGNAR</option>
                <option value="1">1 USARIO GERENTE</option>
                <option value="2">2 USARIO GERENTE</option>
            </select>
            <label for="gerenteAsignado">Usuario asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX REPORTE A ASIGNAR ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="tipoReporte" id="reporteAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A ASIGNAR</option>
                <option value="1">1 REPORTE NOMBRE PREGUNTA</option>
                <option value="2">2 REPORTE NOMBRE PREGUNTA</option>
            </select>
            <label for="reporteAsignado">Reporte asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>

            <script>
                const asignarGerenteMantenimiento = document.getElementById("asignarGerenteMantenimiento");
                const autoAsignarseGerenteMantenimeinto = document.getElementById("autoAsignarseGerenteMantenimeinto");
                const divGerenteMantenimientoAsignar = document.getElementById("divGerenteMantenimientoAsignar");
                const gerenteMantenimientoAsignado = document.getElementById("gerenteMantenimientoAsignado");

                asignarGerenteMantenimiento.addEventListener("change", ev => {
                    console.log("mostrar");
                    divGerenteMantenimientoAsignar.style.display = 'inherit';
                    gerenteMantenimientoAsignado.disabled = false;
                })
                autoAsignarseGerenteMantenimeinto.addEventListener("change", ev => {
                    console.log("no mostrar");
                    divGerenteMantenimientoAsignar.style.display = 'none';
                    gerenteMantenimientoAsignado.disabled = true;
                })
            </script>

        <%-- ---------------------------------- SCRIPT OCULTAR CHECKBOX ----------------------------------------------------%>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Asignar Gerente Mantenimiento</button>

    </form>
</div>
