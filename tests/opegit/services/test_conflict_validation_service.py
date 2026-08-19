from opegit.repositories.element_repository import (
    ElementRepository,
)

from opegit.repositories.manifest_repository import (
    ManifestRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.conflict_validation_service import (
    ConflictValidationService,
)


def test_validate_success() -> None:

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    ElementRepository.create_element(
        100,
        1,
    )

    manifest_id = (
        ManifestRepository.create_manifest(
            "1" * 64
        )
    )

    TreeRepository.add_tree_entry(
        tree_hash,
        100,
        1,
        manifest_id,
    )

    ConflictValidationService.validate(
        tree_hash,
        100,
        1,
        manifest_id,
    )


def test_validate_conflict() -> None:

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    ElementRepository.create_element(
        200,
        1,
    )

    manifest_id = (
        ManifestRepository.create_manifest(
            "2" * 64
        )
    )

    TreeRepository.add_tree_entry(
        tree_hash,
        200,
        1,
        manifest_id,
    )

    try:

        ConflictValidationService.validate(
            tree_hash,
            200,
            1,
            99999,
        )

        assert False

    except ValueError:

        assert True