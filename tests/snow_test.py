import pytest
from snowflake.snowpark import Session
from snowflake.snowpark.functions import col


@pytest.fixture(scope="module")
def session():
    local_session = Session.builder.config("local_testing", True).create()
    yield local_session
    local_session.close()


def test_create_dataframe(session):
    dataframe = session.create_dataframe(
        [[1, "Ada"], [2, "Grace"]], schema=["id", "name"]
    )

    rows = dataframe.collect()

    assert len(rows) == 2
    assert [row["ID"] for row in rows] == [1, 2]
    assert [row["NAME"] for row in rows] == ["Ada", "Grace"]


def test_add_computed_column(session):
    dataframe = session.create_dataframe([[1, 2], [3, 4]], schema=["left", "right"])

    rows = dataframe.with_column("total", col("left") + col("right")).collect()

    assert [row["TOTAL"] for row in rows] == [3, 7]
