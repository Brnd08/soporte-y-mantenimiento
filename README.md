# Modulo Soporte y Mantenimiento 

Herramienta de soporte y mantenimiento que sigue la norma ISO 14764 para el mantenimiento de software. Este proyecto fue desarrollado usando Spring Boot y JSP. Mysql como base de datos, se ejecuta en un servidor tomcat enbebido.

[Video de Funcionamiento en Youtube](https://www.youtube.com/watch?v=WlmY6EljMEs) 

  
## Lógica de funcionameinto resumida
![Logica Funcionamiento](https://raw.githubusercontent.com/Brnd08/soporte-y-mantenimiento/main/others/images/logica.png)

## Capturas
![startPagePNG](https://github.com/Brnd08/soporte-y-mantenimiento/assets/93061195/c120507f-5ccb-4b15-9aa9-5ccfd07877af)
![dashboard4](https://github.com/Brnd08/soporte-y-mantenimiento/assets/93061195/ae2835b9-123d-4831-9592-5e02521988c9)
![dashboard3](https://github.com/Brnd08/soporte-y-mantenimiento/assets/93061195/e46c199f-98fb-45d6-acb1-8df2937de558)
![dashboard2](https://github.com/Brnd08/soporte-y-mantenimiento/assets/93061195/c839ca35-7b93-43e2-99b3-3a57aa1241b4)
![dashboard1](https://github.com/Brnd08/soporte-y-mantenimiento/assets/93061195/8a1f2018-29cc-4b4e-a232-28d1050b730f)

## Ejecución
Para hacerlo funcionar en tu equipo necesitarás:
- Java 19
- Mysql (ya configurado y ejecutandose en el puerto 3308, si quieres puedes cambiar el puerto usando modificando el codigo fuente)
- Mvn (puedes usar el wrapper del proyecto si no tienes instalación local)
- Navegador web
Pasos:
1. Ejecuta la el script sql en mysql
2. Abre un terminal, navega a la raíz del proyecto y ejecuta:
```
mvn spring-boot:run
```
3. Abre el navegador en la direccion `localhost:9010`
4. Inicia sesión con el usuario correspondiente según la accion que desees realizar.
El super usuario es: usuario-> gerente@soporte.com, contraseña -> contraseña . Con el puedes realizar todas las acciones de los demás tipos de usuarios



