package com.fashionstore.util;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            System.out.println("Connection Established Successfully!");
        } else {
            System.out.println("Connection Failed!");
        }
    }
}