package com.nwaesthetic.connection;
import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection{
    public static void main(String[]args){
        try (Connection conn = DatabaseConnection.getConnection()){
            IO.print("Koneksi data base berhasil");
            IO.print("Database: " + conn.getCatalog());
        }catch (SQLException e){
            System.out.print("koneksi database gagal pangil!");
            System.out.print(e.getMessage());            
        }
    }
}