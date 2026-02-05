-- Null checks
select *
  from `{{ project_id }}.silver.fees_clean`
 where client_id is null
    or adviser_id is null
    or fee_date is null
    or fee_amount is null;

-- Negative or zero fees
select *
  from `{{ project_id }}.silver.fees_clean`
 where fee_amount <= 0;

-- Duplicate detection (should return zero rows)
select client_id,
       adviser_id,
       fee_date,
       fee_amount,
       count(*) AS cnt
  from `{{ project_id }}.silver.fees_clean`
 group by client_id, adviser_id, fee_date, fee_amount
having count(*) > 1;