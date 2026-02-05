create or replace table `{{ project_id }}.gold.adviser_ltv` as
select adviser_id,
       sum(fee_amount) as total_6m_ltv
  from `{{ project_id }}.silver.fees_clean`
 where month_number <= 6
 group by adviser_id;