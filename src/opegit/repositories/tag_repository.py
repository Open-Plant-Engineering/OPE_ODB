from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class TagRepository:

    @staticmethod
    def tag_exists(
        tag_name: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select tag_exists(%s);
                    """,
                    (tag_name,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_tag(
        tag_hash: str,
        target_hash: str,
        tag_name: str,
        tagger_name: str,
        tagger_email: str,
        tag_message: str,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_tag(
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        tag_hash,
                        target_hash,
                        tag_name,
                        tagger_name,
                        tagger_email,
                        tag_message,
                    ),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_tag(
        tag_name: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_tag(%s);
                    """,
                    (tag_name,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def delete_tag(
        tag_name: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_tag(%s);
                    """,
                    (tag_name,),
                )

            conn.commit()

    @staticmethod
    def list_tags() -> list[tuple[str, str]]:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from list_tags();
                    """
                )

                rows = cur.fetchall()

        return rows