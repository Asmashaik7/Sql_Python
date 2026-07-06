-- dense_rank() over(partition by deptid order by salary desc) as rnk
-- What PARTITION BY does:

-- It splits your data into separate groups (partitions) — one group per department — and then the ranking restarts from 1 inside each group, independently.

--So instead of one global ranking across all 5 employees, 
-- Without PARTITION BY
-- → ranking is global — one continuous ranking across the entire table, ignoring departments completely.
-- With PARTITION BY deptid 
--→ SQL Server first splits the data into separate groups (one per department), and the ranking restarts from 1 independently inside each group.

