load data overwrite `{{ project_id }}.bronze.fees_raw`
from files (
  skip_leading_rows = 1,
  format = 'CSV',
  uris = ['gs://fundment-datalake/raw/synthetic_fees_1024_0925.csv']
);