from opegit.services.conflict_resolution_service import (
    ConflictResolutionService,
)


def test_resolve_ours() -> None:

    conflicts = [
        (100, 1),
        (100, 2),
    ]

    result = (
        ConflictResolutionService.resolve(
            conflicts,
            "OURS",
        )
    )

    assert result["strategy"] == "OURS"

    assert len(
        result["resolved"]
    ) == 2


def test_resolve_theirs() -> None:

    conflicts = [
        (100, 1),
    ]

    result = (
        ConflictResolutionService.resolve(
            conflicts,
            "THEIRS",
        )
    )

    assert result["strategy"] == "THEIRS"


def test_resolve_manual() -> None:

    conflicts = [
        (100, 1),
    ]

    result = (
        ConflictResolutionService.resolve(
            conflicts,
            "MANUAL",
        )
    )

    assert result["strategy"] == "MANUAL"