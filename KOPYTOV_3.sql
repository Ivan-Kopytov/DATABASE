-- Создание таблицы и начальных данных
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (
    id SERIAL PRIMARY KEY,
    val INT
);
INSERT INTO test_table (val) VALUES (100), (200), (300);

-- Кейс 1: Грязное чтение (dirty read)
-- В PostgreSQL этот кейс невозможен из-за отсутствия уровня изоляции READ UNCOMMITTED.

-- Кейс 2: Неповторяемое чтение (non-repeatable read)
-- Демонстрация на уровне изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT val FROM test_table WHERE id = 1; -- val=100
-- В отдельной сессии выполнить:
-- UPDATE test_table SET val = val + 50 WHERE id = 1; COMMIT;
SELECT val FROM test_table WHERE id = 1; -- val=150, данные изменились в той же транзакции
COMMIT;

-- Исправление на уровне REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT val FROM test_table WHERE id = 1; -- val=100
-- В отдельной сессии выполнить:
-- UPDATE test_table SET val = val + 50 WHERE id = 1; COMMIT;
SELECT val FROM test_table WHERE id = 1; -- всё ещё val=100, транзакция видит свой снимок
COMMIT;

-- Кейс 3: Фантомное чтение (phantom read)
-- Демонстрация на уровне REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT val FROM test_table WHERE val > 100; -- 200, 300
-- В отдельной сессии выполнить:
-- INSERT INTO test_table (val) VALUES (250); COMMIT;
SELECT val FROM test_table WHERE val > 100; -- PostgreSQL не покажет 250 в REPEATABLE READ
COMMIT;

-- Исправление на уровне SERIALIZABLE
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT val FROM test_table WHERE val > 100; -- 200, 300
-- В отдельной сессии выполнить:
-- INSERT INTO test_table (val) VALUES (250); COMMIT;
SELECT val FROM test_table WHERE val > 100; -- Новая строка либо не будет видна, либо ошибка сериализации
COMMIT;
