CREATE TABLE Solar_sensors (
    id TEXT PRIMARY KEY,
    name VARCHAR(255),
    coords_x FLOAT(53),
    coords_y FLOAT(53)
);

CREATE TABLE Solar_sensor_data (
    id TEXT PRIMARY KEY,
    sensor_id TEXT REFERENCES Solar_sensors(id),
    created_at TIMESTAMP,
    data TEXT
);
