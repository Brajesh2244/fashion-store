package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.ProductVariant;

public interface ProductVariantDAO {

    // Add Product Variant
    boolean addVariant(ProductVariant variant);

    // Update Product Variant
    boolean updateVariant(ProductVariant variant);

    // Delete Product Variant
    boolean deleteVariant(int variantId);

    // Fetch Variant
    ProductVariant getVariantById(int variantId);

    // Fetch All Variants of a Product
    List<ProductVariant> getVariantsByProduct(int productId);

    // Fetch Variant by Product and Size
    ProductVariant getVariantByProductAndSize(int productId, String size);

    // Update Stock
    boolean updateStock(int variantId, int stock);

    // Check Stock Availability
    int getAvailableStock(int variantId);
}