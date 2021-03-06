#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытыеКопируемыеФормы = Параметры.ОткрытыеКопируемыеФормы;
	Элементы.ГруппаАктивныеПользователи.Видимость    = Параметры.ЕстьАктивныеПользователиПолучатели;
	Элементы.ГруппаОткрытыеКопируемыеФормы.Видимость = ЗначениеЗаполнено(ОткрытыеКопируемыеФормы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокАктивныхПользователейНажатие(Элемент)
	
	СтандартныеПодсистемыКлиент.ОткрытьСписокАктивныхПользователей();
	
КонецПроцедуры

&НаКлиенте
Процедура СообщениеОткрытыеФормыОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	ПоказатьПредупреждение(, ОткрытыеКопируемыеФормы);
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Скопировать(Команда)
	
	Если Параметры.Действие <> "СкопироватьИЗакрыть" Тогда
		Закрыть();
	КонецЕсли;
	
	Результат = Новый Структура("Действие", Параметры.Действие);
	Оповестить("СкопироватьНастройкиАктивнымПользователям", Результат);
	
КонецПроцедуры

#КонецОбласти
