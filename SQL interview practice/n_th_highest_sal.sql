-- DENSE_RANK() window function
-- This solves it in one query, regardless of whether you want 2nd, 5th, or 10th highest
CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary INT
);

INSERT INTO Employee VALUES
(1, 'Joe', 70000),
(2, 'Henry', 80000),
(3, 'Sam', 70000),
(4, 'Max', 90000);

select name, salary
from (

)tab_rank
where rnk=2

--this can act like an outer query. rnk will be findout in inner query using window func-dense rank

select name, salary
from (
        selct name, salary,
        dense_rank over(order by salary desc) as rnk
        from employee

    )tab_rank
    where rnk=2
    --ERROR:dense_rank over(...) → should be dense_rank() over (...) — you're missing the empty parentheses () right after dense_rank. Even though DENSE_RANK doesn't take any arguments, SQL Server still requires the () to recognize it as a function call.


select name, salary
from (
        select name, salary,
        dense_rank() over(order by salary desc) as rnk
        from employee

    )tab_rank
    where rnk=2

--Result:
-- name                                               salary     
-- -------------------------------------------------- -----------
-- Henry                                                    80000