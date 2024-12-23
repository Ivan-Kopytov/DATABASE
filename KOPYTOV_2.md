                                                             QUERY PLAN                                                             
------------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on data_table  (cost=1445.66..10363.40 rows=104316 width=27) (actual time=21.368..34.270 rows=102000 loops=1)
   Recheck Cond: ((group_id >= 50) AND (group_id <= 100))
   Heap Blocks: exact=2765
   ->  Bitmap Index Scan on idx_group_id  (cost=0.00..1419.59 rows=104316 width=0) (actual time=20.471..20.472 rows=102000 loops=1)
         Index Cond: ((group_id >= 50) AND (group_id <= 100))
 Planning Time: 2.136 ms
 Execution Time: 39.827 ms
(7 rows)



                                                             QUERY PLAN                                                             
------------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on test_table  (cost=1418.41..11190.98 rows=102438 width=32) (actual time=25.935..38.443 rows=101000 loops=1)
   Recheck Cond: ((category >= 100) AND (category <= 200))
   Heap Blocks: exact=1671
   ->  Bitmap Index Scan on idx_category  (cost=0.00..1392.81 rows=102438 width=0) (actual time=25.158..25.158 rows=101000 loops=1)
         Index Cond: ((category >= 100) AND (category <= 200))
 Planning Time: 4.237 ms
 Execution Time: 44.820 ms
(7 rows)
