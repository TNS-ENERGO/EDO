#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Отбор.Свойство("Владелец") Тогда
		ОтборОрганизация = Параметры.Отбор.Владелец;
		Параметры.Отбор.Удалить("Владелец");
	ИначеЕсли НЕ Справочники.Организации.ИспользуетсяНесколькоОрганизаций() Тогда
		ОтборОрганизация = Справочники.Организации.ОрганизацияПоУмолчанию();
	КонецЕсли;
	
	ОтборОрганизацияИспользование = ЗначениеЗаполнено(ОтборОрганизация);
	Элементы.ОтборОрганизация.Видимость = ОтборОрганизацияИспользование;
	
	ТипВладельца = ТипЗнч(ОтборОрганизация);
	Если ОтборОрганизацияИспользование Тогда
		Если ТипВладельца = Тип("СправочникСсылка.Контрагенты") Тогда
			Элементы.ОтборОрганизация.Заголовок = НСтр("ru = 'Контрагент'");
		ИначеЕсли ТипВладельца = Тип("СправочникСсылка.Организации") Тогда
			Элементы.ОтборОрганизация.Видимость = Справочники.Организации.ИспользуетсяНесколькоОрганизаций();
			Элементы.ОтборОрганизация.Заголовок = НСтр("ru = 'Организация'");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьОтборПоОрганизации();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьОтборПоОрганизации()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
		ЭтотОбъект.Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор,
		"Владелец",
		ОтборОрганизация,
		Неопределено,
		,
		ОтборОрганизацияИспользование);
	
КонецПроцедуры

#КонецОбласти
