-- Удаляем таблицу, если она существует
DROP TABLE IF EXISTS test_table;

-- Создаём таблицу
CREATE TABLE test_table (
    id SERIAL PRIMARY KEY,
    category INT,
    payload TEXT
);

-- Заполняем таблицу данными
INSERT INTO test_table (category, payload)
SELECT (i % 1000) + 1, 'example text data ' || i
FROM generate_series(1, 1000000) AS i;

-- Создаём индекс на столбце category
CREATE INDEX idx_category ON test_table(category);

-- Анализируем таблицу для сбора статистики
ANALYZE test_table;

-- Первый запрос с EXPLAIN ANALYZE
EXPLAIN ANALYZE SELECT * FROM test_table WHERE category BETWEEN 100 AND 200;

-- Отключаем автоматическое переанализирование
ALTER SYSTEM SET autovacuum = off;
SELECT pg_reload_conf();

-- Изменяем содержимое таблицы
UPDATE test_table SET category = 500 WHERE id <= 500000;

-- Второй запрос с EXPLAIN ANALYZE после изменения данных
EXPLAIN ANALYZE SELECT * FROM test_table WHERE category BETWEEN 100 AND 200;
