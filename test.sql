設問1
SELECT
*
FROM
`users`;

設問2
SELECT
*
FROM
`users`
WHERE
`created_at`>=‘2024-01-01’
AND `created_at`<‘2025-01-01’;

設問3
SELECT
*
FROM
`users`
WHERE
`age`<30
AND `gender`=‘female’;

設問4
SELECT
*
FROM
`products`;

設問5
SELECT users.name, orders.order_date
FROM `users`
INNER JOIN `orders`
ON users.id = orders.user_id;

設問6
SELECT 
product_name AS `商品名`,
`price` AS `単価`,
`quantity` AS `数量`,
products.price * order_items.quantity AS `金額`
FROM `order_items`
INNER JOIN `products`
ON order_items.product_id=products.id;

設問7
SELECT 
 users.name,
 COUNT(orders.id) AS `注文件数`
FROM `users`
INNER JOIN `orders`
ON users.id = orders.user_id
GROUP BY users.id, users.name;

設問8
SELECT 
 users.name,
 SUM(order_items.quantity * products.price) AS `総購入金額`
FROM `users`
INNER JOIN `orders`
  ON users.id = orders.user_id
INNER JOIN `order_items`
  ON orders.id = order_items.order_id
INNER JOIN `products`
  ON order_items.product_id = products.id
GROUP BY users.id, users.name;

設問9
SELECT 
 users.name,
SUM(order_items.quantity * products.price) AS `総購入金額`
FROM `users`
INNER JOIN `orders`
  ON users.id = orders.user_id
INNER JOIN `order_items`
  ON orders.id = order_items.order_id
INNER JOIN `products`
  ON order_items.product_id = products.id
GROUP BY users.id, users.name
ORDER BY `総購入金額` DESC
LIMIT 1;

設問10
SELECT
products.product_name,
SUM(order_items.quantity) AS `合計数量` 
FROM `order_items`
INNER JOIN `products`
ON order_items.product_id=products.id
GROUP BY products.id, products.product_name;

設問11
SELECT
users.name
FROM `users`
LEFT JOIN `orders`
ON users.id = orders.user_id
WHERE orders.id IS NULL;

設問12
SELECT
`order_id`
FROM `order_items`
GROUP BY `order_id`
HAVING COUNT(*)>=2;

設問13
SELECT DISTINCT
users.name
FROM `users`
INNER JOIN `orders`
ON users.id = orders.user_id
INNER JOIN `order_items`
ON orders.id = order_items.order_id
INNER JOIN `products`
ON order_items.product_id = products.id
WHERE products.product_name = 'テレビ';


設問14
SELECT
orders.order_date AS `注文日`,
users.name AS `ユーザー名`,
products.product_name AS `商品名`,
order_items.quantity AS `数量`,
order_items.quantity * products.price AS `合計金額`
FROM `order_items`
INNER JOIN `orders`
ON order_items.order_id = orders.id
INNER JOIN `users`
ON orders.user_id = users.id
INNER JOIN `products`
ON order_items.product_id = products.id;

設問15
SELECT
products.product_name
FROM `order_items`
INNER JOIN `products`
ON order_items.product_id = products.id
GROUP BY products.id,products.product_name
ORDER BY  SUM(order_items.quantity) DESC
LIMIT 1;

設問16
SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS 注文月,
  COUNT(*) AS `注文件数`
FROM `orders`
GROUP BY `注文月`
ORDER BY `注文月`;

設問17
SELECT
products.product_name
FROM `products`
LEFT JOIN `order_items`
ON products.id = order_items.product_id
WHERE order_items.product_id IS NULL;

設問18
CREATE INDEX idx_product ON order_items(product_id);

設問19
SELECT
users.name,
AVG(t.order_total) AS `平均金額`
FROM (
  SELECT
    orders.id,
    orders.user_id,
    SUM(order_items.quantity * products.price) AS `order_total`
  FROM `orders`
  INNER JOIN `order_items`
    ON orders.id = order_items.order_id
  INNER JOIN `products`
    ON order_items.product_id = products.id
  GROUP BY orders.id, orders.user_id
) t
INNER JOIN `users`
  ON users.id = t.user_id
GROUP BY users.id, users.name;

設問20
SELECT
users.name,
MAX(orders.order_date) AS `最新注文日`
FROM `users`
INNER JOIN `orders`
ON users.id = orders.user_id
GROUP BY users.id,users.name;

設問21
INSERT INTO
`users`(`id`,`name`,`age`,`gender`,`created_at`)
VALUES
(6, '中村愛', 25, 'female', '2025-06-01');

設問22
INSERT INTO
`products`(`id`,`product_name`,`price`)
VALUES
(6, 'エアコン', 6000);

設問23
INSERT INTO
`orders`(`id`,`user_id`,`order_date`)
VALUES
(10, 1, '2025-06-10');

設問24
INSERT INTO
`order_items`(`id`,`order_id`,`product_id`,`quantity`)
VALUES
(10, 1, 6, 1);

設問25
UPDATE
`users`
SET
`age`=24
WHERE
`id`=4;

設問26
UPDATE
`products`
SET
`price`=`price`*1.1;

設問27
UPDATE
`orders`
SET
`order_date`='2024-05-01'
WHERE
`order_date`<'2024-05-01’;

設問28
DELETE
FROM
`users`
WHERE
`name`= '高橋健一';

設問29
DELETE
FROM
`order_items`
WHERE
`id`=5;

設問30
DELETE
FROM
`products`
WHERE id IN(
SELECT id FROM(
SELECT p.id
FROM products p
LEFT JOIN order_items oi
ON p.id = oi.product_id
WHERE oi.product_id IS NULL
)t
);
