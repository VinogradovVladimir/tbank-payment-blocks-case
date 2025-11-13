-- database/schema.sql

-- Таблица для хранения блокировок платежей клиентов
CREATE TABLE payment_blocks (
    id BIGSERIAL PRIMARY KEY,
    client_id VARCHAR(50) NOT NULL,                    -- Идентификатор клиента (юридического лица)
    reason VARCHAR(20) NOT NULL CHECK (reason IN ('fraud', 'incorrect_details')),  -- Причина блокировки
    comment TEXT,                                      -- Комментарий оператора
    is_active BOOLEAN DEFAULT TRUE,                   -- Флаг активности блокировки
    created_by VARCHAR(100) NOT NULL,                 -- Идентификатор оператора, создавшего блокировку
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    unblocked_by VARCHAR(100),                        -- Идентификатор оператора, снявшего блокировку
    unblocked_at TIMESTAMP WITH TIME ZONE
);

-- Индексы для оптимизации производительности
CREATE INDEX idx_payment_blocks_client_active ON payment_blocks (client_id, is_active);
CREATE INDEX idx_payment_blocks_reason ON payment_blocks (reason);
CREATE INDEX idx_payment_blocks_created_at ON payment_blocks (created_at);
