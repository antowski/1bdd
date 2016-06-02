# encoding: utf-8
# language: ru

Функционал: Проверка генерации шагов
	Как Разработчик
	Я Хочу, чтобы у меня была возможность генерировать шаги в os-файлах для feature-файлов

Сценарий: Первичная генерация шагов

  Когда я подготовил тестовый каталог для фич
  И установил тестовый каталог как текущий
	И я подготовил специальную тестовую фичу "ПередачаПараметров"
  И я запустил генерацию шагов фичи "ПередачаПараметров"
  Тогда я получил сгенерированный os-файл в ожидаемом каталоге
  # И проверка поведения фичи "ПередачаПараметров" закончилась со статусом "НеРеализован"
  И проверка поведения фичи "ПередачаПараметров" закончилась с кодом возврата 1

Сценарий: Перегенерация шагов в случае существования файла шагов

	Когда я подготовил тестовый каталог для фич
  И установил тестовый каталог как текущий
  Когда я подготовил специальную тестовую фичу "ПередачаПараметров"
  И я подставил файл шагов с уже реализованными шагами для фичи "ПередачаПараметров"
  И я запустил генерацию шагов фичи "ПередачаПараметров"
  Тогда я получил сгенерированный os-файл в ожидаемом каталоге
	И проверка поведения фичи "ПередачаПараметров" закончилась с кодом возврата 0
