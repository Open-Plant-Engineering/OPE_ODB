from opegit.services.chunk_service import ChunkService


def test_store_string() -> None:

    chunk_hash = ChunkService.store_string(
        "PIPE-100"
    )

    assert chunk_hash is not None
    assert len(chunk_hash) == 64