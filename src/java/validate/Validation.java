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
        // Regular expression to validate password:
        // - At least 1 uppercase letter
        // - At least 1 lowercase letter
        // - At least 1 special character
        // - No whitespace
        // - Length between 8 and 20 characters
        String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_.+=-]).{8,20}$";

        return password.matches(passwordRegex);
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
     public static boolean checkUserName(String username) {
        // Biểu thức chính quy: chỉ cho phép chữ cái, số và dấu gạch dưới
        String regex = "^[a-zA-Z0-9_]+$";
        
        // Kiểm tra username có khớp với biểu thức chính quy không
        return username.matches(regex);
    }
    
    
    public boolean checkNoSpaces(String input) {
        // Sử dụng regex để kiểm tra nếu chuỗi không chứa khoảng trắng
        return input.matches("\\S+");
    }

}
