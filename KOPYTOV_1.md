# Вероятность коллизий в 32-битном пространстве хэшей для 2 миллионов ключей

Предположим, что \(M = 2^{32}\), то есть у нас имеется 4,294,967,296 возможных хэш-значений. Для \(N = 2,000,000\) уникальных ключей вероятность возникновения коллизий можно рассчитать с помощью следующей формулы (аналог задачи о совпадении дней рождения):

\[
P(\text{коллизия}) = 1 - \exp\left(-\frac{N \cdot (N - 1)}{2 \cdot M}\right)
\]

### Подстановка значений
- \(N = 2,000,000\)
- \(M = 2^{32} = 4,294,967,296\)

Вычисления:
1. Значение \(N \cdot (N - 1)\) составляет около \(4 \cdot 10^{12}\).
2. Делим это на \(2 \cdot M\), где \(M \approx 8.58 \cdot 10^{9}\), и получаем результат около 466.2.
3. Экспонента от \(-466.2\) (\(\exp(-466.2)\)) практически равна 0.

### Итог
Вероятность хотя бы одной коллизии становится близкой к 1:

\[
P(\text{коллизия}) \approx 1
\]

### Вывод
При использовании Bloom-фильтра с 32-битным хэшированием и вставке 2 миллионов уникальных ключей коллизии практически неизбежны из-за ограниченного пространства хэшей.


### Компиляция
CREATE EXTENSION
DROP TABLE
CREATE TABLE
INSERT 0 100000
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
    index_label    | index_size 
-------------------+------------
 idx_one_int_btree | 2208 kB
 idx_one_int_hash  | 4112 kB
 idx_one_int_bloom | 992 kB
 idx_one_int_gist  | 4392 kB
(4 rows)

CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
    index_label     | index_size 
--------------------+------------
 idx_two_text_btree | 3104 kB
 idx_two_text_hash  | 4112 kB
 idx_two_text_bloom | 992 kB
 idx_two_text_gist  | 5880 kB
(4 rows)

CREATE INDEX
CREATE INDEX
CREATE INDEX
     index_label      | index_size 
----------------------+------------
 idx_three_comb_btree | 3104 kB
 idx_three_comb_bloom | 992 kB
 idx_three_comb_gist  | 7952 kB
(3 rows)

CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
     index_label     | index_size 
---------------------+------------
 idx_four_expr_btree | 3104 kB
 idx_four_expr_hash  | 4112 kB
 idx_four_expr_bloom | 992 kB
 idx_four_expr_gist  | 5880 kB
(4 rows)
