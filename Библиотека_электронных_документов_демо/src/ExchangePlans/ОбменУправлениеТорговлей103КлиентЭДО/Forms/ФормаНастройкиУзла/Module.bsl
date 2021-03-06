
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиСервер.ФормаНастройкиУзлаПриСозданииНаСервере(ЭтотОбъект,
		Метаданные.ПланыОбмена.ОбменУправлениеПредприятиемКлиентЭДО.Имя);
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПереключательОтправлятьНСИАвтоматическиПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИПоНеобходимостиПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИНикогдаПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьАвтоматическиПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьВручнуюПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыНеОтправлятьПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ФлагИспользоватьОтборПоОрганизациямПриИзменении(Элемент)
	
	Элементы.УчастникиЭДО.Доступность = ИспользоватьОтборПоУчастникамЭДО;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	Если Не ИспользоватьОтборПоУчастникамЭДО И УчастникиЭДО.Количество() <> 0 Тогда
		УчастникиЭДО.Очистить();
	ИначеЕсли УчастникиЭДО.Количество() = 0 И ИспользоватьОтборПоУчастникамЭДО Тогда
		ИспользоватьОтборПоУчастникамЭДО = Ложь;
	КонецЕсли;
	
	Если РежимВыгрузкиДокументов <> 
		Элементы.ПереключательДокументыОтправлятьАвтоматически.СписокВыбора[0].Значение Тогда
		ДатаНачалаВыгрузкиДокументов = Дата(1,1,1);
	КонецЕсли;
	
	// Сохранение настроек
	ОбменДаннымиКлиент.ФормаНастройкиУзлаКомандаЗакрытьФорму(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьВидимостьНаСервере()
	
	Если РежимВыгрузкиСправочников = 
			Перечисления.РежимыВыгрузкиОбъектовОбмена.ВыгружатьПриНеобходимости
		И РежимВыгрузкиДокументов = 
			Перечисления.РежимыВыгрузкиОбъектовОбмена.НеВыгружать Тогда
		
		РежимВыгрузкиДокументов = 
			Перечисления.РежимыВыгрузкиОбъектовОбмена.ВыгружатьПоУсловию;
	КонецЕсли;
	
	Элементы.ДатаНачалаВыгрузкиДокументов.Доступность = РежимВыгрузкиДокументов = 
		Перечисления.РежимыВыгрузкиОбъектовОбмена.ВыгружатьПоУсловию;
	
	Элементы.ГруппаНеСинхронизироватьДокументы.Доступность = РежимВыгрузкиСправочников = 
		Перечисления.РежимыВыгрузкиОбъектовОбмена.ВыгружатьПоУсловию;
	
	Элементы.ГруппаРежимОтправкиДокументов.Доступность = РежимВыгрузкиСправочников <> 
		Перечисления.РежимыВыгрузкиОбъектовОбмена.НеВыгружать;
	
	Если РежимВыгрузкиСправочников = 
		Перечисления.РежимыВыгрузкиОбъектовОбмена.НеВыгружать Тогда
		
		РежимВыгрузкиДокументов = Перечисления.РежимыВыгрузкиОбъектовОбмена.НеВыгружать;
		Элементы.ГруппаОтборПоУчастникамЭДО.Видимость = Ложь;
	Иначе
		Элементы.ГруппаОтборПоУчастникамЭДО.Видимость = Истина;
		Элементы.УчастникиЭДО.Доступность = ИспользоватьОтборПоУчастникамЭДО;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
