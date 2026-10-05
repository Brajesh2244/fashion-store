-- =============================================
-- FashionStore Database Schema & Seed Data
-- =============================================
CREATE DATABASE IF NOT EXISTS fashion_store;
USE fashion_store;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS product_variants;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `fk_products_category` (`category_id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_variants` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size` varchar(10) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`variant_id`),
  KEY `fk_variants_product` (`product_id`),
  CONSTRAINT `fk_variants_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cart_items` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `variant_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`cart_item_id`),
  KEY `fk_cartitems_cart` (`cart_id`),
  KEY `fk_cartitems_variant` (`variant_id`),
  CONSTRAINT `fk_cartitems_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `fk_cartitems_variant` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PLACED',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `variant_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `fk_orderitems_order` (`order_id`),
  KEY `fk_orderitems_variant` (`variant_id`),
  CONSTRAINT `fk_orderitems_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_orderitems_variant` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO categories (category_id, category_name) VALUES (7, 'Accessories');
INSERT INTO categories (category_id, category_name) VALUES (6, 'Bags');
INSERT INTO categories (category_id, category_name) VALUES (3, 'Kids');
INSERT INTO categories (category_id, category_name) VALUES (1, 'Men');
INSERT INTO categories (category_id, category_name) VALUES (4, 'Shoes');
INSERT INTO categories (category_id, category_name) VALUES (8, 'Sportswear');
INSERT INTO categories (category_id, category_name) VALUES (5, 'Watches');
INSERT INTO categories (category_id, category_name) VALUES (2, 'Women');

INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (1, 1, 'Black Casual Shirt', 'Roadster', 'Men black casual cotton shirt', 1299.00, 'assets/images/products/black-casual-shirt.jpg', '2026-06-29 14:14:24.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (2, 1, 'Blue Slim Fit Jeans', 'Levis', 'Men blue slim fit stretch jeans', 1999.00, 'assets/images/products/blue-slim-fit-jeans.jpg', '2026-06-29 14:14:24.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (3, 1, 'White Polo T-Shirt', 'US Polo', 'Premium white polo t-shirt', 999.00, 'assets/images/products/white-polo-tshirt.jpg', '2026-06-29 14:14:24.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (4, 1, 'Green Hoodie', 'H&M', 'Cotton winter hoodie', 1899.00, 'assets/images/products/green-hoodie.jpg', '2026-06-29 14:14:24.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (5, 1, 'Denim Jacket', 'Wrangler', 'Classic blue denim jacket', 2499.00, 'assets/images/products/men/denim-jacket.jpg', '2026-06-29 14:14:24.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (6, 2, 'Floral Summer Dress', 'Zara', 'Printed floral summer dress', 2499.00, 'assets/images/products/women/floral-dress.jpg', '2026-06-29 14:15:32.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (7, 2, 'Pink Kurti', 'Biba', 'Women straight pink kurti', 1499.00, 'assets/images/products/women/pink-kurti.jpg', '2026-06-29 14:15:32.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (8, 2, 'Black High Waist Jeans', 'Only', 'Stretch high waist jeans', 2199.00, 'assets/images/products/women/black-jeans.jpg', '2026-06-29 14:15:32.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (9, 2, 'White Crop Top', 'H&M', 'Casual white crop top', 899.00, 'assets/images/products/women/crop-top.jpg', '2026-06-29 14:15:32.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (10, 2, 'Blue Denim Skirt', 'Levis', 'Stylish blue denim skirt', 1699.00, 'assets/images/products/women/denim-skirt.jpg', '2026-06-29 14:15:32.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (11, 3, 'Kids Checked Shirt', 'Max', 'Checked cotton shirt for boys', 999.00, 'assets/images/products/kids/checked-shirt.jpg', '2026-06-29 14:16:11.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (12, 3, 'Kids Party Dress', 'Hopscotch', 'Girls party wear dress', 1799.00, 'assets/images/products/kids/party-dress.jpg', '2026-06-29 14:16:11.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (13, 3, 'Kids Hoodie', 'Puma', 'Warm hoodie for kids', 1299.00, 'assets/images/products/kids/hoodie.jpg', '2026-06-29 14:16:11.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (14, 3, 'Kids Shorts', 'Max', 'Comfortable cotton shorts', 699.00, 'assets/images/products/kids/shorts.jpg', '2026-06-29 14:16:11.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (15, 3, 'Kids T-Shirt', 'Nike', 'Sports t-shirt for kids', 799.00, 'assets/images/products/kids/tshirt.jpg', '2026-06-29 14:16:11.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (16, 4, 'Running Shoes', 'Nike', 'Lightweight running shoes', 3999.00, 'assets/images/products/shoes/running-shoes.jpg', '2026-06-29 14:16:47.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (17, 4, 'Sneakers', 'Adidas', 'White casual sneakers', 3499.00, 'assets/images/products/shoes/sneakers.jpg', '2026-06-29 14:16:47.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (18, 4, 'Formal Shoes', 'Bata', 'Leather formal shoes', 2999.00, 'assets/images/products/shoes/formal-shoes.jpg', '2026-06-29 14:16:47.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (19, 4, 'Sports Shoes', 'Puma', 'Comfortable sports shoes', 3799.00, 'assets/images/products/shoes/sports-shoes.jpg', '2026-06-29 14:16:47.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (20, 4, 'Sandals', 'Woodland', 'Outdoor sandals', 2299.00, 'assets/images/products/shoes/sandals.jpg', '2026-06-29 14:16:47.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (21, 5, 'Titan Analog Watch', 'Titan', 'Premium analog watch with leather strap', 4599.00, 'assets/images/products/watches/titan-analog.jpg', '2026-06-29 14:17:33.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (22, 5, 'Fastrack Digital Watch', 'Fastrack', 'Digital sports watch', 2499.00, 'assets/images/products/watches/fastrack-digital.jpg', '2026-06-29 14:17:33.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (23, 5, 'Noise Smart Watch', 'Noise', 'Bluetooth smart watch with heart rate monitoring', 3999.00, 'assets/images/products/watches/noise-smart.jpg', '2026-06-29 14:17:33.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (24, 5, 'Casio Vintage Watch', 'Casio', 'Classic vintage digital watch', 3299.00, 'assets/images/products/watches/casio-vintage.jpg', '2026-06-29 14:17:33.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (25, 5, 'Sonata Casual Watch', 'Sonata', 'Affordable casual wrist watch', 1899.00, 'assets/images/products/watches/sonata-casual.jpg', '2026-06-29 14:17:33.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (26, 6, 'Laptop Backpack', 'Skybags', 'Water resistant laptop backpack', 1899.00, 'assets/images/products/bags/laptop-backpack.jpg', '2026-06-29 14:18:19.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (27, 6, 'Travel Backpack', 'Wildcraft', 'Large capacity travel backpack', 2499.00, 'assets/images/products/bags/travel-backpack.jpg', '2026-06-29 14:18:19.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (28, 6, 'Women Handbag', 'Caprese', 'Stylish women handbag', 2299.00, 'assets/images/products/bags/women-handbag.jpg', '2026-06-29 14:18:19.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (29, 6, 'Office Bag', 'American Tourister', 'Professional office bag', 2799.00, 'assets/images/products/bags/office-bag.jpg', '2026-06-29 14:18:19.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (30, 6, 'Gym Bag', 'Nike', 'Spacious gym duffle bag', 1699.00, 'assets/images/products/bags/gym-bag.jpg', '2026-06-29 14:18:19.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (31, 7, 'Leather Belt', 'Allen Solly', 'Premium genuine leather belt', 799.00, 'assets/images/products/accessories/leather-belt.jpg', '2026-06-29 14:19:27.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (32, 7, 'Leather Wallet', 'Woodland', 'Brown genuine leather wallet', 999.00, 'assets/images/products/accessories/wallet.jpg', '2026-06-29 14:19:27.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (33, 7, 'Sunglasses', 'Ray-Ban', 'UV protected stylish sunglasses', 3499.00, 'assets/images/products/accessories/sunglasses.jpg', '2026-06-29 14:19:27.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (34, 7, 'Sports Cap', 'Nike', 'Adjustable cotton sports cap', 599.00, 'assets/images/products/accessories/cap.jpg', '2026-06-29 14:19:27.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (35, 7, 'Cotton Socks', 'Puma', 'Pack of 3 premium cotton socks', 399.00, 'assets/images/products/accessories/socks.jpg', '2026-06-29 14:19:27.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (36, 8, 'Gym T-Shirt', 'Adidas', 'Dry-fit gym t-shirt for workouts', 1199.00, 'assets/images/products/sportswear/gym-tshirt.jpg', '2026-06-29 14:20:15.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (37, 8, 'Track Pants', 'Puma', 'Comfortable sports track pants', 1699.00, 'assets/images/products/track-pants.jpg', '2026-06-29 14:20:15.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (38, 8, 'Sports Shorts', 'Nike', 'Lightweight running shorts', 999.00, 'assets/images/products/sports-shorts.jpg', '2026-06-29 14:20:15.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (39, 8, 'Training Jacket', 'Reebok', 'Full sleeve training jacket', 2499.00, 'assets/images/products/training-jacket.jpg', '2026-06-29 14:20:15.0');
INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url, created_at) VALUES (40, 8, 'Compression Tights', 'Under Armour', 'Performance compression tights', 2199.00, 'assets/images/products/compression-tights.jpg', '2026-06-29 14:20:15.0');

INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (1, 1, 'S', 4);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (2, 1, 'M', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (3, 1, 'L', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (4, 2, '30', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (5, 2, '32', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (6, 2, '34', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (7, 3, 'S', 24);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (8, 3, 'M', 30);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (9, 3, 'L', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (10, 4, 'M', 14);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (11, 4, 'L', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (12, 4, 'XL', 1);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (13, 5, 'M', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (14, 5, 'L', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (15, 5, 'XL', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (16, 6, 'S', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (17, 6, 'M', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (18, 6, 'L', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (19, 7, 'S', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (20, 7, 'M', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (21, 7, 'L', 14);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (22, 8, '28', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (23, 8, '30', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (24, 8, '32', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (25, 9, 'S', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (26, 9, 'M', 24);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (27, 9, 'L', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (28, 10, 'S', 14);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (29, 10, 'M', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (30, 10, 'L', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (31, 11, '24', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (32, 11, '26', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (33, 11, '28', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (34, 12, '24', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (35, 12, '26', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (36, 12, '28', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (37, 13, 'S', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (38, 13, 'M', 24);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (39, 13, 'L', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (40, 14, '24', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (41, 14, '26', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (42, 14, '28', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (43, 15, 'S', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (44, 15, 'M', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (45, 15, 'L', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (46, 16, '7', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (47, 16, '8', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (48, 16, '9', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (49, 17, '7', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (50, 17, '8', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (51, 17, '9', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (52, 18, '7', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (53, 18, '8', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (54, 18, '9', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (55, 19, '7', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (56, 19, '8', 24);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (57, 19, '9', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (58, 20, '7', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (59, 20, '8', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (60, 20, '9', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (61, 21, 'Free', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (62, 21, 'Premium', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (63, 21, 'Limited', 10);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (64, 22, 'Free', 30);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (65, 22, 'Premium', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (66, 22, 'Limited', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (67, 23, 'Free', 28);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (68, 23, 'Premium', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (69, 23, 'Limited', 10);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (70, 24, 'Free', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (71, 24, 'Premium', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (72, 24, 'Limited', 8);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (73, 25, 'Free', 34);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (74, 25, 'Premium', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (75, 25, 'Limited', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (76, 26, 'Free', 30);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (77, 26, 'Large', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (78, 26, 'XL', 10);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (79, 27, 'Free', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (80, 27, 'Large', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (81, 27, 'XL', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (82, 28, 'Free', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (83, 28, 'Large', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (84, 28, 'XL', 10);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (85, 29, 'Free', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (86, 29, 'Large', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (87, 29, 'XL', 8);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (88, 30, 'Free', 28);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (89, 30, 'Large', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (90, 30, 'XL', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (91, 31, 'Free', 30);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (92, 31, 'Premium', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (93, 31, 'Limited', 10);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (94, 32, 'Free', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (95, 32, 'Premium', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (96, 32, 'Limited', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (97, 33, 'Free', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (98, 33, 'Premium', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (99, 33, 'Limited', 8);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (100, 34, 'Free', 28);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (101, 34, 'Premium', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (102, 34, 'Limited', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (103, 35, 'Free', 35);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (104, 35, 'Premium', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (105, 35, 'Limited', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (106, 36, 'S', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (107, 36, 'M', 25);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (108, 36, 'L', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (109, 37, 'M', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (110, 37, 'L', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (111, 37, 'XL', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (112, 38, 'S', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (113, 38, 'M', 22);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (114, 38, 'L', 16);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (115, 39, 'M', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (116, 39, 'L', 18);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (117, 39, 'XL', 12);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (118, 40, 'S', 15);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (119, 40, 'M', 20);
INSERT INTO product_variants (variant_id, product_id, size, stock) VALUES (120, 40, 'L', 15);

