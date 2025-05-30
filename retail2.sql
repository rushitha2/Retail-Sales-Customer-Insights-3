create database retail2;
use retail2;

create table dim_customers ( customer_id varchar(5) primary key,
    name varchar(15) not null,
    email varchar(20),
    location varchar(15),
    join_date date);
    

create table dim_products ( product_id varchar(5) primary key,
    product_name varchar(15) not null,
    category varchar(15),
    price int,
    stock_level int);


create table dim_promotions ( promotion_id varchar(5) primary key,
    product_id varchar(5),
    discount_percentage int,
    start_date date,
    end_date date,
    foreign key (product_id) references dim_products(product_id));
    

create table dim_inventory ( inventory_id varchar(5) primary key,
    product_id varchar(5),
    warehouse_location varchar(15),
    stock_quantity int,
    last_updated date,
    foreign key (product_id) references dim_products(product_id));
    

create table fact_sales ( transaction_id varchar(5) primary key,
    customer_id varchar(5),
    product_id varchar(5),
    promotion_id varchar(5),
    inventory_id varchar(5),
    transaction_date date,
    quantity int,
    amount decimal(10,2),
    discount_amount decimal(10,2),
    final_amount decimal(10,2),
    foreign key (customer_id) references dim_customers(customer_id),
    foreign key (product_id) references dim_products(product_id),
	foreign key (promotion_id) references dim_promotions(promotion_id),
    foreign key (inventory_id) references dim_inventory(inventory_id));
    
    
insert into dim_customers values ('c001', 'john doe', 'john@example.com', 'new york', '2023-01-15'),
('c002', 'jane smith', 'jane@example.com', 'los angeles', '2022-11-10'),
('c003', 'alice brown', 'alice@example.com', 'chicago', '2023-02-05'),
('c004', 'bob white', 'bob@example.com', 'miami', '2023-03-22'),
('c005', 'emma johnson', 'emma@example.com', 'seattle', '2023-04-10');
  
select * from dim_customers;

insert into dim_products values ('p001', 'laptop', 'electronics', 1200, 50),
('p002', 'smartphone', 'electronics', 800, 100),
('p003', 'headphones', 'accessories', 150, 200),
('p004', 'smartwatch', 'wearables', 250, 75),
('p005', 'tablet', 'electronics', 500, 60);

select * from dim_products;

insert into dim_promotions values ('pr001', 'p001', 10.00, '2024-01-01', '2024-01-10'),
('pr002', 'p002', 15.00, '2024-02-05', '2024-02-15'),
('pr003', 'p003', 5.00, '2024-03-10', '2024-03-20'),
('pr004', 'p004', 20.00, '2024-04-15', '2024-04-25'),
('pr005', 'p005', 12.50, '2024-05-18', '2024-05-31');

select * from dim_promotions;

insert into dim_inventory values ('i001', 'p001', 'new york', 50, '2024-01-09'),
('i002', 'p002', 'los angeles', 100, '2024-02-11'),
('i003', 'p003', 'chicago', 200, '2024-03-14'),
('i004', 'p004', 'miami', 75, '2024-04-17'),
('i005', 'p005', 'denver', 60, '2024-05-20');

select * from dim_inventory;

insert into fact_sales values
('t1001', 'c001', 'p001', 'pr001', 'i001', '2024-01-10',1, 1200.00, 120.00, 1080.00),
('t1002', 'c002', 'p002', 'pr002', 'i002', '2024-02-12',2, 1600.00, 240.00, 1360.00),
('t1003', 'c003', 'p003', 'pr003', 'i003', '2024-03-15', 3, 450.00, 22.50, 427.50),
('t1004', 'c004', 'p004', 'pr004', 'i004', '2024-04-18', 1,250.00, 50.00, 200.00),
('t1005', 'c005', 'p005', 'pr005', 'i005', '2024-05-20', 2, 1000.00, 125.00, 875.00),
('t1006', 'c001', 'p002', null, 'i002', '2024-03-22', 1,800.00, 0.00, 800.00),
('t1007', 'c002', 'p003', null, 'i003', '2024-04-25', 4, 600.00, 0.00, 600.00),
('t1008', 'c003', 'p004', 'pr004', 'i004', '2024-04-23', 1,250.00, 50.00, 200.00),
('t1009', 'c004', 'p001', null, 'i001', '2024-01-30', 5, 6000.00, 0.00, 6000.00),
('t1010', 'c005', 'p002', null, 'i002', '2024-03-02', 2, 1600.00, 0.00, 1600.00),
('t1011', 'c001', 'p003', null, 'i003', '2024-04-05', 1,150.00, 0.00, 150.00),
('t1012', 'c002', 'p005', null, 'i005', '2024-06-08',3, 1500.00, 0.00, 1500.00);

select * from fact_sales;