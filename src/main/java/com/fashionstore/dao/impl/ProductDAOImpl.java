package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.model.Product;
import com.fashionstore.util.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    // ===========================
    // SQL Queries
    // ===========================

    private static final String INSERT_PRODUCT_SQL =
            "INSERT INTO products(category_id, product_name, brand, description, price, image_url) VALUES(?,?,?,?,?,?)";

    private static final String UPDATE_PRODUCT_SQL =
            "UPDATE products SET category_id=?, product_name=?, brand=?, description=?, price=?, image_url=? WHERE product_id=?";

    private static final String DELETE_PRODUCT_SQL =
            "DELETE FROM products WHERE product_id=?";

    private static final String GET_PRODUCT_BY_ID_SQL =
            "SELECT * FROM products WHERE product_id=?";

    private static final String GET_ALL_PRODUCTS_SQL =
            "SELECT * FROM products";

    private static final String SEARCH_PRODUCTS_SQL =
            "SELECT * FROM products WHERE product_name LIKE ?";

    private static final String GET_PRODUCTS_BY_CATEGORY_SQL =
            "SELECT * FROM products WHERE category_id=?";

    private static final String GET_PRODUCTS_BY_PRICE_SQL =
            "SELECT * FROM products WHERE price BETWEEN ? AND ?";

    private static final String GET_PRODUCTS_BY_BRAND_SQL =
            "SELECT * FROM products WHERE brand=?";

    private static final String SORT_PRICE_LOW_TO_HIGH_SQL =
            "SELECT * FROM products ORDER BY price ASC";

    private static final String SORT_PRICE_HIGH_TO_LOW_SQL =
            "SELECT * FROM products ORDER BY price DESC";

    private static final String SORT_NEWEST_SQL =
            "SELECT * FROM products ORDER BY created_at DESC";
    
    @Override
    public boolean addProduct(Product product) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {

            preparedStatement.setInt(1, product.getCategoryId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getBrand());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setBigDecimal(5, product.getPrice());
            preparedStatement.setString(6, product.getImageUrl());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateProduct(Product product) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {

            preparedStatement.setInt(1, product.getCategoryId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getBrand());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setBigDecimal(5, product.getPrice());
            preparedStatement.setString(6, product.getImageUrl());
            preparedStatement.setInt(7, product.getProductId());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteProduct(int productId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {

            preparedStatement.setInt(1, productId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Product getProductById(int productId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCT_BY_ID_SQL)) {

            preparedStatement.setInt(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToProduct(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_PRODUCTS_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> searchProducts(String keyword) {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_PRODUCTS_SQL)) {

            preparedStatement.setString(1, "%" + keyword + "%");

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_BY_CATEGORY_SQL)) {

            preparedStatement.setInt(1, categoryId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    @Override
    public List<Product> getProductsByPrice(double minPrice, double maxPrice) {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_BY_PRICE_SQL)) {

            preparedStatement.setDouble(1, minPrice);
            preparedStatement.setDouble(2, maxPrice);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> getProductsByBrand(String brand) {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_BY_BRAND_SQL)) {

            preparedStatement.setString(1, brand);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> sortByPriceLowToHigh() {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SORT_PRICE_LOW_TO_HIGH_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> sortByPriceHighToLow() {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SORT_PRICE_HIGH_TO_LOW_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> sortByNewest() {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SORT_NEWEST_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    private Product mapResultSetToProduct(ResultSet resultSet) throws SQLException {

        Product product = new Product();

        product.setProductId(resultSet.getInt("product_id"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setProductName(resultSet.getString("product_name"));
        product.setBrand(resultSet.getString("brand"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getBigDecimal("price"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setCreatedAt(resultSet.getTimestamp("created_at"));

        return product;
    }

}
    