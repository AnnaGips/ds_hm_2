-- Створення таблиць
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

-- Вставка початкових даних
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

-- SQL-запити для виконання
-- Отримати всі завдання певного користувача за його user_id
SELECT * FROM tasks WHERE user_id = <user_id>;

-- Вибрати завдання за певним статусом (наприклад, 'нове')
SELECT * FROM tasks WHERE status_id = (SELECT id FROM status WHERE name = 'нове');

-- Оновити статус конкретного завдання на 'in progress' або інший статус
UPDATE tasks SET status_id = <status_id> WHERE id = <task_id>;

-- Отримати список користувачів, які не мають жодного завдання
SELECT * FROM users WHERE id NOT IN (SELECT DISTINCT user_id FROM tasks);

-- Додати нове завдання для конкретного користувача
INSERT INTO tasks (title, description, status_id, user_id) VALUES ('Нове завдання', 'Опис нового завдання', <status_id>, <user_id>);

-- Отримати всі завдання, які ще не завершено
SELECT * FROM tasks WHERE status_id <> (SELECT id FROM status WHERE name = 'завершене');

-- Видалити конкретне завдання за його id
DELETE FROM tasks WHERE id = <task_id>;

-- Знайти користувачів з певною електронною поштою
SELECT * FROM users WHERE email LIKE '%@example.com';

-- Оновити ім'я користувача
UPDATE users SET fullname = 'Нове ім\'я' WHERE id = <user_id>;

-- Отримати кількість завдань для кожного статусу
SELECT status.name, COUNT(tasks.id) AS task_count
FROM status
LEFT JOIN tasks ON status.id = tasks.status_id
GROUP BY status.name;

-- Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти
SELECT tasks.*
FROM tasks
JOIN users ON tasks.user_id = users.id
WHERE users.email LIKE '%@example.com';

-- Отримати список завдань, що не мають опису
SELECT * FROM tasks WHERE description IS NULL OR description = '';

-- Вибрати користувачів та їхні завдання, які є у статусі 'in progress'
SELECT users.fullname, tasks.title
FROM users
JOIN tasks ON users.id = tasks.user_id
JOIN status ON tasks.status_id = status.id
WHERE status.name = 'в роботі';

-- Отримати користувачів та кількість їхніх завдань
SELECT users.id, users.fullname, COUNT(tasks.id) AS task_count
FROM users
LEFT JOIN tasks ON users.id = tasks.user_id
GROUP BY users.id, users.fullname;



