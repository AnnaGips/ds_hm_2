CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    status_id INTEGER REFERENCES status(id),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);


INSERT INTO users (fullname, email) VALUES
('Анна Коваленко', 'anna.kovalenko@example.com'),
('Михайло Петренко', 'mikhail.petrenko@example.com'),
('Олена Іванова', 'olena.ivanova@example.com'),
('Сергій Лисенко', 'serhii.lisenko@example.com'),
('Ірина Сидоренко', 'irina.sydorenko@example.com'),
('Петро Морозов', 'petro.morozov@example.com'),
('Ольга Кравченко', 'olha.kravchenko@example.com'),
('Віталій Семенов', 'vitalii.semenov@example.com'),
('Наталія Ткаченко', 'nataliia.tkachenko@example.com'),
('Андрій Шевченко', 'andrii.shevchenko@example.com');

INSERT INTO status (name) VALUES
('нове'),
('в роботі'),
('завершене');

INSERT INTO tasks (title, description, status_id, user_id) VALUES
('Заповнити заявку', 'Заповнити заявку на отримання паспорта', 1, 1),
('Підготувати презентацію', 'Підготувати презентацію для наступного засідання', 2, 2),
('Вивчити новий матеріал', 'Вивчити новий матеріал з підручника', 1, 3),
('Провести експеримент', 'Провести експеримент для випробування нового методу', 2, 4),
('Написати листа', 'Написати листа другу до Дня Народження', 3, 5);


