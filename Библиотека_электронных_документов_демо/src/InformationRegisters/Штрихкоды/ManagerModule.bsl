#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция НайтиНоменклатуруПоШтрихкоду(ШтрихКод) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	Штрихкоды.Владелец КАК Номенклатура
	|ИЗ
	|	РегистрСведений.Штрихкоды КАК Штрихкоды
	|ГДЕ
	|	Штрихкоды.Штрихкод = &Штрихкод
	|	И Штрихкоды.Владелец ССЫЛКА Справочник.Номенклатура";
	
	Запрос.УстановитьПараметр("Штрихкод", Штрихкод);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		
		Возврат Неопределено
		
	Иначе
		
		Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Номенклатура");
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецЕсли