package com.nwaesthetic.util;
import org.mindrot.jbcrypt.BCrypt;
public class PasswordUtil{
    public static String hashPassword(String password){
        return BCrypt.hashpw(password,BCrypt.gensalt(12));
    }
    public static boolean verifyPassword(String password,String hasedPassword){
        if (password == null || hasedPassword == null){
            return false;
        }
        try{
            return BCrypt.checkpw(password,hasedPassword);
        }catch(IllegalArgumentException e){
            return false;
        }
    }
}