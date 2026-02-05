import os
from google.cloud import bigquery

PROJECT_ID = os.environ.get("PROJECT_ID", "pocs19")

SQL_FILES = [
    "sql/bronze/load_fees_raw.sql",
    "sql/silver/load_fees_clean.sql",
    "sql/gold/load_client_ltv.sql",
    "sql/gold/load_adviser_ltv.sql"
]

DQ_FILE = "sql/dq/data_quality_checks.sql"


def load_sql(file_path: str) -> str:
    """
    Docstring for load_sql
    
    :param file_path: Description
    :type file_path: str
    :return: Description
    :rtype: str
    """
    with open(file_path, "r") as f:
        sql = f.read()
    return sql.replace("{{ project_id }}", PROJECT_ID)


def run_query(client: bigquery.Client, sql: str):
    """
    Docstring for run_query
    
    :param client: Description
    :type client: bigquery.Client
    :param sql: Description
    :type sql: str
    """
    job = client.query(sql)
    job.result()


def run_dq_checks(client: bigquery.Client):
    """
    Docstring for run_dq_checks
    
    :param client: Description
    :type client: bigquery.Client
    """

    print("Running data quality checks...")
    sql = load_sql(DQ_FILE)

    # Split multiple statements
    statements = [s.strip() for s in sql.split(";") if s.strip()]
    failed_dq_count = 0

    for stmt in statements:

        dq_name = stmt.splitlines()[0].strip().lstrip("--").strip()
        print(f"Checking: {dq_name}")
        result = client.query(stmt).result()
        rows = list(result)

        # For anomaly queries, if rows returned -> fail
        if rows:
            print(f"Data Quality Check for '{dq_name}' failed for below data:")
            for row in rows:
                print(dict(row))
            failed_dq_count += 1

    print(f"Data Quality checks completed with {len(statements) - failed_dq_count} out of {len(statements)} checks passed.")


def main():

    client = bigquery.Client(project=PROJECT_ID)

    print("Starting pipeline...")

    # Run transformations
    for file in SQL_FILES:
        print(f"Running {file}")
        sql = load_sql(file)
        run_query(client, sql)

    # Run DQ checks
    run_dq_checks(client)

    print("Pipeline completed successfully")


if __name__ == "__main__":
    main()