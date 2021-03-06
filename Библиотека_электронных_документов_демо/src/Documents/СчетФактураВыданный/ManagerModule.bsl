#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Находит счет-фактуру для заданного документа.
//
// Параметры:
//   Основание - ДокументСсылка - Документ, для которого необходимо найти счет-фактуру.
//
// Возвращаемое значение:
//   ДокументСсылка.СчетФактураВыданный, Неопределено - ссылка на счет-фактуру или неопределено,
//                                                      если объект не найден.
//
Функция СчетФактураДокумента(Основание) Экспорт
	
	СчетФактура = Неопределено;
	
	Если НЕ ЗначениеЗаполнено(Основание) Тогда
		Возврат СчетФактура;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СчетФактураВыданныйДокументыОснования.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.СчетФактураВыданный.ДокументыОснования КАК СчетФактураВыданныйДокументыОснования
	|ГДЕ
	|	СчетФактураВыданныйДокументыОснования.ДокументОснование = &Основание
	|	И НЕ СчетФактураВыданныйДокументыОснования.Ссылка.ПометкаУдаления";
	Запрос.УстановитьПараметр("Основание", Основание);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СчетФактура = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат СчетФактура;
	
КонецФункции

// Получение данных для формирования электронного документа.
//
// Параметры:
//  СсылкаНаОбъект - ДокументСсылка.РеализацияТоваровУслуг - ссылка на документ.
// 
// Возвращаемое значение:
//  Структура - структура данных для печати.
//
Функция ПолучитьДанныеДляЭД(СсылкаНаОбъект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СчетФактураВыданный.Ссылка КАК Ссылка,
		|	СчетФактураВыданный.НомерЭД КАК Номер,
		|	СчетФактураВыданный.Дата КАК Дата,
		|	СчетФактураВыданный.НомерИсправления КАК НомерИсправления,
		|	СчетФактураВыданный.Дата КАК ДатаИсправления,
		|	СчетФактураВыданный.НомерИсходногоДокумента КАК НомерИсходногоДокумента,
		|	СчетФактураВыданный.ДатаИсходногоДокумента КАК ДатаИсходногоДокумента,
		|	СчетФактураВыданный.НомерИсправленияИсходногоДокумента КАК НомерИсправленияИсходногоДокумента,
		|	СчетФактураВыданный.ДатаИсправленияИсходногоДокумента КАК ДатаИсправленияИсходногоДокумента,
		|	СчетФактураВыданный.НомерИсправляемогоКорректировочногоДокумента КАК НомерИсправляемогоКорректировочногоДокумента,
		|	СчетФактураВыданный.ДатаИсправляемогоКорректировочногоДокумента КАК ДатаИсправляемогоКорректировочногоДокумента,
		|	СчетФактураВыданный.ВидДокумента КАК ВидДокумента,
		|	СчетФактураВыданный.ВидОперации КАК ВидОперации,
		|	СчетФактураВыданный.Организация КАК Организация,
		|	СчетФактураВыданный.Контрагент КАК Контрагент,
		|	СчетФактураВыданный.ДоговорКонтрагента КАК ДоговорКонтрагента,
		|	СчетФактураВыданный.ДоговорКонтрагента.Наименование КАК НаименованиеДоговора,
		|	СчетФактураВыданный.ДоговорКонтрагента.НомерДоговора КАК НомерДоговора,
		|	СчетФактураВыданный.ДоговорКонтрагента.ДатаДоговора КАК ДатаДоговора,
		|	СчетФактураВыданный.ИдентификаторГосКонтракта КАК ИдентификаторГосКонтракта,
		|	СчетФактураВыданный.Валюта КАК Валюта,
		|	СчетФактураВыданный.Валюта.Код КАК ВалютаКод,
		|	СчетФактураВыданный.Валюта.Наименование КАК ВалютаНаименование,
		|	СчетФактураВыданный.СчетФактураОснование КАК СчетФактураОснование,
		|	СчетФактураВыданный.ОблагаетсяНДСУПокупателя КАК ОблагаетсяНДСУПокупателя
		|ИЗ
		|	Документ.СчетФактураВыданный КАК СчетФактураВыданный
		|ГДЕ
		|	СчетФактураВыданный.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СчетФактураВыданныйДокументыОснования.ДокументОснование КАК ДокументОснование
		|ИЗ
		|	Документ.СчетФактураВыданный.ДокументыОснования КАК СчетФактураВыданныйДокументыОснования
		|ГДЕ
		|	СчетФактураВыданныйДокументыОснования.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Товары.Ссылка КАК Ссылка,
		|	Товары.НомерСтроки КАК НомерСтроки,
		|	Товары.Номенклатура КАК Номенклатура,
		|	Товары.Номенклатура.Код КАК НоменклатураКод,
		|	Товары.Номенклатура.НаименованиеПолное КАК НоменклатураНаименование,
		|	Товары.Номенклатура.Артикул КАК НоменклатураАртикул,
		|	Товары.Номенклатура.ВидНоменклатуры.ТипНоменклатуры КАК ТипНоменклатуры,
		|	Товары.Характеристика КАК Характеристика,
		|	Товары.Характеристика.Код КАК ХарактеристикаКод,
		|	Товары.Характеристика.Наименование КАК ХарактеристикаНаименование,
		|	Товары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	Товары.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКод,
		|	Товары.ЕдиницаИзмерения.Наименование КАК ЕдиницаИзмеренияНаименование,
		|	Товары.КоличествоДоКорректировки КАК КоличествоДоКорректировки,
		|	Товары.Количество КАК Количество,
		|	Товары.ЦенаДоКорректировки КАК ЦенаДоКорректировки,
		|	Товары.Цена КАК Цена,
		|	Товары.СуммаДоКорректировки КАК СуммаДоКорректировки,
		|	Товары.Сумма КАК Сумма,
		|	Товары.СтавкаНДС КАК СтавкаНДС,
		|	Товары.СуммаНДСДоКорректировки КАК СуммаНДСДоКорректировки,
		|	Товары.СуммаНДС КАК СуммаНДС,
		|	Товары.СуммаСНДСДоКорректировки КАК СуммаСНДСДоКорректировки,
		|	Товары.СуммаСНДС КАК СуммаСНДС,
		|	Товары.СуммаСНДСДоКорректировки - Товары.СуммаНДСДоКорректировки КАК СуммаБезНДСДоКорректировки,
		|	Товары.СуммаСНДС - Товары.СуммаНДС КАК СуммаБезНДС,
		|	Товары.СуммаАкцизаДоКорректировки КАК СуммаАкцизаДоКорректировки,
		|	Товары.СуммаАкциза КАК СуммаАкциза,
		|	Товары.НомерГТД КАК НомерГТД,
		|	Товары.СтранаПроисхождения.Код КАК СтранаПроисхожденияКод,
		|	Товары.СтранаПроисхождения.Наименование КАК СтранаПроисхожденияНаименование
		|ИЗ
		|	Документ.СчетФактураВыданный.Товары КАК Товары
		|ГДЕ
		|	Товары.Ссылка = &Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	Товары.НомерСтроки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СчетФактураВыданныйПлатежноРасчетныеДокументы.НомерСтроки КАК НомерСтроки,
		|	СчетФактураВыданныйПлатежноРасчетныеДокументы.НомерПлатежноРасчетногоДокумента КАК НомерПлатежноРасчетногоДокумента,
		|	СчетФактураВыданныйПлатежноРасчетныеДокументы.ДатаПлатежноРасчетногоДокумента КАК ДатаПлатежноРасчетногоДокумента
		|ИЗ
		|	Документ.СчетФактураВыданный.ПлатежноРасчетныеДокументы КАК СчетФактураВыданныйПлатежноРасчетныеДокументы
		|ГДЕ
		|	СчетФактураВыданныйПлатежноРасчетныеДокументы.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	СтруктураДанных = Новый Структура;
	
	СтруктураДанных.Вставить("ВыборкаШапки", МассивРезультатов[0].Выбрать());
	
	Если НЕ МассивРезультатов[1].Пустой() Тогда
		СтруктураДанных.Вставить("ВыборкаОснований", МассивРезультатов[1].Выбрать());
	КонецЕсли;
	
	Если НЕ МассивРезультатов[2].Пустой() Тогда
		СтруктураДанных.Вставить("ВыборкаТоваров", МассивРезультатов[2].Выбрать());
	КонецЕсли;
	
	Если НЕ МассивРезультатов[3].Пустой() Тогда
		СтруктураДанных.Вставить("ВыборкаПРД", МассивРезультатов[3].Выбрать());
	КонецЕсли;
	
	Возврат СтруктураДанных;
	
КонецФункции

// Обновляет реквизиты счета-фактуры, если они были изменены в основании.
//
// Параметры:
//	Основание - ДокументОбъект - документ-основание счета-фактуры.
//
Процедура ПроверитьСоответствиеРеквизитовСчетаФактуры(Основание) Экспорт
	
	Если Основание.ДополнительныеСвойства.ЭтоНовый Тогда
		Возврат;
	КонецЕсли;
	
	СчетФактура = Документы.СчетФактураВыданный.СчетФактураДокумента(Основание.Ссылка);
	Если НЕ ЗначениеЗаполнено(СчетФактура) Тогда
		Возврат;
	КонецЕсли;
	
	НеобходимоОбновить = Ложь;
	РежимЗаписи = РежимЗаписиДокумента.Запись;
	
	ПроверяемыеРеквизиты = "Валюта, Организация, Контрагент, ДоговорКонтрагента, ЦенаВключаетНДС";
	
	СчетФактураОснование = Неопределено;
	Если ЗначениеЗаполнено(Основание.ДокументОснование) Тогда
		СчетФактураОснование = СчетФактураДокумента(Основание.ДокументОснование);
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СчетФактураОснование) Тогда
		СчетФактураОснование = Документы.СчетФактураВыданный.ПустаяСсылка();
	КонецЕсли;
	
	СчетФактураОбъект = СчетФактура.ПолучитьОбъект();
	
	Если СчетФактураОбъект.ДокументыОснования.Количество() > 1 Тогда
		
		ПроверяемыеРеквизиты = "СчетФактураОснование, Валюта, Организация, Контрагент, ДоговорКонтрагента,
			|ЦенаВключаетНДС, ПометкаУдаления";
		ЗначенияРеквизитовОснования = Новый Структура(ПроверяемыеРеквизиты);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовОснования, Основание);
		ЗначенияРеквизитовОснования.СчетФактураОснование = СчетФактураОснование;
		
		ЗначенияРеквизитовСчетаФактуры = Новый Структура(ПроверяемыеРеквизиты);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовСчетаФактуры, СчетФактураОбъект);
		
		Если НЕ ОбщегоНазначения.КоллекцииИдентичны(ЗначенияРеквизитовОснования, ЗначенияРеквизитовСчетаФактуры) Тогда
			СтрокаКУдалению = СчетФактураОбъект.ДокументыОснования.Найти(Основание.Ссылка, "ДокументОснование");
			СчетФактураОбъект.ДокументыОснования.Удалить(СтрокаКУдалению);
		КонецЕсли;
		
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	СУММА(РеализацияТоваровУслуг.СуммаДокумента) КАК СуммаДокумента
			|ИЗ
			|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
			|ГДЕ
			|	РеализацияТоваровУслуг.Ссылка В(&МассивСсылок)";
		Запрос.УстановитьПараметр("МассивСсылок", СчетФактураОбъект.ДокументыОснования.ВыгрузитьКолонку("ДокументОснование"));
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			СчетФактураОбъект.СуммаДокумента = Выборка.СуммаДокумента;
		КонецЕсли;
		
		НеобходимоОбновить = Истина;
		
	ИначеЕсли Основание.ПометкаУдаления Тогда
		СчетФактураОбъект.УстановитьПометкуУдаления(Истина);
		Возврат;
		
	Иначе
		
		ПроверяемыеРеквизиты = "СчетФактураОснование, Валюта, Организация, Контрагент, ДоговорКонтрагента,
			|ЦенаВключаетНДС, СуммаДокумента";
		
		ЗначенияРеквизитовОснования = Новый Структура(ПроверяемыеРеквизиты);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовОснования, Основание);
		ЗначенияРеквизитовОснования.СчетФактураОснование = СчетФактураОснование;
		
		ЗначенияРеквизитовСчетаФактуры = Новый Структура(ПроверяемыеРеквизиты);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовСчетаФактуры, СчетФактураОбъект);
		
		Если НЕ ОбщегоНазначения.КоллекцииИдентичны(ЗначенияРеквизитовОснования, ЗначенияРеквизитовСчетаФактуры) Тогда
			СчетФактураОбъект.Заполнить(Основание.Ссылка);
			НеобходимоОбновить = Истина;
		КонецЕсли;
		
		Если НЕ Основание.Проведен И СчетФактураОбъект.Проведен Тогда
			РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения;
			НеобходимоОбновить = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Если НеобходимоОбновить Тогда
		
		Попытка
			СчетФактураОбъект.Заблокировать();
			СчетФактураОбъект.ДополнительныеСвойства.Вставить("ИзменилисьКлючевыеРеквизиты", Истина);
			СчетФактураОбъект.Записать(РежимЗаписи);
		Исключение
			ТекстСообщения = СтрШаблон(
				НСтр("ru='Реквизиты документа ""%1"" автоматически не перезаполнены и могут быть неактуальными'"),
				СчетФактура);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, СчетФактура);
		КонецПопытки;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Поля.Добавить("ПредставлениеНомера");
	Поля.Добавить("Дата");
	Поля.Добавить("ВидДокумента");
	Поля.Добавить("ВидОперации");
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Представление = КлиентЭДОКлиентСервер.ПредставлениеИсходящегоДокумента(Данные);
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	КлиентЭДОВызовСервера.ОбработкаПолученияФормыСчетаФактуры(
		ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти
