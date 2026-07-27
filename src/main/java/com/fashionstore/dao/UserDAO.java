package com.fashionstore.dao;

import com.	fashionstore.model.User;

public interface UserDAO {

    // Registration
    boolean registerUser(User user);

    // Login
    User loginUser(String email, String password);

    // Fetch User
    User getUserById(int userId);

    User getUserByEmail(String email);

    // Update Profile
    boolean updateUser(User user);

    // Delete User
    boolean deleteUser(int userId);

    // Validation
    boolean emailExists(String email);

    boolean phoneExists(String phone);
}