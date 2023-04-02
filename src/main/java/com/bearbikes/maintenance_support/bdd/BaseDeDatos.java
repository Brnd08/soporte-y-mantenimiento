package com.bearbikes.maintenance_support.bdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase creada con el patron singlenton para obtener una connección con la
 * base de datos en mysql
 */
public class BaseDeDatos {
    private static final String NOMBRE_BDD = "pruebas";
    private static final String PUERTO_BDD = "3308";
    private static final String USUARIO_BDD = "root";
    private static final String PASSWORD_BDD = "n0m3l0";
    private static final String IP_BDD = "localhost";

    private static final String DRIVER_BDD = "jdbc:mysql";
    //  jdbc:mysql://localhost:3308/pruebas
    private static Connection connection;

    public BaseDeDatos() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                String url = DRIVER_BDD + "://" + IP_BDD + ":" + PUERTO_BDD + "/" + NOMBRE_BDD;
                System.out.println(url);
                connection = DriverManager.getConnection(url, USUARIO_BDD, PASSWORD_BDD);
                System.out.println("CONECCIÓN CREADA EXITOSAMENTE");
            } catch (SQLException e) {
                System.out.println("FALLO AL CREAR CONECCIÓN");
                throw new RuntimeException(e);
            }
        }
    }

    public Connection getConnection(){
        return connection;
    }

}
