/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Admin
 */
public class ValidatePassword {
    public boolean validatePassword(String password) {
        if (password.length() < 8) {
            return true;
        }
        return false;
    }
}
