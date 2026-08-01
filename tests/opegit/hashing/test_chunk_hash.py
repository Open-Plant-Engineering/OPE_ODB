from opegit.hashing.chunk_hash import ChunkHash


def test_hash_is_deterministic() -> None:

    hash1 = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100"
    )

    hash2 = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100"
    )

    assert hash1 == hash2


def test_different_values_produce_different_hashes() -> None:

    hash1 = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100"
    )

    hash2 = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-200"
    )

    assert hash1 != hash2
