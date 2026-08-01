from opegit.repositories.chunk_repository import ChunkRepository


def test_get_non_existing_chunk() -> None:

    chunk_id = ChunkRepository.get_chunk_by_hash(
        "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
    )

    assert chunk_id is None