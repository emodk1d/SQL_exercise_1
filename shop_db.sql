CREATE TYPE SEX AS ENUM ('m', 'f');

CREATE TABLE persons (
    person_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    second_name TEXT NOT NULL,
    middle_name TEXT NOT NULL,
    phone_number TEXT,
    email_address TEXT,
    sex SEX,
    person_type TEXT NOT NULL CHECK (person_type IN ('employee', 'customer'))
);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    manufacturer_name TEXT NOT NULL,
    product_category TEXT NOT NULL,
    product_name TEXT NOT NULL,
    selling_price NUMERIC NOT NULL,
    purchase_cost NUMERIC NOT NULL,
    stock_quantity INTEGER NOT NULL,
    category_description TEXT,
    product_description TEXT
);


CREATE TABLE product_discounts (
    discount_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    discount_rate NUMERIC(5,2) NOT NULL CHECK (discount_rate >= 0 AND discount_rate <= 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT valid_dates CHECK (end_date >= start_date)
);


CREATE TABLE personal_discounts (
    personal_discount_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES persons(person_id),
    discount_rate NUMERIC(5,2) NOT NULL CHECK (discount_rate >= 0 AND discount_rate <= 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    discount_reason TEXT,
    CONSTRAINT valid_dates CHECK (end_date >= start_date)
);


CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES persons(person_id),
    position TEXT NOT NULL,
    salary NUMERIC,
    employment_date DATE NOT NULL
);


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES persons(person_id),
    discount_rate NUMERIC(3,2) NOT NULL DEFAULT 0.00,
    subscription BOOLEAN NOT NULL DEFAULT FALSE,
    registration_date DATE DEFAULT CURRENT_DATE
);


CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
    total_before_discount NUMERIC NOT NULL,
    product_discount_applied NUMERIC DEFAULT 0,
    personal_discount_applied NUMERIC DEFAULT 0,
    transaction_total NUMERIC NOT NULL
);


CREATE TABLE transaction_items (
    item_id SERIAL PRIMARY KEY,
    transaction_id INTEGER NOT NULL REFERENCES sales_transactions(transaction_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC NOT NULL,
    applied_discount_rate NUMERIC(5,2) DEFAULT 0,
    item_total NUMERIC NOT NULL
);