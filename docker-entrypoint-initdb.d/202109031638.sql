CREATE SCHEMA data

CREATE TABLE data.detected_object (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL
);

COMMENT ON TABLE data.detected_object IS 'Объект';
COMMENT ON COLUMN data.detected_object.name IS 'Наименование объекта';

CREATE TABLE data.shooting_equipment (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    spatial_resolution NUMERIC NOT NULL,
    usage_period NUMERIC NOT NULL
);

COMMENT ON TABLE data.shooting_equipment IS 'Съёмочное оборудование';
COMMENT ON COLUMN data.shooting_equipment.name IS 'Наименование оборудования';
COMMENT ON COLUMN data.shooting_equipment.spatial_resolution IS 'Пространственное разрешение на местности, м';
COMMENT ON COLUMN data.shooting_equipment.usage_period IS 'Период съёмки, сутки. Если 0 - съёмка делается по запросу';

CREATE TABLE data.bearer_type (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL UNIQUE
);

COMMENT ON TABLE data.bearer_type IS 'Тип носителя';
COMMENT ON COLUMN data.bearer_type.name IS 'Наименование типа носителя';

INSERT INTO data.bearer_type (name) VALUES ('космический'), ('авиационный'), ('полевой');

CREATE TABLE data.weather_data (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_time TIMESTAMP WITH TIME ZONE NOT NULL,
    air_temperature NUMERIC NOT NULL,
    cloudness_ratio NUMERIC NOT NULL,
    humidity_ratio NUMERIC NOT NULL,
    atmospheric_state TEXT NOT NULL -- Как выражается состояние атосферы?
);

COMMENT ON TABLE data.weather_data IS 'Метеоусловия';
COMMENT ON COLUMN data.weather_data.date_time IS 'Дата и время измерения метеоусловий';
COMMENT ON COLUMN data.weather_data.air_temperature IS 'Температура воздуха (градусы Цельсия)';
COMMENT ON COLUMN data.weather_data.cloudness_ratio IS 'Облачность';
COMMENT ON COLUMN data.weather_data.humidity_ratio IS 'Относительная влажность';
COMMENT ON COLUMN data.weather_data.atmospheric_state IS 'Состояние атмосферы';

CREATE TABLE data.ground_inspection (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_time TIMESTAMP WITH TIME ZONE NOT NULL

);

COMMENT ON TABLE data.ground_inspection IS 'Наземное обследование';
COMMENT ON COLUMN data.ground_inspection.date_time IS 'Дата и время проведения обследования';

CREATE TABLE data.spectral_characteristics (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY

);

COMMENT ON TABLE data.spectral_characteristics IS 'Спектральные характеристики';

CREATE TABLE data.spectral_channel(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    boundaries NUMRANGE NOT NULL,
    shooting_equipment_id INT NOT NULL REFERENCES shooting_equipment (id)
);

COMMENT ON TABLE data.spectral_channel IS 'Спектральный канал';
COMMENT ON COLUMN data.spectral_channel.boundaries IS 'Границы канала, мкм';
COMMENT ON COLUMN data.spectral_channel.shooting_equipment_id IS 'ID аппаратуры, которой принадлежит канал';

CREATE ROLE web_anon nologin;
GRANT usage ON SCHEMA data to web_anon;
