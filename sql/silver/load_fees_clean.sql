create or replace table `{{ project_id }}.silver.fees_clean` as

with dedup as (
    select client_id,
           client_nino,
           adviser_id,
           fee_date,
           fee_amount,
           min(fee_date) over(partition by client_id) as first_fee_date
     from `{{ project_id }}.bronze.fees_raw`
     qualify row_number() over(partition by client_id, client_nino, adviser_id, fee_date, cast(fee_amount as numeric) order by fee_date) = 1
)

select client_id,
       to_hex(md5(client_nino)) as client_nino_hash,
       adviser_id,
       fee_date,
       fee_amount,
       first_fee_date,
       date_diff(fee_date, first_fee_date, month) + 1 as month_number
 from dedup;