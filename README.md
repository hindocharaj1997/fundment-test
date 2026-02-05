Lead Data Engineer – Take-Home Exercise

Overview

Fundment is a fast-growing wealth infrastructure company, building on our cutting-edge digital investment system to transform the £3 trillion UK wealth management market. We are passionate about revolutionising the investment experience for financial advisers and their clients by combining our innovative proprietary technology with exceptional customer service.

A key part of that is a data architecture where data correctness, trust, and transparency are foundational. Our data platform will support product decisions, financial reporting, and regulatory-adjacent workflows.

This exercise is designed to reflect the kind of work you would do as our Lead Data Engineer, building our data engineering function from the ground up.

We are not looking for a perfect or exhaustive solution. We are looking for sound engineering judgment, clear data modelling, and thoughtful communication.

⸻
Time Expectation
Please expect this exercise to take around 4-6 hours. Make sure to scope the work and focus on what you think is most important.

We explicitly value:
	•	Clear assumptions
	•	Good tradeoffs
	•	Simplicity over over-engineering

⸻
The Problem
You are given a dataset representing platform fees paid by clients over time.

Your task is to design and implement a simple, production-minded batch analytics pipeline on Google Cloud Platform (GCP) that:
	•	Ingests the raw data
	•	Stores it safely
	•	Transforms it into analytics-ready models
	•	Answers a small set of business questions using SQL

Assume this data will be used for:
	•	Business reporting
	•	Adviser performance analysis
	•	Financial oversight and trust-sensitive use cases

⸻
Dataset
The dataset is provided in the data/ directory as a CSV file.

Schema
client_id    STRING
client_nino	 STRING
adviser_id   STRING
fee_date     DATE
fee_amount   NUMERIC

Notes:
	•	A client may pay multiple fees per month
	•	A client may change advisers over time
	•	Data may contain duplicates or corrections
	•	Not all clients pay fees every month

You may make reasonable assumptions as needed, but please document them.

⸻
Technical Requirements
Infrastructure (Terraform + GCP)
Use Terraform to provision the minimum required infrastructure on GCP, that allows you to store and analyse data.

Guidelines:
	•	Keep Terraform minimal and readable
	•	Use variables where appropriate
	•	Assume this could later be extended to CI/CD
	•	You may use your own GCP account; please keep costs minimal

⸻
Data Pipeline
Design a simple batch pipeline that:
Ingests the raw CSV to GCP platform
Transforms it into one or more analytics-ready tables using SQL

Guidelines:
	•	Pipelines should be idempotent (safe to rerun)
	•	Clearly separate raw data from transformed data
	•	Prefer SQL-based transformations
	•	Focus on correctness and clarity

The analytics-ready tables should be able to answer the following questions:
	•	What are the lifetime value (LTV), i.e. the accumulated fees, at 1, 3 and 6 months for each client, measured from the client’s first fee date?
	•	What is the 6-month LTV for the January and February cohorts of the current year? (A cohort is defined by the month in which a client first paid a fee)
	•	Which adviser has the highest total client LTV over the first 6 months of each client’s lifetime?

Please document how you attribute client LTV to advisers.

⸻
Deliverables
Please submit a GitHub repository (or zip file) containing:
README.md                # This file, updated with your notes
terraform/               # Terraform configuration
sql/                     # SQL models and/or queries
scripts/ (optional)      # Any helper scripts you use

⸻
Quick Start

Prerequisites: GCP account, Terraform, bq CLI, Python 3.9+

1. Set up infrastructure:
```bash
cd terraform/
gcloud auth application-default login --impersonate-service-account=<service_account>@<project_id>.iam.gserviceaccount.com
terraform init
terraform plan
terraform apply
```

2. Run the pipeline:
```bash
python3 scripts/run_pipeline.py
```

See [SOLUTION.md]([url](https://github.com/hindocharaj1997/fundment-test/blob/main/SOLUTION.md)) for architecture, data model, assumptions, and production roadmap.

⸻
README Expectations
Please update this README to include:
	•	A short description of your architecture
	•	Your data modelling approach
	•	Key assumptions and tradeoffs
	•	How you would evolve this into a production-grade, trustworthy fintech data platform
	•	Auditing and reconciliation
	•	Backfills and reprocessing
	•	Schema changes
	•	Data quality checks

Diagrams are welcome but not required.

⸻
What We’re Evaluating
We will evaluate submissions based on:
	•	Engineering judgment
	•	Data modelling fundamentals
	•	SQL correctness and readability
	•	Terraform clarity
	•	Trust, safety and data-quality awareness
	•	Communication and documentation

We care more about how you think than how much you build.

⸻
What’s Out of Scope
You do not need to:
	•	Build dashboards or visualisations
	•	Implement streaming ingestion
	•	Set up CI/CD pipelines
	•	Optimise for very large scale

⸻
Follow-Up Discussion
In the follow-up interview, we will:
	•	Walk through your solution together
	•	Discuss tradeoffs and assumptions
	•	Explore how you would build and scale the data architecture at Fundment
	•	Talk about operating data systems in a trust-sensitive fintech environment

⸻
Final Notes
This exercise is intended to be collaborative, not adversarial.

If something is ambiguous, make a reasonable assumption and document it.
If you choose not to implement something, explain why.

Thank you for your time and effort. We appreciate it!
