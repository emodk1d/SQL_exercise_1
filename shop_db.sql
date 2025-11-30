CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    manufacturer_name TEXT NOT NULL,
    product_category TEXT NOT NULL,
    product_name TEXT NOT NULL,
    selling_price NUMERIC NOT NULL,
    stock_quantity INTEGER NOT NULL,
    category_description TEXT,
    purchase_cost NUMERIC NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    position TEXT NOT NULL,
    first_name TEXT NOT NULL,
    second_name TEXT NOT NULL,
    middle_name TEXT NOT NULL,
    salary NUMERIC,
    employment_date DATE NOT NULL,
    sex TEXT NOT NULL
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    phone_number TEXT NOT NULL,
    discount_rate NUMERIC(3,2) NOT NULL DEFAULT 0.00,
    first_name TEXT NOT NULL,
    second_name TEXT NOT NULL,
    middle_name TEXT NOT NULL,
    subscription BOOLEAN NOT NULL DEFAULT FALSE,
    email_address TEXT NOT NULL,
    sex TEXT
);

CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    sold INTEGER NOT NULL,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
    transaction_total NUMERIC NOT NULL
);

CREATE TABLE purchase_history (
    history_id SERIAL PRIMARY KEY,
    transaction_id INTEGER NOT NULL REFERENCES sales_transactions(transaction_id),
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id)
);