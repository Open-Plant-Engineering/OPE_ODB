from opegit.services.element_service import (
    ElementService,
)

from opegit.services.manifest_service import (
    ManifestService,
)

from opegit.services.tree_service import (
    TreeService,
)


def test_create_tree() -> None:

    ElementService.create_element(
        container_id=1,
        local_id=1,
    )

    manifest = ManifestService.create_manifest(
        {
            "NAME": "PIPE-100",
            "SIZE": 250,
            "ACTIVE": True,
        }
    )

    tree_hash = TreeService.create_tree(
        [
            {
                "container_id": 1,
                "local_id": 1,
                "manifest_id": manifest.manifest_id,
            }
        ]
    )

    assert len(tree_hash) == 64