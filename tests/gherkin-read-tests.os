﻿
/////////////////////////////////////////////////////////////////////////////////////////////////
//
// Тест для генератора BDD-шагов сценария в формате OneScript на базе файлов Gherkin
//
/////////////////////////////////////////////////////////////////////////////////////////////////

#Использовать logos
#Использовать asserts

Перем юТест;
Перем Лог;
Перем ЧитательГеркин;

Перем ВозможныеКлючевыеСлова;
Перем ВозможныеТипыШагов;
Перем ВозможныеКлючиПараметров;

Функция ПолучитьСписокТестов(Знач ЮнитТестирование) Экспорт

	юТест = ЮнитТестирование;

	МассивТестов = Новый Массив;
	МассивТестов.Добавить("Тест_ДолженПрочитатьПростойФайлФичи");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСоСтроковымиПараметрами");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСКлючевымиСловамиШаговСоСтроковымиПараметрами");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСЧисловымиПараметрами");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСПараметромДатаИз4Цифр");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСПараметромДатаИз2Цифр");
	МассивТестов.Добавить("Тест_ДолженПрочитатьФайлФичиСПараметромСтрокаСКавычкамиВнутриАпострофов");

	Возврат МассивТестов;

КонецФункции

Процедура ПослеЗапускаТеста() Экспорт
	ВключитьОтладкуЧитателя(УровниЛога.Информация);
КонецПроцедуры

Процедура Тест_ДолженПрочитатьПростойФайлФичи() Экспорт

	// ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\НичегоНеДелаю.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);
	ВозможныеТипыШагов = ЧитательГеркин.ВозможныеТипыШагов();

	Ожидаем.Что(РезультатыРазбора, "РезультатыРазбора").ИмеетТип("Структура");
	Ожидаем.Что(РезультатыРазбора.Язык, "Язык").Равно("ru");

	ДеревоФич = РезультатыРазбора.ДеревоФич;
	Ожидаем.Что(ДеревоФич, "Ожидали, что дерево фич будет получено как дерево значений, а это не так").ИмеетТип("ДеревоЗначений");
	ДеревоФич = ДеревоФич.Строки[0];
	Ожидаем.Что(ДеревоФич.Строки, "Ожидали, что найдем правильное число фич").ИмеетДлину(1);

	ТелоФункциональности = "Пустой функционал
		|Как Разработчик
		|Я Хочу чтобы файл фичи успешно прочитался";

	Ожидаем.Что(ДеревоФич.Лексема, "Ожидали, что правильно нашли ДеревоФич.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Функциональность);
	Ожидаем.Что(ДеревоФич.ТипШага, "Ожидали, что правильно нашли ДеревоФич.ТипШага, а это не так").Равно(ВозможныеТипыШагов.Функциональность);
	Ожидаем.Что(ДеревоФич.Тело, "Ожидали, что правильно нашли ДеревоФич.Тело, а это не так").Равно(ТелоФункциональности);

	Сценарии = ДеревоФич.Строки;
	Ожидаем.Что(Сценарии, "Ожидали, что найдем правильное число сценариев").ИмеетДлину(1);

	Сценарий0 = Сценарии[0];
	Ожидаем.Что(Сценарий0.Лексема, "Ожидали, что правильно нашли Сценарий0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Сценарий);
	Ожидаем.Что(Сценарий0.ТипШага, "Ожидали, что правильно нашли Сценарий0.ТипШага, а это не так").Равно(ВозможныеТипыШагов.Сценарий);
	Ожидаем.Что(Сценарий0.Тело, "Ожидали, что найдем правильное тело сценария 0, а это не так").Равно("Ничего не делаем");

	Шаги = Сценарий0.Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я ничего не делаю");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.ТипШага, "Ожидали, что правильно нашли Шаг0.ТипШага, а это не так").Равно(ВозможныеТипыШагов.Шаг);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯНичегоНеДелаю");

	Шаг1 = Шаги[1];
	Ожидаем.Что(Шаг1.Тело, "Ожидали, что найдем правильное тело шага 1, а это не так").Равно("ничего не происходит");
	Ожидаем.Что(Шаг1.Лексема, "Ожидали, что правильно нашли Шаг1.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Тогда);
	Ожидаем.Что(Шаг1.ТипШага, "Ожидали, что правильно нашли Шаг1.ТипШага, а это не так").Равно(ВозможныеТипыШагов.Шаг);
	Ожидаем.Что(Шаг1.АдресШага, "Ожидали, что правильно нашли Шаг1.АдресШага, а это не так").Равно("НичегоНеПроисходит");

	НайденныеЛексемы = РезультатыРазбора.НайденныеЛексемы;
	Ожидаем.Что(НайденныеЛексемы, "Ожидали, что найдем правильное число лексем").ИмеетДлину(4);
	Ожидаем.Что(НайденныеЛексемы[0].Лексема, "Ожидали, что найдем правильное число лексем").Равно(ВозможныеКлючевыеСлова.Функциональность);
	Ожидаем.Что(НайденныеЛексемы[1].Лексема, "Ожидали, что найдем правильное число лексем").Равно(ВозможныеКлючевыеСлова.Сценарий);
	Ожидаем.Что(НайденныеЛексемы[2].Лексема, "Ожидали, что найдем правильное число лексем").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(НайденныеЛексемы[3].Лексема, "Ожидали, что найдем правильное число лексем").Равно(ВозможныеКлючевыеСлова.Тогда);
КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСоСтроковымиПараметрами() Экспорт

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\СтроковыеПараметры.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[0].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я ничего не делаю ""ПарамСтрока""");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯНичегоНеДелаю");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(1);
	Параметр00 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("ПарамСтрока");

	Шаг1 = Шаги[1];
	Ожидаем.Что(Шаг1.Тело, "Ожидали, что найдем правильное тело шага 1, а это не так").Равно("ничего не происходит 'ДругойПарамСтрока'");
	Ожидаем.Что(Шаг1.Лексема, "Ожидали, что правильно нашли Шаг1.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Тогда);
	Ожидаем.Что(Шаг1.АдресШага, "Ожидали, что правильно нашли Шаг1.АдресШага, а это не так").Равно("НичегоНеПроисходит");

	Ожидаем.Что(Шаг1.Параметры, "Ожидали, что найдем правильное число параметров шага 1").ИмеетДлину(1);
	Параметр10 = Шаг1.Параметры[0];
	Ожидаем.Что(Параметр10.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр10.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно("ДругойПарамСтрока");

КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСКлючевымиСловамиШаговСоСтроковымиПараметрами() Экспорт
	// ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\СтроковыеПараметры_ВсеКлючевыеПоля.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[0].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(4);

	Шаг00 = Шаги[0];
	Ожидаем.Что(Шаг00.Тело, "Ожидали, что найдем правильное тело шага 00, а это не так").Равно("все путем ""ПарамДано"" и ""ПарамНеДано""");
	Ожидаем.Что(Шаг00.Лексема, "Ожидали, что правильно нашли Шаг00.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Допустим);
	Ожидаем.Что(Шаг00.АдресШага, "Ожидали, что правильно нашли Шаг00.АдресШага, а это не так").Равно("ВсеПутемИ");

	Ожидаем.Что(Шаг00.Параметры, "Ожидали, что найдем правильное число параметров шага 00").ИмеетДлину(2);
	Параметр00 = Шаг00.Параметры[0];
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 00, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 00, а это не так").Равно("ПарамДано");
	Параметр00 = Шаг00.Параметры[1];
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 1 шага 00, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 1 шага 00, а это не так").Равно("ПарамНеДано");

	Шаг0 = Шаги[1];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я ничего не делаю ""ПарамКогда""");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯНичегоНеДелаю");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(1);
	Параметр0 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр0.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("ПарамКогда");
	Ожидаем.Что(Параметр0.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Строка);

	Шаг2 = Шаги[2];
	Ожидаем.Что(Шаг2.Тело, "Ожидали, что найдем правильное тело шага 2, а это не так").Равно("никто ничего не делает ""ПарамИ""");
	Ожидаем.Что(Шаг2.Лексема, "Ожидали, что правильно нашли Шаг2.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Также);
	Ожидаем.Что(Шаг2.АдресШага, "Ожидали, что правильно нашли Шаг2.АдресШага, а это не так").Равно("НиктоНичегоНеДелает");

	Ожидаем.Что(Шаг2.Параметры, "Ожидали, что найдем правильное число параметров шага 2").ИмеетДлину(1);
	Параметр20 = Шаг2.Параметры[0];
	Ожидаем.Что(Параметр20.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 2, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр20.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 2, а это не так").Равно("ПарамИ");

	Шаг3 = Шаги[3];
	Ожидаем.Что(Шаг3.Тело, "Ожидали, что найдем правильное тело шага 3, а это не так").Равно("ничего не происходит ""ПарамТогда""");
	Ожидаем.Что(Шаг3.Лексема, "Ожидали, что правильно нашли Шаг3.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Тогда);
	Ожидаем.Что(Шаг3.АдресШага, "Ожидали, что правильно нашли Шаг3.АдресШага, а это не так").Равно("НичегоНеПроисходит");

	Ожидаем.Что(Шаг3.Параметры, "Ожидали, что найдем правильное число параметров шага 3").ИмеетДлину(1);
	Параметр30 = Шаг3.Параметры[0];
	Ожидаем.Что(Параметр30.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 3, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр30.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 3, а это не так").Равно("ПарамТогда");

КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСЧисловымиПараметрами() Экспорт
	//ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\ПередачаПараметров.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[0].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я использую 5 и число2");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯИспользуюИ");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(2);
	Параметр00 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("5");
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Число);
	Параметр01 = Шаг0.Параметры[1];
	Ожидаем.Что(Параметр01.Значение, "Ожидали, что найдем правильное значение параметра 1 шага 0, а это не так").Равно("число2");
	Ожидаем.Что(Параметр01.Тип, "Ожидали, что найдем правильное значение параметра 1 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Строка);

	Шаг1 = Шаги[1];
	Ожидаем.Что(Шаг1.Тело, "Ожидали, что найдем правильное тело шага 1, а это не так").Равно("получаю 10 и сумму12");
	Ожидаем.Что(Шаг1.Лексема, "Ожидали, что правильно нашли Шаг1.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Тогда);
	Ожидаем.Что(Шаг1.АдресШага, "Ожидали, что правильно нашли Шаг1.АдресШага, а это не так").Равно("ПолучаюИ");

	Ожидаем.Что(Шаг1.Параметры, "Ожидали, что найдем правильное число параметров шага 1").ИмеетДлину(2);
	Параметр10 = Шаг1.Параметры[0];
	Ожидаем.Что(Параметр10.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно(ВозможныеКлючиПараметров.Число);
	Ожидаем.Что(Параметр10.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно("10");
	Параметр11 = Шаг1.Параметры[1];
	Ожидаем.Что(Параметр11.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно(ВозможныеКлючиПараметров.Строка);
	Ожидаем.Что(Параметр11.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 1, а это не так").Равно("сумму12");

КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСПараметромДатаИз4Цифр() Экспорт
	//ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\ПередачаПараметров.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[1].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я передаю параметр 11.02.2010");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯПередаюПараметр");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(1);
	Параметр00 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("11.02.2010");
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Дата);

КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСПараметромДатаИз2Цифр() Экспорт
	//ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\ПередачаПараметров.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[2].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я передаю параметр 11.02.10");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯПередаюПараметр");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(1);
	Параметр00 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("11.02.10");
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Дата);

КонецПроцедуры

Процедура Тест_ДолженПрочитатьФайлФичиСПараметромСтрокаСКавычкамиВнутриАпострофов() Экспорт
	//ВключитьОтладкуЧитателя(УровниЛога.Отладка);

	ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures\ПередачаПараметров.feature"));

	РезультатыРазбора = ЧитательГеркин.ПрочитатьФайлСценария(ФайлФичи);

	Шаги = РезультатыРазбора.ДеревоФич.Строки[0].Строки[3].Строки;
	Ожидаем.Что(Шаги, "Ожидали, что найдем правильное число шагов").ИмеетДлину(2);

	Шаг0 = Шаги[0];
	Ожидаем.Что(Шаг0.Тело, "Ожидали, что найдем правильное тело шага 0, а это не так").Равно("я передаю параметр 'Начало ""ВнутриКавычек"" Конец'");
	Ожидаем.Что(Шаг0.Лексема, "Ожидали, что правильно нашли Шаг0.Лексема, а это не так").Равно(ВозможныеКлючевыеСлова.Когда);
	Ожидаем.Что(Шаг0.АдресШага, "Ожидали, что правильно нашли Шаг0.АдресШага, а это не так").Равно("ЯПередаюПараметр");

	Ожидаем.Что(Шаг0.Параметры, "Ожидали, что найдем правильное число параметров шага 0").ИмеетДлину(1);
	Параметр00 = Шаг0.Параметры[0];
	Ожидаем.Что(Параметр00.Значение, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно("Начало ""ВнутриКавычек"" Конец");
	Ожидаем.Что(Параметр00.Тип, "Ожидали, что найдем правильное значение параметра 0 шага 0, а это не так").Равно(ВозможныеКлючиПараметров.Строка);

КонецПроцедуры

Процедура ВключитьОтладкуЧитателя(НовыйУровеньЛога)
	ДопЛог = Логирование.ПолучитьЛог(ЧитательГеркин.ИмяЛога());
	ДопЛог.УстановитьУровень(НовыйУровеньЛога);
КонецПроцедуры

////////////////////////////////////////////////////////////////////
// Программный интерфейс

Функция Инициализация()
	Лог = Логирование.ПолучитьЛог("oscript.app.bdd-tests");
	Лог.УстановитьУровень(УровниЛога.Отладка);

	//КаталогСкрипта = Новый Файл(ТекущийСценарий().Источник).Путь;
	ПодключитьСценарий(ОбъединитьПути(ТекущийСценарий().Каталог, "../src/gherkin-read.os"), "ЧитательGherkin");
	ЧитательГеркин = Новый ЧитательGherkin;

	ВозможныеТипыШагов = ЧитательГеркин.ВозможныеТипыШагов();
	ВозможныеКлючевыеСлова = ЧитательГеркин.ВозможныеКлючевыеСлова();
	ВозможныеКлючиПараметров = ЧитательГеркин.ВозможныеКлючиПараметров();

КонецФункции

///////////////////////////////////////////////////////////////////
// Точка входа

Инициализация();
