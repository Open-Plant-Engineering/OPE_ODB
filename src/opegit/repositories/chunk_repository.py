from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class ChunkRepository:
    """
    Database access layer for chunk operations.
    """

    @staticmethod
    def get_chunk_by_hash(
        chunk_hash: str,
    ) -> int | None:

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