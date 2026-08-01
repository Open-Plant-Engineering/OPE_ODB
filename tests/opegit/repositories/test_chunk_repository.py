from opegit.hashing.chunk_hash import ChunkHash
from opegit.repositories.chunk_repository import ChunkRepository


def test_get_non_existing_chunk() -> None:

    chunk_hash = ChunkRepository.get_chunk_by_hash(
        "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
    )

    assert chunk_hash is None


def test_create_string_chunk() -> None:

    expected_hash = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100",
    )

    chunk_hash = ChunkRepository.create_chunk(
        chunk_hash=expected_hash,
        data_type_id=1,
        string_value="PIPE-100",
    )

    assert chunk_hash == expected_hash


def test_get_chunk_by_hash() -> None:

    expected_hash = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100",
    )

    ChunkRepository.create_chunk(
        chunk_hash=expected_hash,
        data_type_id=1,
        string_value="PIPE-100",
    )

    chunk_hash = ChunkRepository.get_chunk_by_hash(
        expected_hash
    )

    assert chunk_hash == expected_hash


def test_second_chunk_lookup() -> None:

    expected_hash = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-200",
    )

    ChunkRepository.create_chunk(
        chunk_hash=expected_hash,
        data_type_id=1,
        string_value="PIPE-200",
    )

    chunk_hash = ChunkRepository.get_chunk_by_value(
        data_type_id=1,
        string_value="PIPE-200",
    )

    assert chunk_hash == expected_hash


def test_get_or_create_chunk_returns_same_hash() -> None:

    expected_hash = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-100",
    )

    chunk_hash = ChunkRepository.get_or_create_chunk(
        chunk_hash=expected_hash,
        data_type_id=1,
        string_value="PIPE-100",
    )

    assert chunk_hash == expected_hash


def test_create_second_chunk() -> None:

    expected_hash = ChunkHash.calculate(
        data_type_id=1,
        value="PIPE-200",
    )

    chunk_hash = ChunkRepository.get_or_create_chunk(
        chunk_hash=expected_hash,
        data_type_id=1,
        string_value="PIPE-200",
    )

    assert chunk_hash == expected_hash
