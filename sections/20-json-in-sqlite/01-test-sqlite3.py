# see https://medium.com/@george.pearse/how-to-start-learning-sql-with-streamlit-d3edad7494cd
# streamlit run 01-test-sqlite3.py

import os
import sqlite3
import streamlit as st
import pandas as pd

# create SQLite database file 'sqlite.db', if not in the data/ folder,
# and upload employees.csv file into a new 'employees' table
db_filename = '../../data/sqlite.db'
if not os.path.exists(db_filename):
    df = pd.read_csv('../../data/employees.csv')
    conn = sqlite3.connect(db_filename)
    df.to_sql(name='employees', con=conn)

# query all 'employees' table by default
# and dump content on screen
sql = "select * from employees"
query = st.text_area("SQL Query", value=sql)
conn = sqlite3.connect(db_filename)
cursor = conn.execute(query)

res = pd.DataFrame.from_records(
    data=cursor.fetchall(),
    columns = [column[0] for column in cursor.description])
st.dataframe(res)
