from opegit.repositories.tree_repository import TreeRepository


def test_create_tree() -> None:

    tree_hash = (
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    )

    result = TreeRepository.create_tree(
        tree_hash
    )

    assert result == tree_hash


def test_tree_exists() -> None:

    tree_hash = (
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    )

    TreeRepository.create_tree(
        tree_hash
    )

    assert TreeRepository.tree_exists(
        tree_hash
    )