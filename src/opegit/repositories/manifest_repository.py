from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class ManifestRepository:

    @staticmethod
    def manifest_exists(
        manifest_hash: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select manifest_exists(%s);
                    """,
                    (manifest_hash,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def get_manifest_id(
        manifest_hash: str,
    ) -> int | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_manifest_id(%s);
                    """,
                    (manifest_hash,),
                )

                row = cur.fetchone()

        return row[0] if row and row[0] is not None else None

    @staticmethod
    def create_manifest(
        manifest_hash: str,
    ) -> int:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_manifest(%s);
                    """,
                    (manifest_hash,),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_or_create_manifest(
        manifest_hash: str,
    ) -> int:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_or_create_manifest(%s);
                    """,
                    (manifest_hash,),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def add_manifest_entry(
        manifest_id: int,
        attribute_id: int,
        chunk_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select add_manifest_entry(
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        manifest_id,
                        attribute_id,
                        chunk_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_manifest_entry(
        manifest_id: int,
        attribute_id: int,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_manifest_entry(
                        %s,
                        %s
                    );
                    """,
                    (
                        manifest_id,
                        attribute_id,
                    ),
                )

                row = cur.fetchone()

        return row[0] if row and row[0] is not None else None

    @staticmethod
    def get_manifest_entries(
        manifest_id: int,
    ) -> list[tuple[int, str]]:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from get_manifest_entries(%s);
                    """,
                    (manifest_id,),
                )

                rows = cur.fetchall()

        return rows

    @staticmethod
    def delete_manifest_entry(
        manifest_id: int,
        attribute_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_manifest_entry(
                        %s,
                        %s
                    );
                    """,
                    (
                        manifest_id,
                        attribute_id,
                    ),
                )

            conn.commit()