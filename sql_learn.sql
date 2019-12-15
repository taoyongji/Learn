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
INSERT INTO shop.Product VALUES('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO shop.Product VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO shop.Product VALUES('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO shop.Product VALUES('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO shop.Product VALUES('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO shop.Product VALUES('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO shop.Product VALUES('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO shop.Product VALUES('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
COMMIT;
-- ROLLBACN;

-- DELETE FROM shop.Product;

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

/*子查询*/
SELECT product_type, cnt_product
	FROM (
		SELECT product_type, COUNT(*) AS cnt_product
			FROM shop.Product
		  GROUP BY product_type
    ) AS ProductSum;

/*标量子查询使用*/
SELECT product_id, product_name, sale_price
	FROM shop.Product
  WHERE sale_price > (SELECT AVG(sale_price)
					  FROM shop.Product);

/*关联子查询*/
SELECT product_type, product_name, sale_price
	FROM shop.Product AS p1
  WHERE sale_price > (SELECT AVG(sale_price)
						FROM shop.Product AS p2
					  WHERE p1.product_type = p2.product_type
						GROUP BY product_type);

/*函数 算数函数(用来进行数值计算)
	   字符串函数(用来进行字符串操作)
       日期函数(用来进行日期操作)
       转换函数(用来转换数据类型和值)
       聚合函数(用来进行数据聚合)
*/
/*算数函数*/
CREATE TABLE shop.SampleMath(
	m NUMERIC(10, 3),
    n INTEGER,
    p INTEGER
);

START TRANSACTION;
INSERT INTO shop.SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO shop.SampleMath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO shop.SampleMath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO shop.SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (5.555, 2, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO shop.SampleMath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT;

-- SELECT * FROM shop.SampleMath;

/*ABS() 绝对值*/
SELECT m, ABS(M) AS abs_col
	FROM shop.SampleMath;

/*MOD()  求余 = n/p  */
SELECT n, p, MOD(n, p) AS mod_col
	FROM shop.SampleMath;

/*ROUND(对象数值,保留小数位数) 四舍五入*/
SELECT m, n, ROUND(m, n) AS round_col
	FROM shop.SampleMath;

/*字符串函数*/
CREATE TABLE shop.SampleStr(
	str1 VARCHAR(40),
	str2 VARCHAR(40),
	str3 VARCHAR(40)
);

START TRANSACTION;
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('opx', 'rt', null);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('abc', 'def', NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('陶', '泳吉', '是我');
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('aaa', NULL, NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES(NULL, 'xyz', NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('@!#$%', NULL, NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('ABC', NULL, NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('aBC', NULL, NULL);
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('abc泳吉', 'abc', 'ABC');
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('abcdefabc', 'abc', 'ABC');
INSERT INTO shop.SampleStr(str1, str2, str3) VALUES('micmic', 'i', 'I');
COMMIT;

/*CONCAT() 拼接*/
SELECT str1, str2, str3, CONCAT(str1, str2, str3) AS str_concat
	FROM shop.SampleStr;
    
/*LENGTH() 计算长度*/
SELECT str1, LENGTH(str1) AS len_str
	FROM shop.SampleStr;

/*LOWER() 小写转换*/
/*UPPER() 大写转换*/

/*REPLACE(对象字符串, 需替换的字符串, 替换字符串) 字符串替换*/

/*SUBSTRING(对象字符串 FROM 截取的起始位置 FOR 截取的字符数) 字符串的截取*/

/*日期函数*/
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;
/*EXTRACT(日期元素 FROM 日期) 截取日期函数*/
SELECT CURRENT_TIMESTAMP,
	EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
    EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
    EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
    EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
    EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
    EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;
    
/*转换函数*/
/*CAST(转换前的值 AS 想要转换的数据类型) 类型转换*/
SELECT CAST('001' AS SIGNED INTEGER) AS int_col;

/*谓词*/

CREATE TABLE shop.SampleLike(
	strcol VARCHAR(6) NOT NULL,
    PRIMARY KEY(strcol)
);

START TRANSACTION;
INSERT INTO shop.SampleLike(strcol) VALUES('abcddd');
INSERT INTO shop.SampleLike(strcol) VALUES('dddabc');
INSERT INTO shop.SampleLike(strcol) VALUES('abdddc');
INSERT INTO shop.SampleLike(strcol) VALUES('abcdd');
INSERT INTO shop.SampleLike(strcol) VALUES('ddabc');
INSERT INTO shop.SampleLike(strcol) VALUES('abddc');
COMMIT;

/*模式匹配
  %代表"0字符以上的任意字符串"
  _代表"任意1个字符串"
*/
SELECT * 
	FROM shop.SampleLike
  WHERE strcol LIKE 'ddd%';

SELECT * 
	FROM shop.SampleLike
  WHERE strcol LIKE 'abc__';
  
/*BETWEEN 谓词  范围查询*/
SELECT product_name, sale_price
	FROM shop.Product
  WHERE sale_price BETWEEN 100 AND 1000;

/*IS NULL 和 IS NOT NULL -> 判断是否为NULL*/

/*IN 谓词 -> OR的简便用法
  IN -> NOT IN
*/
SELECT product_name, purchase_price
	FROM shop.Product
  WHERE purchase_price IN (320, 500, 5000);
  
/*使用子查询作为IN谓词的参数*/
CREATE TABLE shop.ShopProduct(
	shop_id CHAR(4) NOT NULL,
    shop_name VARCHAR(200) NOT NULL,
    product_id CHAR(4) NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY(shop_id, product_id)
);

START TRANSACTION;
INSERT INTO shop.ShopProduct VALUES('000A', '东京', '0001', 30);
INSERT INTO shop.ShopProduct VALUES('000A', '东京', '0002', 50);
INSERT INTO shop.ShopProduct VALUES('000A', '东京', '0003', 15);
INSERT INTO shop.ShopProduct VALUES('000B', '名古屋', '0002', 30);
INSERT INTO shop.ShopProduct VALUES('000B', '名古屋', '0003', 120);
INSERT INTO shop.ShopProduct VALUES('000B', '名古屋', '0004', 20);
INSERT INTO shop.ShopProduct VALUES('000B', '名古屋', '0006', 10);
INSERT INTO shop.ShopProduct VALUES('000B', '名古屋', '0007', 40);
INSERT INTO shop.ShopProduct VALUES('000C', '大阪', '0003', 20);
INSERT INTO shop.ShopProduct VALUES('000C', '大阪', '0004', 50);
INSERT INTO shop.ShopProduct VALUES('000C', '大阪', '0006', 90);
INSERT INTO shop.ShopProduct VALUES('000C', '大阪', '0007', 70);
INSERT INTO shop.ShopProduct VALUES('000D', '福冈', '0001', 100);
COMMIT;

SELECT product_name, sale_price
	FROM shop.Product
  WHERE product_id IN (SELECT product_id
							FROM shop.ShopProduct
						WHERE shop_id = '000C');

/*EXIST谓词   使用则为EXISTS*/
SELECT product_name, sale_price
	FROM shop.Product AS P
  WHERE EXISTS (SELECT *
					FROM shop.ShopProduct AS SP
				  WHERE SP.shop_id = '000C'
					AND SP.product_id = P.product_id);

/*CASE 表达式
  简单CASE表达式
  搜索CASE表达式
*/
SELECT product_name,
	CASE WHEN product_type = '衣服' THEN CONCAT('A:', product_type)
		 WHEN product_type = '办公用品' THEN CONCAT('B:', product_type)
		 WHEN product_type = '厨房用具' THEN CONCAT('C:', product_type)
    ELSE NULL
    END AS abc_product_type
  FROM shop.Product;
  
/*集合运算
  UNION(并集)
  INTERSECT(交集) -> MYSQL 不支持
  EXCEPT(差集) -> MYSQL 不支持
  
  ATTENTION: 1、作为运算对象的记录的列数必须相同
			 2、作为运算对象的记录中的类型必须一致
             3、可以使用任何SELECT语句，但ORDER BY子句只能在最后使用一次
*/
CREATE TABLE shop.Product2(
	product_id 		CHAR(4) 		NOT NULL,
    product_name 	VARCHAR(100) 	NOT NULL,
    product_type	VARCHAR(32)		NOT NULL,
    sale_price		INTEGER,
    purchase_price	INTEGER,
    regist_date		DATE,
    PRIMARY KEY(product_id)
);

START TRANSACTION;
INSERT INTO shop.Product2 VALUES('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO shop.Product2 VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO shop.Product2 VALUES('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO shop.Product2 VALUES('0009', '手套', '衣服', 800, 500, NULL);
INSERT INTO shop.Product2 VALUES('0010', '水壶', '厨房用具', 2000, 1700, '2009-09-20');
COMMIT;

/*UNION(并集)
  Product + Product2
*/
SELECT  product_id, product_name
	FROM shop.Product
UNION
SELECT  product_id, product_name
	FROM shop.Product2;

/*包含重复行的集合运算 ALL*/
SELECT  product_id, product_name
	FROM shop.Product
UNION ALL
SELECT  product_id, product_name
	FROM shop.Product2;

/*JOIN 联结 就是将其他表中的列添加过来，进行"添加列"的集合运算*/
/*INNER JOIN 内联结*/
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
	FROM shop.ShopProduct AS SP INNER JOIN shop.Product AS P
	  ON SP.product_id = P.product_id;
      
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
	FROM shop.ShopProduct AS SP INNER JOIN shop.Product AS P
	  ON SP.product_id = P.product_id
	WHERE SP.shop_id = '000A';

/*OUTER JOIN 外联结
  LEFT  指定左边表为主表
  RIGHT 指定右边表为主表
*/
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
	FROM shop.ShopProduct AS SP LEFT OUTER JOIN shop.Product AS P
	  ON SP.product_id = P.product_id;

/*交叉联结 CROSS JOIN (笛卡儿积)*/
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name
	FROM shop.ShopProduct AS SP CROSS JOIN shop.Product AS P;

/*窗口函数 (MYSQL 8.0支持) -> 对数据库数据进行实时分析处理
  能够作为窗口函数的聚合函数(SUM, AVG, COUNT, MIN, MAX)
  RANK, DENSE_RANK, ROW_NUMBER等专用窗口函数
*/
SELECT product_name, product_type, sale_price,
	RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS ranking,
    DENSE_RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS dense_ranking,
    ROW_NUMBER() OVER (PARTITION BY product_type ORDER BY sale_price) AS row_ranking
	FROM shop.Product;

SELECT product_id, product_name, sale_price,
    SUM(sale_price) OVER (ORDER BY product_id) AS current_sum
	FROM shop.Product;

SELECT product_id, product_name, sale_price,
    AVG(sale_price) OVER (ORDER BY product_id) AS current_sum
	FROM shop.Product;
/*计算平均移动
  指定"最靠近的3行"作为汇总对象
  PRECEDING(之前)
  FOLLOWING(之后)
*/
SELECT product_id, product_name, sale_price,
    AVG(sale_price) OVER (ORDER BY product_id ROWS 2 PRECEDING) AS current_sum
	FROM shop.Product;
    
SELECT product_id, product_name, sale_price,
    AVG(sale_price) OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS current_sum
	FROM shop.Product;

/*两个ORDER BY 子句*/
SELECT product_name, product_type, sale_price,
	RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS ranking
	FROM shop.Product
  ORDER BY ranking;

/*WITH ROLLUP 同时得到合计和小计*/
SELECT product_type, SUM(sale_price) AS sum_price
	FROM shop.Product
  GROUP BY product_type WITH ROLLUP;