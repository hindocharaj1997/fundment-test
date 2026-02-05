load data overwrite `fundment-datalake.raw.fees_raw`
from files (
  skip = 1,
  format = 'CSV',
  uris = ['gs://fundment-datalake/raw/synthetic_fees_1024_0925.csv']
);