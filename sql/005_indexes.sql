-- =====================================================
-- OPE_ODB
-- Indexes
-- =====================================================

-- =====================================================
-- ELEMENT
-- =====================================================

create index idx_element_type
on element(
    type_id,
    is_deleted
);

create index idx_element_owner
on element
(
    owner_container_id,
    owner_local_id,
    is_deleted,
    sequence_no
);

-- =====================================================
-- ATTRIBUTE DEFINITION
-- =====================================================

create unique index idx_attribute_definition_name
on attribute_definition(attribute_name);

-- =====================================================
-- STRING POOL
-- =====================================================

create unique index idx_string_pool_value
on string_pool(string_value);

-- =====================================================
-- VECTOR3 POOL
-- =====================================================

create unique index idx_vector3_pool_xyz
on vector3_pool
(
    x_value,
    y_value,
    z_value
);

-- =====================================================
-- VALUE TABLES
-- =====================================================

create index idx_value_string_attribute
on value_string(
    attribute_id,
    is_deleted
);

create index idx_value_number_attribute
on value_number(
    attribute_id,
    is_deleted
);

create index idx_value_logical_attribute
on value_logical(
    attribute_id,
    is_deleted
);

create index idx_value_reference_attribute
on value_reference(
    attribute_id,
    is_deleted
);

create index idx_value_reference_target
on value_reference
(
    ref_container_id,
    ref_local_id,
    is_deleted
);

create index idx_value_position_attribute
on value_position(
    attribute_id,
    is_deleted
);

create index idx_value_direction_attribute
on value_direction(
    attribute_id,
    is_deleted
);

create index idx_value_orientation_attribute
on value_orientation(
    attribute_id,
    is_deleted
);

create index idx_value_datetime_attribute
on value_datetime(
    attribute_id,
    is_deleted
);

create index idx_value_json_attribute
on value_json(
    attribute_id,
    is_deleted
);

create index idx_value_blob_attribute
on value_blob(
    attribute_id,
    is_deleted
);

create index idx_value_uuid_attribute
on value_uuid(
    attribute_id,
    is_deleted
);

-- =====================================================
-- ARRAY TABLES
-- =====================================================

create index idx_array_string_attribute
on array_string(
    attribute_id,
    is_deleted
);

create index idx_array_number_attribute
on array_number(
    attribute_id,
    is_deleted
);

create index idx_array_logical_attribute
on array_logical(
    attribute_id,
    is_deleted
);

create index idx_array_reference_attribute
on array_reference(
    attribute_id,
    is_deleted
);

create index idx_array_reference_target
on array_reference
(
    ref_container_id,
    ref_local_id,
    is_deleted
);

create index idx_array_position_attribute
on array_position(
    attribute_id,
    is_deleted
);

create index idx_array_direction_attribute
on array_direction(
    attribute_id,
    is_deleted
);

create index idx_array_orientation_attribute
on array_orientation(
    attribute_id,
    is_deleted
);
create index idx_array_datetime_attribute
on array_datetime(
    attribute_id,
    is_deleted
);

create index idx_array_json_attribute
on array_json(
    attribute_id,
    is_deleted
);

create index idx_array_blob_attribute
on array_blob(
    attribute_id,
    is_deleted
);

create index idx_array_uuid_attribute
on array_uuid(
    attribute_id,
    is_deleted
);


-- =====================================================
-- VALUE TABLE ELEMENT INDEXES
-- =====================================================

create index idx_value_string_element
on value_string
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_number_element
on value_number
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_logical_element
on value_logical
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_reference_element
on value_reference
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_position_element
on value_position
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_direction_element
on value_direction
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_orientation_element
on value_orientation
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_datetime_element
on value_datetime
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_json_element
on value_json
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_blob_element
on value_blob
(
    container_id,
    local_id,
    is_deleted
);

create index idx_value_uuid_element
on value_uuid
(
    container_id,
    local_id,
    is_deleted
);

-- =====================================================
-- ARRAY TABLE ELEMENT INDEXES
-- =====================================================

create index idx_array_string_element
on array_string
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_number_element
on array_number
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_logical_element
on array_logical
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_reference_element
on array_reference
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_position_element
on array_position
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_direction_element
on array_direction
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_orientation_element
on array_orientation
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_datetime_element
on array_datetime
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_json_element
on array_json
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_blob_element
on array_blob
(
    container_id,
    local_id,
    is_deleted
);

create index idx_array_uuid_element
on array_uuid
(
    container_id,
    local_id,
    is_deleted
);