package com.nwaesthetic.service;
 import com.nwaesthetic.dao.PenggunaDAO;
 import com.nwaesthetic.model.Pengguna;
 import com.nwaesthetic.util.PasswordUtil;

public class AuthService{
    private final PenggunaDAO penggunaDAO;
    public AuthService(){
        this.penggunaDAO = new PenggunaDAO();
    }
    public Pengguna login(String username,String password){
        if(username == null || username.isBlank() || password == null || password.isBlank()){
         return null;   
        }
        Pengguna pengguna = penggunaDAO.cariBerdasarkanUsername(username.trim());
         if (pengguna == null){
             return null;         
    }
    boolean passwordBenar = PasswordUtil.verifyPassword(
            password,
            pengguna.getPassword());
    if (!passwordBenar){
        return null;
    }
    return pengguna;
    }
}