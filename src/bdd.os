//----------------------------------------------------------
//This Source Code Form is subject to the terms of the
//Mozilla Public License, v.2.0. If a copy of the MPL
//was not distributed with this file, You can obtain one
//at http://mozilla.org/MPL/2.0/.
//---------------------------------------------------------

///////////////////////////////////////////////////////////////////
// Стартовый модуль синхронизатора

#Использовать tempfiles
#Использовать cmdline
#Использовать logos

Перем Лог;
Перем УдалятьВременныеФайлы;
Перем СохраненныйТекущийКаталог;

Функция Версия()
	Возврат "0.8";
КонецФункции // Версия()

//{ Точка входа в приложение
Процедура ОсновнаяРабота()
	Лог = Логирование.ПолучитьЛог("bdd");
	УдалятьВременныеФайлы = Истина;
	СохранитьТекущийКаталог();

	Сообщить(СтрШаблон("BDD for OneScript ver.%1", Версия()));

	Попытка
		Параметры = РазобратьАргументыКоманднойСтроки();
		Если Параметры <> Неопределено Тогда
			КодВозврата = ВыполнитьОбработку(Параметры);
			ЗавершитьСкрипт(КодВозврата);
		Иначе
			ПоказатьИнформациюОПараметрахКоманднойСтроки();
			Лог.Ошибка("Указаны некорректные аргументы командной строки");
			ЗавершитьСкрипт(0);
		КонецЕсли;
	Исключение
		Лог.Ошибка(ОписаниеОшибки());
		ЗавершитьСкрипт(-1);
	КонецПопытки;
КонецПроцедуры
//}

///////////////////////////////////////////////////////////////////
//{ Прикладные процедуры и функции

Функция РазобратьАргументыКоманднойСтроки()

	Если АргументыКоманднойСтроки.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	Парсер = Новый ПарсерАргументовКоманднойСтроки();

	ДобавитьКомандуExec(Парсер);
	ДобавитьКомандуGenerate(Парсер);
	ДобавитьКомандуHelp(Парсер);
	ДобавитьАргументыПоУмолчанию(Парсер);

	Параметры = Парсер.Разобрать(АргументыКоманднойСтроки);

	Возврат Параметры;

КонецФункции

Процедура ДобавитьКомандуExec(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("exec");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьФичи");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-require");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-out");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуGenerate(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("gen");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьФичи");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-out");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуHelp(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("help");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "КомандаДляСправки");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьАргументыПоУмолчанию(Знач Парсер)

	Парсер.ДобавитьПараметр("ПутьФичи");

	Парсер.ДобавитьИменованныйПараметр("-require");
	Парсер.ДобавитьИменованныйПараметр("-out");
	Парсер.ДобавитьИменованныйПараметр("-debug");
	Парсер.ДобавитьИменованныйПараметр("-verbose");

КонецПроцедуры

Функция ВыполнитьОбработку(Знач Параметры)

	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		Команда = Параметры.Команда;
		Параметры = Параметры.ЗначенияПараметров;
	Иначе
		Команда = "exec";
	КонецЕсли;

	ПутьФичи = Параметры["ПутьФичи"];

	УстановитьРежимОтладкиПриНеобходимости(Параметры);
	НастроитьВыводЛогФайла(Параметры);

	КодВозврата = ВыполнитьКоманду(Команда, ПутьФичи, Параметры);

	Возврат КодВозврата;
КонецФункции

Функция ВыполнитьКоманду(Знач Команда, Знач ПутьФичи, Знач Параметры)

	КодВозврата = 0;
	Если Команда = "exec" Тогда
		КодВозврата = ВыполнитьФичу(ПутьФичи, Параметры["-require"]);
	ИначеЕсли Команда = "gen" Тогда
		СоздатьФайлРеализацииШагов(ПутьФичи);
	ИначеЕсли Команда = "help" Тогда
		ВывестиСправкуПоКомандам(Параметры["КомандаДляСправки"]);
	Иначе
		ВызватьИсключение "Неизвестная команда: " + Команда;
	КонецЕсли;

	Возврат КодВозврата;
КонецФункции

Функция ВыполнитьФичу(Знач ПутьФичи, Знач ПутьКБиблиотекам)
	Лог.Отладка("ПутьФичи "+ПутьФичи);

	Контекст = Новый Структура("Контекст", Новый Структура("Журнал", Новый Структура));

	ПутьИсполнителя = ОбъединитьПути(ТекущийСценарий().Каталог, "bdd-exec.os");
	Лог.Отладка("Создаю исполнителя. Путь "+ПутьИсполнителя);
	ИсполнительБДД = ЗагрузитьСценарий(ПутьИсполнителя, Контекст);

	ДопЛог = Логирование.ПолучитьЛог(ИсполнительБДД.ИмяЛога());
	ДопЛог.УстановитьУровень(Лог.Уровень());

	ФайлФичи = Новый Файл(ПутьФичи);
	Если Не ЗначениеЗаполнено(ФайлФичи.Путь) Тогда // TODO обход бага https://github.com/EvilBeaver/OneScript/issues/273
		ФайлФичи = Новый Файл(ОбъединитьПути(ТекущийКаталог(), ПутьФичи));
	КонецЕсли;

	Если Не ПустаяСтрока(ПутьКБиблиотекам) Тогда
		ФайлБиблиотек = Новый Файл(ПутьКБиблиотекам);
		Лог.Отладка("Использую путь к библиотечным шагам "+ПутьКБиблиотекам);
	Иначе
		//по умолчанию загружаем все файлы шагов из каталога фичи и подкаталогов для использования в качестве библиотечных шагов
		ПутьКаталогаФичи = ?(ФайлФичи.ЭтоКаталог(), ФайлФичи.ПолноеИмя, ФайлФичи.Путь);
		Лог.Отладка("Использую автозагрузку библиотечных шагов из "+ПутьКаталогаФичи);
		ФайлБиблиотек = Новый Файл(ПутьКаталогаФичи);
	КонецЕсли;

	ИскатьВПодкаталогах = Истина;
	РезультатыВыполнения = ИсполнительБДД.ВыполнитьФичу(ФайлФичи, ФайлБиблиотек, ИскатьВПодкаталогах);

	КодВозврата = ИсполнительБДД.ВозможныеКодыВозвратовПроцесса()[РезультатыВыполнения.Строки[0].СтатусВыполнения];

	ИсполнительБДД.ВывестиИтоговыеРезультатыВыполнения(РезультатыВыполнения);

	Возврат КодВозврата;
КонецФункции

Процедура СоздатьФайлРеализацииШагов(Знач ПутьФичи)
	Лог.Отладка("ПутьФичи "+ПутьФичи);

	ПутьГенератора = ОбъединитьПути(ТекущийСценарий().Каталог, "bdd-generate.os");
	Лог.Отладка("Создаю помощника для генерации файла шагов. Путь "+ПутьГенератора);
	ГенераторШагов = ЗагрузитьСценарий(ПутьГенератора);

	ДопЛог = Логирование.ПолучитьЛог(ГенераторШагов.ИмяЛога());
	ДопЛог.УстановитьУровень(Лог.Уровень());

	ФайлФичи = Новый Файл(ПутьФичи);
	ФайлШагов = ГенераторШагов.СоздатьФайлРеализацииШагов(ФайлФичи);
КонецПроцедуры

Процедура УстановитьРежимОтладкиПриНеобходимости(Знач Параметры)
	Если Параметры["-debug"] = "on" Тогда
		Лог.УстановитьУровень(УровниЛога.Отладка);
		УдалятьВременныеФайлы = Ложь;
	КонецЕсли;
	Если Параметры["-verbose"] = "on" Тогда
		Лог.УстановитьУровень(УровниЛога.Отладка);
	КонецЕсли;
КонецПроцедуры

Процедура НастроитьВыводЛогФайла(Знач Параметры)
	ИмяЛогФайла = Параметры["-out"];
	Если ИмяЛогФайла <> Неопределено Тогда
		Лог.ДобавитьСпособВывода(Новый ВыводЛогаВКонсоль());
		Аппендер = Новый ВыводЛогаВФайл();
		Аппендер.ОткрытьФайл(ИмяЛогФайла, "utf-8", Ложь);
		Лог.ДобавитьСпособВывода(Аппендер);
	КонецЕсли;
КонецПроцедуры

Процедура ПоказатьИнформациюОПараметрахКоманднойСтроки()

	Сообщить("Выполнение сценариев BDD для Gherkin-спецификаций.");
	Сообщить("Использование: ");
	Сообщить("	bdd <features-path> [ключи] - аналог команды bdd exec");
	Сообщить("	bdd <команда> <параметры команды> [ключи]");
	Сообщить("Возможные команды:");
	Сообщить("	exec - Выполняет сценарии BDD для Gherkin-спецификаций
			|		bdd exec <features-path> [ключи]
			|			features-path - путь к файлам *.feature.
			|				Можно указывать как каталог, так и конкретный файл.
			|		возможные ключи:
			|			-require <путь каталога или путь файла> - путь к каталогу фича-файлов или к фича-файлу, содержащим библиотечные шаги.
			|				Если эта опция не задана, загружаются все os-файлы шагов из каталога исходной фичи и его подкаталогов.
			|				Если опция задана, загружаются только os-файлы шагов из каталога фича-файлов или к фича-файла, содержащих библиотечные шаги.
			|
			|	gen - Создает заготовки шагов для указанных Gherkin-спецификаций
			|		bdd gen <features-path> [ключи]
			|			features-path - путь к файлам *.feature.
			|				Можно указывать как каталог, так и конкретный файл.
			|");

	Сообщить("Возможные общие ключи:");
	Сообщить("	-out <путь лог-файла>
			|	-debug <on|off> - включает режим отладки (полный лог + остаются временные файлы)
			|	-verbose <on|off> - включается полный лог");

	Сообщить("Для подсказки по конкретной команде наберите bdd help <команда>");

КонецПроцедуры

Процедура ВывестиСправкуПоКомандам(Знач Команда) Экспорт

	Если Команда = "exec" Тогда

		Сообщить("Выполняет сценарии BDD для Gherkin-спецификаций");
		Сообщить("bdd exec <features-path> [ключи]");
		Сообщить("Возможные ключи:");
		Сообщить("	-out <путь лог-файла>
				|	-debug <on|off> - включает режим отладки (полный лог + остаются временные файлы)
				|	-verbose <on|off> - включается полный лог");

	ИначеЕсли Команда = "gen" Тогда

		Сообщить("Создает заготовки шагов для указанных Gherkin-спецификаций");
		Сообщить("bdd gen <features-path> [ключи]");
		Сообщить("Возможные ключи:");
		Сообщить("	-out <путь лог-файла>
				|	-debug <on|off> - включает режим отладки (полный лог + остаются временные файлы)
				|	-verbose <on|off> - включается полный лог");

	Иначе
		Сообщить("Неизвестная команда: " + Команда);
	КонецЕсли;

КонецПроцедуры

Процедура УдалитьВременныеФайлыПриНеобходимости()
	Если УдалятьВременныеФайлы Тогда
		ВременныеФайлы.Удалить();
	КонецЕсли;
КонецПроцедуры

Процедура СохранитьТекущийКаталог()
	СохраненныйТекущийКаталог = ТекущийКаталог();
КонецПроцедуры

Процедура ВосстановитьТекущийКаталог()
	УстановитьТекущийКаталог(СохраненныйТекущийКаталог)
КонецПроцедуры

Процедура ЗавершитьСкрипт(КодВозврата)
	Лог.Закрыть();
	ВосстановитьТекущийКаталог();
	УдалитьВременныеФайлыПриНеобходимости();

	ЗавершитьРаботу(КодВозврата);
КонецПроцедуры
//}

///////////////////////////////////////////////////////////////////

ОсновнаяРабота();
