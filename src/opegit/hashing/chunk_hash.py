from __future__ import annotations

import hashlib


class ChunkHash:

    @staticmethod
    def calculate(
        data_type_id: int,
        value: str,
    ) -> str:

        content = f"{data_type_id}:{value}"

        return hashlib.sha256(
            content.encode("utf-8")
        ).hexdigest()