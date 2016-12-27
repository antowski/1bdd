﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd
#Использовать 1commands

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯОчищаюПараметрыКомандыВКонтексте");
	ВсеШаги.Добавить("ЯВключаюОтладкуЛогаСИменем");
	ВсеШаги.Добавить("ЯВыключаюОтладкуЛогаСИменем");
	ВсеШаги.Добавить("ЯВыполняюКоманду");
	ВсеШаги.Добавить("ВыводКомандыСодержит");
	ВсеШаги.Добавить("КодВозвратаКомандыРавен");
	ВсеШаги.Добавить("ЯВыполняюКомандуCПараметрами");
	ВсеШаги.Добавить("ЯСообщаюВыводКоманды");
	ВсеШаги.Добавить("ЯДобавляюПараметрДляКоманды");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры

//Я очищаю параметры команды "git" в контексте
Процедура ЯОчищаюПараметрыКомандыВКонтексте(Знач ИмяКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяКоманды);
	Команда.УстановитьПараметры("");
КонецПроцедуры

//я включаю отладку лога с именем "bdd"
Процедура ЯВключаюОтладкуЛогаСИменем(Знач ИмяЛога) Экспорт
    Лог = Логирование.ПолучитьЛог(ИмяЛога);
	Лог.УстановитьУровень(УровниЛога.Отладка);
КонецПроцедуры

//я выключаю отладку лога с именем "bdd"
Процедура ЯВыключаюОтладкуЛогаСИменем(Знач ИмяЛога) Экспорт
    Лог = Логирование.ПолучитьЛог(ИмяЛога);
	Лог.УстановитьУровень(УровниЛога.Информация);
КонецПроцедуры

//Я выполняю команду "git"
Процедура ЯВыполняюКоманду(Знач ИмяИлиТекстКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	
	Команда.Исполнить();
	
КонецПроцедуры

//Я выполняю команду "git" c параметрами "--version"
Процедура ЯВыполняюКомандуCПараметрами(Знач ИмяКоманды, Знач ПараметрыКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяКоманды);

	Команда.УстановитьПараметры(ПараметрыКоманды);

	Команда.Исполнить();
КонецПроцедуры

//Я добавляю параметр "--version" для команды "git"
Процедура ЯДобавляюПараметрДляКоманды(Знач ПараметрКоманды, Знач ИмяКоманды) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));

	Команда.ДобавитьПараметр(ПараметрКоманды);
КонецПроцедуры

//Вывод команды "git" содержит "[--version]"
Процедура ВыводКомандыСодержит(Знач ИмяКоманды, Знач ОжидаемыйВыводКоманды) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	
	ВыводКоманды = Команда.ПолучитьВывод();
	Ожидаем.Что(ВыводКоманды).Содержит(ОжидаемыйВыводКоманды);
КонецПроцедуры

//Код возврата команды "git" равен 1
Процедура КодВозвратаКомандыРавен(Знач ИмяКоманды, Знач ОжидаемыйКодВозврата) Экспорт
	
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));

	Ожидаем.Что(Команда.ПолучитьКодВозврата(), "Код возврата").Равно(ОжидаемыйКодВозврата);
КонецПроцедуры

//Я сообщаю вывод команды "git"
Процедура ЯСообщаюВыводКоманды(Знач ИмяКоманды) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	
	ВыводКоманды = Команда.ПолучитьВывод();
	Сообщить(ВыводКоманды);
КонецПроцедуры

// { Служебные функции
Функция ПолучитьКомандуИзКонтекста(Знач ИмяКоманды)

	КлючКонтекста = КлючКоманды(ИмяКоманды);
	Команда = БДД.ПолучитьИзКонтекста(КлючКонтекста);

	Если Не ЗначениеЗаполнено(Команда) Тогда
		Команда = Новый Команда;
		Команда.УстановитьКоманду(ИмяКоманды);
		БДД.СохранитьВКонтекст(КлючКонтекста, Команда);
	КонецЕсли;
	
	Возврат Команда;
КонецФункции

Функция КлючКоманды(Знач ИмяКоманды)
	Возврат "Команда-" + ИмяКоманды;
КонецФункции
//}
