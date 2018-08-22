select departs_name, managers_fio, sales_sum_all
from
(
    select departs.name as departs_name,
           managers.fio as managers_fio,
           nvl(sum(sales.summa), 0) as sales_sum_all,
           row_number() over (partition by departs.name order by nvl(sum(sales.summa), 0) desc) row_num
    from managers 
        inner join departs
            on managers.depart  = departs.id
        inner join  sales
            on sales.manager = managers.id
    group by departs.name, managers.fio
)
where row_num < 4;
