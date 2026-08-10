from opegit.repositories.diff_repository import (
    DiffRepository,
)

from opegit.repositories.element_repository import (
    ElementRepository,
)

from opegit.repositories.manifest_repository import (
    ManifestRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)


def test_diff_trees() -> None:

    tree_a = "a" * 64
    tree_b = "b" * 64

    TreeRepository.create_tree(tree_a)
    TreeRepository.create_tree(tree_b)

    manifest_1 = (
        ManifestRepository.create_manifest(
            "1" * 64
        )
    )

    manifest_2 = (
        ManifestRepository.create_manifest(
            "2" * 64
        )
    )

    ElementRepository.create_element(
        100,
        1,
    )

    ElementRepository.create_element(
        100,
        2,
    )

    TreeRepository.add_tree_entry(
        tree_a,
        100,
        1,
        manifest_1,
    )

    TreeRepository.add_tree_entry(
        tree_b,
        100,
        1,
        manifest_1,
    )

    TreeRepository.add_tree_entry(
        tree_b,
        100,
        2,
        manifest_2,
    )

    diff = (
        DiffRepository.diff_trees(
            tree_a,
            tree_b,
        )
    )

    assert len(diff["added"]) == 1
    assert len(diff["removed"]) == 0
    assert len(diff["modified"]) == 0

    assert diff["added"][0] == (
        100,
        2,
    )
