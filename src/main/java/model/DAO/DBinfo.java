/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

public interface DBinfo {
//123456
    String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=CinemaDB;encrypt=true;trustServerCertificate=true;";
    String dbUser = "sa";
    String dbPass = "123";
    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
}
