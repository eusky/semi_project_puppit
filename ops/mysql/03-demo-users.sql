-- Local development only. All three passwords: Puppit123!
-- SecureUtil: PBKDF2WithHmacSHA256, 65536 iterations, 256 bits, Base64.
-- Re-running preserves existing accounts and their balances/passwords.
SET NAMES utf8mb4;
INSERT INTO user (account_id, user_name, nick_name, user_password, user_email, user_phone, created_at, salt, point, is_deleted)
SELECT 'test01', '테스트구매자', '샘플구매자', 'h6VW/ehSajekJMpnHT1OZXFLXgspLY3UYHXGLK/aPM8=', 'test01@example.com', '01000000001', NOW(), UNHEX('357962E7F16178B9448029296011213B'), 10000, 0
WHERE NOT EXISTS (SELECT 1 FROM user WHERE account_id = 'test01');
INSERT INTO user (account_id, user_name, nick_name, user_password, user_email, user_phone, created_at, salt, point, is_deleted)
SELECT 'test02', '테스트판매자', '샘플판매자', 'v7r+UogkADD2RvnIpgmXxBpCG9pbSi52UNhUGSbtLQI=', 'test02@example.com', '01000000002', NOW(), UNHEX('E0032534F9B0E64A334AD1A2DAF0E763'), 10000, 0
WHERE NOT EXISTS (SELECT 1 FROM user WHERE account_id = 'test02');
INSERT INTO user (account_id, user_name, nick_name, user_password, user_email, user_phone, created_at, salt, point, is_deleted)
SELECT 'test03', '테스트회원', '샘플회원', 'OHnpC/OqgNMUniUOgl8NWDwvb2hLtXyfKKA8I68C5lw=', 'test03@example.com', '01000000003', NOW(), UNHEX('6B32C7FD8A8409CD33864329FBC47EF7'), 10000, 0
WHERE NOT EXISTS (SELECT 1 FROM user WHERE account_id = 'test03');
