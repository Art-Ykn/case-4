# Веб-приложение на Delphi + IIS + MS SQL Server

## Описание
Демонстрационное веб-приложение, реализующее REST-метод для получения списка сотрудников из MS SQL Server.

## Технологии
- Delphi (RAD Studio 13)
- ISAPI (для IIS)
- FireDAC
- MS SQL Server Express

## Установка и запуск

### 1. База данных
- Установите MS SQL Server Express.
- Включите учётную запись `sa` и задайте пароль `12345`.
- Выполните скрипт `company_db.sql` для создания БД `CompanyDB`.

### 2. Сборка проекта
- Откройте `Project1.dpr` в Delphi.
- Убедитесь, что выбрана платформа **Win32**.
- Соберите проект: **Project → Build All** → получите `Project1.dll`.

### 3. Настройка IIS
- Скопируйте `Project1.dll` в `C:\inetpub\wwwroot\api\`.
- В IIS Manager:
  - Добавьте приложение `api` → путь к папке.
  - В **ISAPI and CGI Restrictions** разрешите эту DLL.
  - Установите для пула приложений: **Enable 32-Bit Applications = True**.
- Выполните в командной строке: `iisreset`

### 4. Проверка
Откройте в браузере:
