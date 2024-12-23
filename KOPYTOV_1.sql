-- Подключение необходимых расширений
CREATE EXTENSION IF NOT EXISTS bloom;
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- Удаление таблицы, если она существует
DROP TABLE IF EXISTS sample_table;

-- Создание новой таблицы
CREATE TABLE sample_table (
    record_id SERIAL PRIMARY KEY,
    int_column INTEGER,
    text_column TEXT
);

-- Наполнение таблицы данными
INSERT INTO sample_table (int_column, text_column)
SELECT num, 'value ' || num::text
FROM generate_series(1, 100000) AS num;

-- Блок 1: Индексация по столбцу int_column
CREATE INDEX idx_one_int_btree ON sample_table USING btree (int_column);
CREATE INDEX idx_one_int_hash ON sample_table USING hash (int_column);
CREATE INDEX idx_one_int_bloom ON sample_table USING bloom (int_column) WITH (length=32);
CREATE INDEX idx_one_int_gist ON sample_table USING gist (int_column);

-- Проверка размеров индексов блока 1
SELECT indexrelid::regclass AS index_label, pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_index
WHERE indrelid = 'sample_table'::regclass
AND indexrelid::regclass::text LIKE '%idx_one_int%';

-- Блок 2: Индексация по столбцу text_column
CREATE INDEX idx_two_text_btree ON sample_table USING btree (text_column);
CREATE INDEX idx_two_text_hash ON sample_table USING hash (text_column);
CREATE INDEX idx_two_text_bloom ON sample_table USING bloom (text_column) WITH (length=32);
CREATE INDEX idx_two_text_gist ON sample_table USING gist (text_column);

-- Проверка размеров индексов блока 2
SELECT indexrelid::regclass AS index_label, pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_index
WHERE indrelid = 'sample_table'::regclass
AND indexrelid::regclass::text LIKE '%idx_two_text%';

-- Блок 3: Индексация по двум столбцам (int_column, text_column)
CREATE INDEX idx_three_comb_btree ON sample_table USING btree (int_column, text_column);
CREATE INDEX idx_three_comb_bloom ON sample_table USING bloom (int_column, text_column) WITH (length=32);
CREATE INDEX idx_three_comb_gist ON sample_table USING gist (int_column, text_column);

-- Проверка размеров индексов блока 3
SELECT indexrelid::regclass AS index_label, pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_index
WHERE indrelid = 'sample_table'::regclass
AND indexrelid::regclass::text LIKE '%idx_three_comb%';

-- Блок 4: Индексация выражения lower(text_column)
CREATE INDEX idx_four_expr_btree ON sample_table USING btree (lower(text_column));
CREATE INDEX idx_four_expr_hash ON sample_table USING hash (lower(text_column));
CREATE INDEX idx_four_expr_bloom ON sample_table USING bloom ((lower(text_column))) WITH (length=32);
CREATE INDEX idx_four_expr_gist ON sample_table USING gist ((lower(text_column)));

-- Проверка размеров индексов блока 4
SELECT indexrelid::regclass AS index_label, pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_index
WHERE indrelid = 'sample_table'::regclass
AND indexrelid::regclass::text LIKE '%idx_four_expr%';

