/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.time.Year;

/**
 *
 * @author Admin
 */
public class Validation {
    public boolean checkPassword(String password) {
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
    
    // Kiểm tra tên (không chứa số và cho phép ký tự có dấu tiếng Việt)
    public boolean checkName(String name) {
        // Biểu thức chính quy cho tên: không chứa số, cho phép ký tự dấu tiếng Việt
        String nameRegex = "^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯăÁÂĐÊÔƠàáâãèéêìíòóôõùúăđĩũơƯưẠ-ỹ\\s]+$";
        return name.matches(nameRegex);
    }

    // Kiểm tra năm sinh, người dùng phải từ 17 đến 50 tuổi
    public boolean checkYearOfBirth(int yearOfBirth) {
        int currentYear = Year.now().getValue(); // Lấy năm hiện tại
        int age = currentYear - yearOfBirth;

        // Người dùng phải từ 17 đến 50 tuổi
        return age >= 17 && age <= 50;
    }
    
     // Hàm kiểm tra số điện thoại
    public boolean CheckPhoneNumber(String phone) {
        // Biểu thức chính quy để kiểm tra số điện thoại
        String regex = "^(\\+\\d{1,3})?\\d{9,15}$";
        return phone.matches(regex);
    }
}
