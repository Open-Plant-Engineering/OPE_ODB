from __future__ import annotations


class ConflictResolutionService:

    @staticmethod
    def resolve(
        conflicts: list[tuple[int, int]],
        strategy: str,
    ) -> dict:

        strategy = strategy.upper()

        if strategy not in (
            "OURS",
            "THEIRS",
            "MANUAL",
        ):
            raise ValueError(
                "Invalid conflict strategy."
            )

        return {
            "strategy": strategy,
            "resolved": conflicts,
        }