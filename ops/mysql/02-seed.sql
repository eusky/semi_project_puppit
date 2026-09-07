-- Development reference data. Conditions and regions are development samples.
SET NAMES utf8mb4;
INSERT INTO product_category (category_id, category_name) VALUES
  (1, '사료'), (2, '간식'), (3, '외출용품'), (4, '기타용품');
INSERT INTO product_status (status_id, status_code, status_name) VALUES
  (1, 'SALE', '판매중'), (2, 'RESERVED', '예약중'), (3, 'SOLD', '판매완료');
INSERT INTO product_condition (condition_id, condition_code, condition_name) VALUES
  (1, 'NEW', '새 상품'), (2, 'LIKE_NEW', '거의 새 상품'),
  (3, 'GOOD', '사용감 적음'), (4, 'USED', '사용감 있음');
INSERT INTO location (location_id, region) VALUES
  (1, '서울'), (2, '경기'), (3, '인천'), (4, '부산'), (5, '기타');
