package VeritabaniBaglanti;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class VeritabaniBaglanti {
 
    private static final String URL_TEMPLATE = "jdbc:mysql://localhost:3306/%s?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
   // private static final String URL_TEMPLATE = "jdbc:mysql://localhost:3306/%s?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection(String dbName) throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver"); // ← eski sürüme uygun
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC sürücüsü yüklenemedi.", e);
        }

        String url = String.format(URL_TEMPLATE, dbName);
        return DriverManager.getConnection(url, USERNAME, PASSWORD);
    }
}
