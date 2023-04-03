<%-- ---------------------------------- FORMULARIO ASIGNAR INGENIEBRIO----------------------------------------------------%>
<h2>Asignar a ingeniero Mantenimiento</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/asignar-ingenierio-soporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX AUTOASIGNAR----------------------------------------------------%>
        <div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="autoAsignarseIngenieroMantenimiento" checked>
                <label class="form-check-label" for="autoAsignarseIngenieroMantenimiento">Autoasignarse Reporte</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="asignarOtroMantenimientoIngenieroMantenimiento">
                <label class="form-check-label" for="asignarOtroMantenimientoIngenieroMantenimiento">Asignar a otro usuario</label>
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX USUARIO A ASIGNAR ----------------------------------------------------%>

        <div id="divUsuarioAsignarIngenieroMantenimiento" class="form-floating mb-3" style="display: none">
            <select name="ingenieroAsignado" id="usuarioAsignadoMantenimiento" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL INGENIERO DE MANTENIMIENTO A ASIGNAR</option>
                <option value="1">1 USUARIO INGENIERO</option>
                <option value="2">2 USUARIO INGENIERO</option>
            </select>
            <label for="usuarioAsignadoMantenimiento">Usuario asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX REPORTE A ASIGNAR ----------------------------------------------------%>

        <div class="form-floating mb-3">
            <select name="tipoReporte" id="reporteAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL REPORTE A ASIGNAR AL INGENIERO</option>
                <option value="1">1 REPORTE NOMBRE PREGUNTA</option>
                <option value="2">2 REPORTE NOMBRE PREGUNTA</option>
            </select>
            <label for="reporteAsignado">Reporte asignado</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>

            <script>
                const asignarOtroMantenimientoIngenieroMantenimiento = document.getElementById("asignarOtroMantenimientoIngenieroMantenimiento");
                const autoAsignarseIngenieroMantenimiento = document.getElementById("autoAsignarseIngenieroMantenimiento");
                const divUsuarioAsignarIngenieroMantenimiento = document.getElementById("divUsuarioAsignarIngenieroMantenimiento");
                const usuarioAsignado = document.getElementById("usuarioAsignadoMantenimiento");

                asignarOtroMantenimientoIngenieroMantenimiento.addEventListener("change", ev => {
                    divUsuarioAsignarIngenieroMantenimiento.style.display = 'inherit'
                    usuarioAsignado.disabled = false;
                })
                autoAsignarseIngenieroMantenimiento.addEventListener("change", ev => {
                    divUsuarioAsignarIngenieroMantenimiento.style.display = 'none'
                    usuarioAsignado.disabled = true;
                })
            </script>

        <%-- ---------------------------------- SCRIPT OCULTAR CHECKBOX ----------------------------------------------------%>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir reporte</button>

    </form>
</div>
