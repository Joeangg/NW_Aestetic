package com.nwaesthetic.service;

import com.nwaesthetic.dao.PenggunaDAO;
import com.nwaesthetic.model.Pengguna;
import com.nwaesthetic.util.PasswordUtil;

public class AuthService {

    private final PenggunaDAO penggunaDAO;

    public AuthService() {
        this.penggunaDAO = new PenggunaDAO();
    }

    public Pengguna login(String username, String password) {

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            System.out.println("DEBUG: Username/password kosong");
            return null;
        }

        Pengguna pengguna =
                penggunaDAO.cariBerdasarkanUsername(username.trim());

        if (pengguna == null) {
            System.out.println("DEBUG: Pengguna tidak ditemukan");
            return null;
        }

        System.out.println("DEBUG: Username ditemukan");
        System.out.println("DEBUG: Role = " + pengguna.getRole());
        System.out.println("DEBUG: Status = " + pengguna.getStatus());
        System.out.println("DEBUG: Panjang hash = "
                + (pengguna.getPassword() == null
                ? "NULL" : pengguna.getPassword().length()));

        boolean passwordBenar = PasswordUtil.verifyPassword(
                password,
                pengguna.getPassword()
        );

        System.out.println("DEBUG: Password cocok = " + passwordBenar);

        if (!passwordBenar) {
            return null;
        }

        if (!"AKTIF".equalsIgnoreCase(pengguna.getStatus())) {
            System.out.println("DEBUG: Akun tidak aktif");
            return null;
        }

        return pengguna;
    }
}