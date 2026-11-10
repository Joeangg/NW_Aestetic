package com.nwaesthetic.dao;

import com.nwaesthetic.connection.DatabaseConnection;
import com.nwaesthetic.model.Pengguna;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PenggunaDAO{
    public Pengguna cariBerdasarkanUsername(String username){
       String sql = "SELECT id, username, password, role, status "
           + "FROM pengguna WHERE username = ? LIMIT 1";
        try (Connection conn= DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)){
            
            stmt.setString(1,username);
            try(ResultSet rs = stmt.executeQuery()){
                if (rs.next()){
                    Pengguna pengguna = new Pengguna();
                    pengguna.setId(rs.getString("id"));
                    pengguna.setUsername(rs.getString("username"));
                    pengguna.setPassword(rs.getString("password"));
                    pengguna.setRole(rs.getString("role"));
                    pengguna.setStatus(rs.getString("status"));
                    
                    return pengguna;
                            
                }
            }
        }catch (SQLException e){
            System.out.print("gagal mengambil data pengguan: "
                    +e.getMessage());
        }
        return null;
    }
}