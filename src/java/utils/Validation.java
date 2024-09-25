/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author nhanh
 */
public class Validation {

    // Hàm kiểm tra mật khẩu
    public static boolean checkPassword(String password) {
        // Biểu thức chính quy kiểm tra mật khẩu:
        // - Phải có ít nhất 1 chữ cái hoa
        // - Phải có ít nhất 1 ký tự đặc biệt
        // - Phải có từ 8 đến 20 ký tự
        String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_.+=-]).{8,20}$";

        return password.matches(passwordRegex);

        /* pass valid
        abcABC!@#
        Password123!
        Example_Pass@
        Secure$Pass1
         */
        
        /* pass invalid
        abcdef12 (thiếu ký tự đặc biệt).
        12345678 (không có chữ cái).
        Password (không có ký tự đặc biệt).   
        */
    }
}
