CREATE TABLE detected_object (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL
);

COMMENT ON TABLE  detected_object IS 'Объект';
COMMENT ON COLUMN detected_object.name IS 'Наименование объекта';

CREATE TABLE shooting_equipment (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    spatial_resolution NUMERIC NOT NULL,
    usage_period NUMERIC NOT NULL
);

COMMENT ON TABLE shooting_equipment IS 'Съёмочное оборудование';
COMMENT ON COLUMN shooting_equipment.name IS 'Наименование оборудования';
COMMENT ON COLUMN shooting_equipment.spatial_resolution IS 'Пространственное разрешение на местности, м';
COMMENT ON COLUMN shooting_equipment.usage_period IS 'Период съёмки, сутки. Если 0 - съёмка делается по запросу';

CREATE TABLE bearer_type (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL UNIQUE
);

COMMENT ON TABLE bearer_type IS 'Тип носителя';
COMMENT ON COLUMN bearer_type.name IS 'Наименование типа носителя';

INSERT INTO bearer_type (name) VALUES ('космический'), ('авиационный'), ('полевой');

CREATE TABLE weather_data (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_time TIMESTAMP WITH TIME ZONE NOT NULL,
    air_temperature NUMERIC NOT NULL,
    cloudness_ratio NUMERIC NOT NULL,
    humidity_ratio NUMERIC NOT NULL,
    atmospheric_state TEXT NOT NULL -- Как выражается состояние атосферы?
);

COMMENT ON TABLE weather_data IS 'Метеоусловия';
COMMENT ON COLUMN weather_data.date_time IS 'Дата и время измерения метеоусловий';
COMMENT ON COLUMN weather_data.air_temperature IS 'Температура воздуха (градусы Цельсия)';
COMMENT ON COLUMN weather_data.cloudness_ratio IS 'Облачность';
COMMENT ON COLUMN weather_data.humidity_ratio IS 'Относительная влажность';
COMMENT ON COLUMN weather_data.atmospheric_state IS 'Состояние атмосферы';

CREATE TABLE ground_inspection (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_time TIMESTAMP WITH TIME ZONE NOT NULL

);

COMMENT ON TABLE ground_inspection IS 'Наземное обследование';
COMMENT ON COLUMN ground_inspection.date_time IS 'Дата и время проведения обследования';

CREATE TABLE spectral_characteristics (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY

);

COMMENT ON TABLE spectral_characteristics IS 'Спектральные характеристики';

CREATE TABLE spectral_channel(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    boundaries NUMRANGE NOT NULL,
    shooting_equipment_id INT NOT NULL REFERENCES shooting_equipment (id)
);

COMMENT ON TABLE spectral_channel IS 'Спектральный канал';
COMMENT ON COLUMN spectral_channel.boundaries IS 'Границы канала, мкм';
COMMENT ON COLUMN spectral_channel.shooting_equipment_id IS 'ID аппаратуры, которой принадлежит канал';

CREATE ROLE web_anon nologin;
GRANT usage ON SCHEMA public to web_anon;
