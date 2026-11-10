package com.nwaesthetic.util;

import com.nwaesthetic.connection.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GeneratePassword {

    public static void main(String[] args) {

        String username = "admin";
        String password = "admin123";

        String hash = PasswordUtil.hashPassword(password);

        String sql = "UPDATE pengguna SET password = ? "
                   + "WHERE username = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, hash);
            stmt.setString(2, username);

            int hasil = stmt.executeUpdate();

            if (hasil > 0) {
                System.out.println("Password berhasil diperbarui!");

                try (PreparedStatement cek = conn.prepareStatement(
                        "SELECT password FROM pengguna WHERE username = ?")) {

                    cek.setString(1, username);

                    try (ResultSet rs = cek.executeQuery()) {
                        if (rs.next()) {
                            String hashDatabase = rs.getString("password");

                            System.out.println("Panjang hash DB: "
                                    + hashDatabase.length());

                            System.out.println("Verifikasi DB: "
                                    + PasswordUtil.verifyPassword(
                                            password, hashDatabase));
                        }
                    }
                }
            } else {
                System.out.println("Akun admin tidak ditemukan!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}