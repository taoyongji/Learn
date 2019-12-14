/*创建表*/
CREATE TABLE shop.Product(
	product_id 		CHAR(4) 		NOT NULL,
    product_name 	VARCHAR(100) 	NOT NULL,
    product_type	VARCHAR(32)		NOT NULL,
    sale_price		INTEGER,
    purchase_price	INTEGER,
    regist_date		DATE,
    PRIMARY KEY(product_id)
);

ALTER TABLE shop.Product ADD COLUMN product_name_pinyin VARCHAR(100);

ALTER TABLE shop.Product DROP COLUMN product_name_pinyin;

/*事务*/
START TRANSACTION;
INSERT INTO shop.Product VALUES('001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO shop.Product VALUES('002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO shop.Product VALUES('003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO shop.Product VALUES('004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO shop.Product VALUES('005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO shop.Product VALUES('006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO shop.Product VALUES('007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO shop.Product VALUES('008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
COMMIT;
-- ROLLBACN;

/*修改表名*/
-- RENAME TABLE shop.pro to shop.Product;

SELECT 	product_id 		AS "商品编号",
		product_name 	AS "商品名称",
        purchase_price	AS "进货单价"
	FROM shop.Product;
    
/*DISTINCT 去除重复行*/
SELECT DISTINCT product_type
	FROM shop.Product;
    
SELECT product_name, sale_price, sale_price * 2 AS "sale_price_x2"
	FROM shop.Product;

 /*取出空值的数据*/
SELECT product_name, purchase_price
	FROM shop.Product
  WHERE purchase_price IS NULL;
  
SELECT product_name, purchase_price
	FROM shop.Product
  WHERE purchase_price IS NOT NULL;

/*聚合函数 SUM() COUNT() MAX() MIN() AVG()*/
SELECT SUM(sale_price)
	FROM shop.Product;
    
SELECT AVG(sale_price)
	FROM shop.Product;
    
SELECT COUNT(DISTINCT product_type)
	FROM shop.Product;

/*使用GROUP BY子句进行汇总*/
SELECT product_type, COUNT(*)
	FROM shop.Product
  GROUP BY product_type;
  
SELECT purchase_price, COUNT(*)
	FROM shop.Product
  GROUP BY purchase_price;
  
SELECT purchase_price, COUNT(*)
	FROM shop.Product
  WHERE product_type = '衣服'
  GROUP BY purchase_price;
  
/*HAVING 为聚合结果指定条件*/
SELECT product_type, COUNT(*)
	FROM shop.Product
  GROUP BY product_type
  HAVING COUNT(*) = 2;
  
SELECT product_type, AVG(sale_price)
	FROM shop.Product
  GROUP BY product_type
  HAVING AVG(sale_price) >= 2500;
  
/*聚合键所对应的条件不应该写在HAVING子句中，而应该书写在WHERE子句中*/
SELECT product_type, COUNT(*)
	FROM shop.Product
  WHERE product_type = '衣服'
  GROUP BY product_type;
  
SELECT product_type, COUNT(*)
	FROM shop.Product
  GROUP BY product_type
  HAVING product_type = '衣服';
  
/*ORDER BY 对查询结果进行排序
  ASC进行升序排列(默认)
  DESC进行降序排列
*/
SELECT product_id, product_name, sale_price, purchase_price
	FROM shop.Product
  ORDER BY sale_price ASC;
  
SELECT product_id, product_name, sale_price, purchase_price
	FROM shop.Product
  ORDER BY sale_price, product_id;

/*排序键中包含NULL时，会在开头或末尾进行汇总*/
SELECT product_id, product_name, sale_price, purchase_price
	FROM shop.Product
  ORDER BY purchase_price;

/*创建ProductIns表*/
CREATE TABLE shop.ProductIns(
	product_id 		CHAR(4) 		NOT NULL,
    product_name 	VARCHAR(100) 	NOT NULL,
    product_type	VARCHAR(32)		NOT NULL,
    sale_price		INTEGER			DEFAULT 0,
    purchase_price	INTEGER,
    regist_date		DATE,
    PRIMARY KEY(product_id)
);

/*通过显示方式插入默认值*/
INSERT INTO shop.ProductIns VALUES('007', '擦菜板', '厨房用具', DEFAULT, 790, '2008-04-28');

/*创建表ProductCopy*/
CREATE TABLE shop.ProductCopy(
	product_id 		CHAR(4) 		NOT NULL,
    product_name 	VARCHAR(100) 	NOT NULL,
    product_type	VARCHAR(32)		NOT NULL,
    sale_price		INTEGER,
    purchase_price	INTEGER,
    regist_date		DATE,
    PRIMARY KEY(product_id)
);

-- DROP TABLE shop.ProductCopy;

INSERT INTO shop.ProductCopy
	SELECT *
		FROM shop.Product;
        
/*INSERT...SELECT 中也可以使用WHERE子句和GROUP BY子句等*/
CREATE TABLE shop.ProductType (
	product_type			VARCHAR(32)		NOT NULL,
    sum_sale_price  		INTEGER,
    sum_purchase_price		INTEGER,
    PRIMARY KEY(product_type)
);

INSERT INTO shop.ProductType
	SELECT product_type, SUM(sale_price), SUM(purchase_price)
		FROM shop.Product
	  GROUP BY product_type;

/*DELETE 数据的删除*/
DELETE FROM shop.ProductType;

/*TRUNCATE只能删除表中的全部数据*/
TRUNCATE shop.ProductType;

/*DELETE 删除指定对象*/
DELETE FROM shop.ProductType
	WHERE product_type = '衣服';
    
/*UPDATE 数据的更新*/
UPDATE shop.Product
	SET regist_date = '2009-10-10';

/*搜索型UPDATE*/
UPDATE shop.Product
	SET sale_price = sale_price * 10
  WHERE product_type = '厨房用具';
  
-- TRUNCATE shop.Product;

/*多列更新*/
UPDATE shop.Product
	SET sale_price = sale_price * 10,
		purchase_price = purchase_price / 2
  WHERE product_type = '厨房用具';

/*创建视图
  避免创建多重视图，因为会降低SQL的性能
*/
CREATE VIEW shop.ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
	FROM shop.Product
  GROUP BY product_type;

/*使用视图*/
SELECT product_type, cnt_product
	FROM shop.ProductSum;
    
/*删除视图*/
-- DROP VIEW








