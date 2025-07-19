CREATE TABLE Category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  sku VARCHAR(50) UNIQUE,
  name VARCHAR(200),
  description TEXT,
  FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Product_Variant (
  variant_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  format VARCHAR(50),    -- es. "CD", "Vinile", "Brossura", ecc.
  edition VARCHAR(100),  -- es. "Deluxe", "Standard"
  price DECIMAL(10,2),
  stock INT,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(200)
);

CREATE TABLE Cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Cart_Item (
  cart_id INT NOT NULL,
  variant_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY(cart_id, variant_id),
  FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
  FOREIGN KEY (variant_id) REFERENCES Product_Variant(variant_id)
);

CREATE TABLE Wishlist (
  wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Wishlist_Item (
  wishlist_id INT NOT NULL,
  variant_id INT NOT NULL,
  PRIMARY KEY(wishlist_id, variant_id),
  FOREIGN KEY (wishlist_id) REFERENCES Wishlist(wishlist_id),
  FOREIGN KEY (variant_id) REFERENCES Product_Variant(variant_id)
);

CREATE TABLE `Order` (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE DATABASE IF NOT EXISTS store_loop;
USE store_loop;

CREATE TABLE Order_Item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10 , 2 ),
    FOREIGN KEY (order_id)
        REFERENCES `Order` (order_id),
    FOREIGN KEY (variant_id)
        REFERENCES Product_Variant (variant_id)
);

CREATE TABLE Payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  amount DECIMAL(10,2),
  method VARCHAR(50),
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

CREATE TABLE Shipment (
  shipment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  address VARCHAR(200),
  city VARCHAR(100),
  postal_code VARCHAR(20),
  country VARCHAR(50),
  shipped_date DATETIME,
  FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);
CREATE TABLE Order_Item (   order_item_id INT AUTO_INCREMENT PRIMARY KEY,   order_id INT NOT NULL,   variant_id INT NOT NULL,   quantity INT NOT NULL,   price DECIMAL(10,2),   FOREIGN KEY (order_id) REFERENCES `Order`(order_id),   FOREIGN KEY (variant_id) REFERENCES Product_Variant(variant_id) )
