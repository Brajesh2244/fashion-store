package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.Category;

public interface CategoryDAO {

    // Add Category
    boolean addCategory(Category category);

    // Update Category
    boolean updateCategory(Category category);

    // Delete Category
    boolean deleteCategory(int categoryId);

    // Fetch Category
    Category getCategoryById(int categoryId);

    // Fetch All Categories
    List<Category> getAllCategories();
}