from __future__ import annotations

import hashlib
import json


class CommitHash:

    @staticmethod
    def calculate(
        commit_data: dict,
    ) -> str:

        normalized = json.dumps(
            commit_data,
            sort_keys=True,
            separators=(",", ":"),
        )

        return hashlib.sha256(
            normalized.encode("utf-8")
        ).hexdigest()