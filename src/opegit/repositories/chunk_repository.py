from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class ChunkRepository:
    """
    Database access layer for chunk operations.
    """

    @staticmethod
    def get_chunk_by_hash(
        chunk_hash: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_chunk_by_hash(%s);
                    """,
                    (chunk_hash,),
                )

                row = cur.fetchone()

        return row[0] if row and row[0] is not None else None

    @staticmethod
    def get_chunk_by_value(
        data_type_id: int,
        string_value: str | None = None,
        integer_value: int | None = None,
        numeric_value: float | None = None,
        real_value: float | None = None,
        boolean_value: bool | None = None,
        date_value=None,
        time_value=None,
        datetime_value=None,
        interval_value=None,
        uuid_value=None,
        jsonb_value=None,
        binary_value: bytes | None = None,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_chunk_by_value(
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        data_type_id,
                        string_value,
                        integer_value,
                        numeric_value,
                        real_value,
                        boolean_value,
                        date_value,
                        time_value,
                        datetime_value,
                        interval_value,
                        uuid_value,
                        jsonb_value,
                        binary_value,
                    ),
                )

                row = cur.fetchone()

        return row[0] if row and row[0] is not None else None

    @staticmethod
    def create_chunk(
        chunk_hash: str,
        data_type_id: int,
        string_value: str | None = None,
        integer_value: int | None = None,
        numeric_value: float | None = None,
        real_value: float | None = None,
        boolean_value: bool | None = None,
        date_value=None,
        time_value=None,
        datetime_value=None,
        interval_value=None,
        uuid_value=None,
        jsonb_value=None,
        binary_value: bytes | None = None,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_chunk(
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        chunk_hash,
                        data_type_id,
                        string_value,
                        integer_value,
                        numeric_value,
                        real_value,
                        boolean_value,
                        date_value,
                        time_value,
                        datetime_value,
                        interval_value,
                        uuid_value,
                        jsonb_value,
                        binary_value,
                    ),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_or_create_chunk(
        chunk_hash: str,
        data_type_id: int,
        string_value: str | None = None,
        integer_value: int | None = None,
        numeric_value: float | None = None,
        real_value: float | None = None,
        boolean_value: bool | None = None,
        date_value=None,
        time_value=None,
        datetime_value=None,
        interval_value=None,
        uuid_value=None,
        jsonb_value=None,
        binary_value: bytes | None = None,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_or_create_chunk(
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        chunk_hash,
                        data_type_id,
                        string_value,
                        integer_value,
                        numeric_value,
                        real_value,
                        boolean_value,
                        date_value,
                        time_value,
                        datetime_value,
                        interval_value,
                        uuid_value,
                        jsonb_value,
                        binary_value,
                    ),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_chunk(
        chunk_hash: str,
    ) -> tuple | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from get_chunk(%s);
                    """,
                    (chunk_hash,),
                )

                row = cur.fetchone()

        return row