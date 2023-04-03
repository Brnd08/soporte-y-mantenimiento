<%-- ---------------------------------- FORMULARIO AÑADIR REPORTE SOPORTE----------------------------------------------------%>
<h2>Añadir nuevo reporte</h2>
<div class="col-md-10 mx-auto col-lg-10">
    <form method="post" action="/registro-reporte"
          class="p-4 p-md-5 border rounded-3 bg-body-tertiary was-validated">
        <%--     ------------------------------------   EMAIL USUARIO --%>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="email" name="email"
                   placeholder="nombre@ejemplo.com"
                   required maxlength="40">
            <label for="email">Correo electronico del usuario</label>
            <div class="invalid-feedback">
                Proporciona un email valido para el usuario que creo el reporte
            </div>
        </div>
        <%--     ------------------------------------   NOMBRE REPORTE --%>

        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="nombre" name="nombre"
                   placeholder="Reporte formulario index"
                   required maxlength="30">
            <label for="nombre">Nombre del reporte</label>
            <div class="invalid-feedback">
                Porporciona un nombre para asignarlo al reporte
            </div>
        </div>
        <%--     ------------------------------------   TIPO REPORTE --%>

        <div class="form-floating mb-3">
            <select name="tipoReporte" id="tipoReporte" class="form-control"
                    placeholder="Reporte formulario index" required>
                <option disabled>SELECCIONA EL TIPO DE REPORTE</option>
                <option value="1">MANTENIMIENTO</option>
                <option value="2">SOPORTE</option>
            </select>
            <script>
                const select = document.getElementById('tipoReporte');
                select.addEventListener('change', function () {
                    if (this.value === '' || this.value === 'SELECCIONA EL TIPO DE REPORTE') {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
            </script>

            <label for="tipoReporte">Tipo de Reporte</label>
            <div class="invalid-feedback">
                Selecciona alguna de las opciones indicadas
            </div>
        </div>
        <%--     ------------------------------------   PREGUNTA REPORTE --%>

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