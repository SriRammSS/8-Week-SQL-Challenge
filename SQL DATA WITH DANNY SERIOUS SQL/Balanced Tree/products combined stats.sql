WITH product_nameT AS (
	SELECT  a.txn_id, b.product_name
    FROM balanced_tree.sales a
    JOIN balanced_tree.product_details b ON a.prod_id = b.product_id)

SELECT a.product_name AS prodOne , b.product_name AS prodTwo, c.product_name AS prodThree, COUNT(*) AS timesCombined
FROM product_nameT a
JOIN product_nameT b ON a.txn_id = b.txn_id
AND a.product_name <> b.product_name
AND a.product_name < b.product_name
JOIN product_nameT c ON a.txn_id = c.txn_id
	AND c.product_name <> a.product_name
	AND c.product_name <> b.product_name
	AND a.product_name < c.product_name
	AND b.product_name < c.product_name
	GROUP BY 1,2,3
	ORDER BY 4 DESC
    LIMIT 1;