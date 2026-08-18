from __future__ import annotations

from opegit.services.diff_service import (
    DiffService,
)


class ThreeWayMergeService:

    @staticmethod
    def merge_analysis(
        ancestor_commit: str,
        source_commit: str,
        target_commit: str,
    ) -> dict:

        ancestor_to_source = (
            DiffService.diff_commits(
                ancestor_commit,
                source_commit,
            )
        )

        ancestor_to_target = (
            DiffService.diff_commits(
                ancestor_commit,
                target_commit,
            )
        )

        source_modified = set(
            ancestor_to_source["modified"]
        )

        target_modified = set(
            ancestor_to_target["modified"]
        )

        conflicts = sorted(
            source_modified
            & target_modified
        )

        return {
            "has_conflicts": len(conflicts) > 0,
            "conflicts": conflicts,
            "source_changes": ancestor_to_source,
            "target_changes": ancestor_to_target,
        }