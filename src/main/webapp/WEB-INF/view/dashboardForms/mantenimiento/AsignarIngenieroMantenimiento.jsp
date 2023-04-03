<%-- ---------------------------------- FORMULARIO ASIGNAR INGENIEBRIO----------------------------------------------------%>
<h2>Asignar a ingeniero soporte</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/asignar-ingenierio-soporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%-- ---------------------------------- CHECKBOX AUTOASIGNAR----------------------------------------------------%>
        <div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="autoAsignarse" checked>
                <label class="form-check-label" for="autoAsignarse">Autoasignarse Reporte</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="usuarioAsignado" id="asignarOtro">
                <label class="form-check-label" for="asignarOtro">Asignar a otro usuario</label>
            </div>
        </div>
        <%-- ---------------------------------- CHECKBOX USUARIO A ASIGNAR ----------------------------------------------------%>

        <div id="divUsuarioAsignar" class="form-floating mb-3" style="display: none">
            <select name="tipoReporte" id="usuarioAsignado" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL USUARIO A ASIGNAR</option>
                <option value="1">1 USUARIO INGENIERO</option>
                <option value="2">2 USUARIO INGENIERO</option>
            </select>
            <label for="usuarioAsignado">Usuario asignado</label>
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
                const checkboxAsignarOtro = document.getElementById("asignarOtro");
                const checkboxAutoAsignar = document.getElementById("autoAsignarse");
                const divUsuarioAsignar = document.getElementById("divUsuarioAsignar");
                const usuarioAsignado = document.getElementById("usuarioAsignado");

                checkboxAsignarOtro.addEventListener("change", ev => {
                    divUsuarioAsignar.style.display = 'inherit'
                    usuarioAsignado.disabled = false;
                })
                checkboxAutoAsignar.addEventListener("change", ev => {
                    divUsuarioAsignar.style.display = 'none'
                    usuarioAsignado.disabled = true;
                })
            </script>

        <%-- ---------------------------------- SCRIPT OCULTAR CHECKBOX ----------------------------------------------------%>

        <button class="w-100 btn btn-lg btn-primary" type="submit">Añadir reporte</button>

    </form>
</div>
