package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductVariantDAO;
import com.fashionstore.model.ProductVariant;
import com.fashionstore.util.DBConnection;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    // ===========================
    // SQL Queries
    // ===========================

    private static final String INSERT_VARIANT_SQL =
            "INSERT INTO product_variants(product_id, size, stock) VALUES(?,?,?)";

    private static final String UPDATE_VARIANT_SQL =
            "UPDATE product_variants SET product_id=?, size=?, stock=? WHERE variant_id=?";

    private static final String DELETE_VARIANT_SQL =
            "DELETE FROM product_variants WHERE variant_id=?";

    private static final String GET_VARIANT_BY_ID_SQL =
            "SELECT * FROM product_variants WHERE variant_id=?";

    private static final String GET_VARIANTS_BY_PRODUCT_SQL =
            "SELECT * FROM product_variants WHERE product_id=?";

    private static final String GET_VARIANT_BY_PRODUCT_AND_SIZE_SQL =
            "SELECT * FROM product_variants WHERE product_id=? AND size=?";

    private static final String UPDATE_STOCK_SQL =
            "UPDATE product_variants SET stock=? WHERE variant_id=?";

    private static final String GET_AVAILABLE_STOCK_SQL =
            "SELECT stock FROM product_variants WHERE variant_id=?";
    @Override
    public boolean addVariant(ProductVariant variant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_VARIANT_SQL)) {

            preparedStatement.setInt(1, variant.getProductId());
            preparedStatement.setString(2, variant.getSize());
            preparedStatement.setInt(3, variant.getStock());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateVariant(ProductVariant variant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_VARIANT_SQL)) {

            preparedStatement.setInt(1, variant.getProductId());
            preparedStatement.setString(2, variant.getSize());
            preparedStatement.setInt(3, variant.getStock());
            preparedStatement.setInt(4, variant.getVariantId());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteVariant(int variantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_VARIANT_SQL)) {

            preparedStatement.setInt(1, variantId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public ProductVariant getVariantById(int variantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_VARIANT_BY_ID_SQL)) {

            preparedStatement.setInt(1, variantId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToVariant(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    @Override
    public List<ProductVariant> getVariantsByProduct(int productId) {

        List<ProductVariant> variants = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_VARIANTS_BY_PRODUCT_SQL)) {

            preparedStatement.setInt(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                variants.add(mapResultSetToVariant(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return variants;
    }

    @Override
    public ProductVariant getVariantByProductAndSize(int productId, String size) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_VARIANT_BY_PRODUCT_AND_SIZE_SQL)) {

            preparedStatement.setInt(1, productId);
            preparedStatement.setString(2, size);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToVariant(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateStock(int variantId, int stock) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STOCK_SQL)) {

            preparedStatement.setInt(1, stock);
            preparedStatement.setInt(2, variantId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public int getAvailableStock(int variantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_AVAILABLE_STOCK_SQL)) {

            preparedStatement.setInt(1, variantId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("stock");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    private ProductVariant mapResultSetToVariant(ResultSet resultSet) throws SQLException {

        ProductVariant variant = new ProductVariant();

        variant.setVariantId(resultSet.getInt("variant_id"));
        variant.setProductId(resultSet.getInt("product_id"));
        variant.setSize(resultSet.getString("size"));
        variant.setStock(resultSet.getInt("stock"));

        return variant;
    }

}
