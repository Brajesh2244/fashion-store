package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Default Local Database Configurations
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/fashion_store";
    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "root@123";

    // Method to establish database connection (Supports both local and cloud environments)
    public static Connection getConnection() {

        Connection connection = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Read environment variables if available (e.g. from Railway, Render, AWS, Clever Cloud)
            String envUrl = System.getenv("DB_URL");
            String envUser = System.getenv("DB_USER");
            String envPass = System.getenv("DB_PASSWORD");

            String url = (envUrl != null && !envUrl.trim().isEmpty()) ? envUrl : DEFAULT_URL;
            String username = (envUser != null && !envUser.trim().isEmpty()) ? envUser : DEFAULT_USERNAME;
            String password = (envPass != null && !envPass.trim().isEmpty()) ? envPass : DEFAULT_PASSWORD;

            // Establish Connection
            connection = DriverManager.getConnection(url, username, password);

            System.out.println("Database Connected Successfully to: " + (envUrl != null ? "Cloud MySQL" : "Local MySQL"));

        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver Not Found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }

        return connection;
    }
}