create or replace table `{{ project_id }}.gold.client_ltv` as
select client_id,
       extract(month from first_fee_date) as cohort_month,
       extract(year from first_fee_date) as cohort_year,
       sum(case when month_number <=1 then fee_amount else 0 end) as ltv_1m,
       sum(case when month_number <=3 then fee_amount else 0 end) as ltv_3m,
       sum(case when month_number <=6 then fee_amount else 0 end) as ltv_6m
  from `{{ project_id }}.silver.fees_clean`
 group by client_id, cohort_month, cohort_year;