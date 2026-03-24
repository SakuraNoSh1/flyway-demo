CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    total NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);