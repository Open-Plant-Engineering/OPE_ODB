from __future__ import annotations

import hashlib
import json


class TreeHash:

    @staticmethod
    def calculate(
        entries: list[dict],
    ) -> str:

        normalized = json.dumps(
            entries,
            sort_keys=True,
            separators=(",", ":"),
        )

        return hashlib.sha256(
            normalized.encode("utf-8")
        ).hexdigest()