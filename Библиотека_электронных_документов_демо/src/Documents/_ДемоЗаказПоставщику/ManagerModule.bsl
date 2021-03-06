#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Получение данных для формирования печатной формы заказа поставщику.
//
// Параметры:
//  СсылкаНаОбъект - ДокументСсылка._ДемоЗаказПоставщику - ссылка на документ печати.
// 
// Возвращаемое значение:
//  Структура - структура данных для печати.
//
Функция ПолучитьДанныеДляПечатнойФормыЗаказ(СсылкаНаОбъект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НоменклатураПоставщиков.Ссылка КАК Ссылка,
	|	НоменклатураПоставщиков.Идентификатор КАК Идентификатор,
	|	НоменклатураПоставщиков.Артикул КАК Артикул,
	|	НоменклатураПоставщиков.Наименование КАК Наименование,
	|	НоменклатураПоставщиков.Номенклатура КАК Номенклатура,
	|	НоменклатураПоставщиков.Характеристика КАК Характеристика,
	|	НоменклатураПоставщиков.Упаковка КАК Упаковка
	|ПОМЕСТИТЬ втНоменклатураПоставщика
	|ИЗ
	|	Справочник.НоменклатураПоставщиков КАК НоменклатураПоставщиков
	|ГДЕ
	|	НоменклатураПоставщиков.ПометкаУдаления = ЛОЖЬ
	|	И НоменклатураПоставщиков.Номенклатура В
	|			(ВЫБРАТЬ
	|				Таблица.Номенклатура
	|			ИЗ
	|				Документ._ДемоЗаказПоставщику.Товары КАК Таблица
	|			ГДЕ
	|				Таблица.Ссылка = &Ссылка)
	|	И НоменклатураПоставщиков.Владелец В
	|			(ВЫБРАТЬ
	|				Таблица.Контрагент
	|			ИЗ
	|				Документ._ДемоЗаказПоставщику КАК Таблица
	|			ГДЕ
	|				Таблица.Ссылка = &Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	_ДемоЗаказПоставщикуТовары.НомерСтроки КАК НомерСтроки,
	|	ЕСТЬNULL(втНоменклатураПоставщика.Артикул, """") КАК Артикул,
	|	ЕСТЬNULL(втНоменклатураПоставщика.Наименование, """") КАК Наименование,
	|	ЕСТЬNULL(втНоменклатураПоставщика.Идентификатор, """") КАК ИдТовараУКонтрагента,
	|	_ДемоЗаказПоставщикуТовары.Номенклатура КАК Номенклатура,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК БазоваяЕдиницаСсылка,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК БазоваяЕдиница,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Код КАК БазоваяЕдиницаКод,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Наименование КАК БазоваяЕдиницаНаименование,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.НаименованиеПолное КАК БазоваяЕдиницаНаименованиеПолное,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.МеждународноеСокращение КАК БазоваяЕдиницаМеждународноеСокращение,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКодПоОКЕИ,
	|	1 КАК ЕдиницаИзмеренияКоэффициент,
	|	ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка) КАК Характеристика,
	|	_ДемоЗаказПоставщикуТовары.Количество КАК Количество,
	|	1 КАК Коэффициент,
	|	_ДемоЗаказПоставщикуТовары.Цена КАК Цена,
	|	_ДемоЗаказПоставщикуТовары.Сумма КАК Сумма,
	|	ВЫРАЗИТЬ(_ДемоЗаказПоставщикуТовары.Сумма * 0.1 КАК ЧИСЛО(15, 2)) КАК СуммаСкидки,
	|	""Отзыв на сайте"" КАК НаименованиеСкидки,
	|	10 КАК ПроцентСкидки,
	|	ИСТИНА КАК СкидкаУчтеноВСумме,
	|	""Предоставляется 1 раз"" КАК КомментарийКСкидке,
	|	ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.БезНДС) КАК СтавкаНДС,
	|	ИСТИНА КАК НДСУчтеноВСумме,
	|	0 КАК СуммаНДС,
	|	_ДемоЗаказПоставщикуТовары.Сумма КАК СуммаСНДС,
	|	_ДемоЗаказПоставщикуТовары.ДокументОснование КАК ДокументОснование,
	|	ЕСТЬNULL(втНоменклатураПоставщика.Ссылка, &ПустаяНоменклатура) КАК НоменклатураПоставщика
	|ИЗ
	|	Документ._ДемоЗаказПоставщику.Товары КАК _ДемоЗаказПоставщикуТовары
	|		ЛЕВОЕ СОЕДИНЕНИЕ втНоменклатураПоставщика КАК втНоменклатураПоставщика
	|		ПО _ДемоЗаказПоставщикуТовары.Номенклатура = втНоменклатураПоставщика.Номенклатура
	|			И _ДемоЗаказПоставщикуТовары.Характеристика = втНоменклатураПоставщика.Характеристика
	|			И (втНоменклатураПоставщика.Упаковка = ЗНАЧЕНИЕ(Справочник.ЕдиницыИзмерения.ПустаяСсылка))
	|ГДЕ
	|	_ДемоЗаказПоставщикуТовары.Ссылка = &Ссылка
	|	И _ДемоЗаказПоставщикуТовары.НоменклатураПоставщика = &ПустаяНоменклатура
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	_ДемоЗаказПоставщикуТовары.НомерСтроки КАК НомерСтроки,
	|	_ДемоЗаказПоставщикуТовары.НоменклатураПоставщика.Артикул КАК Артикул,
	|	_ДемоЗаказПоставщикуТовары.НоменклатураПоставщика.Наименование КАК Наименование,
	|	_ДемоЗаказПоставщикуТовары.НоменклатураПоставщика.Идентификатор КАК ИдТовараУКонтрагента,
	|	_ДемоЗаказПоставщикуТовары.Номенклатура КАК Номенклатура,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК БазоваяЕдиницаСсылка,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК БазоваяЕдиница,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Код КАК БазоваяЕдиницаКод,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Наименование КАК БазоваяЕдиницаНаименование,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.НаименованиеПолное КАК БазоваяЕдиницаНаименованиеПолное,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.МеждународноеСокращение КАК БазоваяЕдиницаМеждународноеСокращение,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	_ДемоЗаказПоставщикуТовары.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКодПоОКЕИ,
	|	1 КАК ЕдиницаИзмеренияКоэффициент,
	|	ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка) КАК Характеристика,
	|	_ДемоЗаказПоставщикуТовары.Количество КАК Количество,
	|	1 КАК Коэффициент,
	|	_ДемоЗаказПоставщикуТовары.Цена КАК Цена,
	|	_ДемоЗаказПоставщикуТовары.Сумма КАК Сумма,
	|	ВЫРАЗИТЬ(_ДемоЗаказПоставщикуТовары.Сумма * 0.1 КАК ЧИСЛО(15, 2)) КАК СуммаСкидки,
	|	""Отзыв на сайте"" КАК НаименованиеСкидки,
	|	10 КАК ПроцентСкидки,
	|	ИСТИНА КАК СкидкаУчтеноВСумме,
	|	""Предоставляется 1 раз"" КАК КомментарийКСкидке,
	|	ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.БезНДС) КАК СтавкаНДС,
	|	ИСТИНА КАК НДСУчтеноВСумме,
	|	0 КАК СуммаНДС,
	|	_ДемоЗаказПоставщикуТовары.Сумма КАК СуммаСНДС,
	|	_ДемоЗаказПоставщикуТовары.ДокументОснование КАК ДокументОснование,
	|	_ДемоЗаказПоставщикуТовары.НоменклатураПоставщика КАК НоменклатураПоставщика
	|ИЗ
	|	Документ._ДемоЗаказПоставщику.Товары КАК _ДемоЗаказПоставщикуТовары
	|ГДЕ
	|	_ДемоЗаказПоставщикуТовары.Ссылка = &Ссылка
	|	И _ДемоЗаказПоставщикуТовары.НоменклатураПоставщика <> &ПустаяНоменклатура
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаказПоставщику.Номер КАК Номер,
	|	ЗаказПоставщику.Дата КАК Дата,
	|	ЗаказПоставщику.Организация КАК Исполнитель,
	|	ЗаказПоставщику.Контрагент КАК Заказчик,
	|	ЗаказПоставщику.Контрагент КАК Грузополучатель,
	|	ЗаказПоставщику.СуммаДокумента КАК СуммаДокумента,
	|	&ХозОперация КАК ХозОперация,
	|	&Роль КАК Роль,
	|	&Руководитель КАК Руководитель,
	|	&ДолжностьРуководителя КАК ДолжностьРуководителя,
	|	&ГлавныйБухгалтер КАК ГлавныйБухгалтер,
	|	&ДолжностьГлавногоБухгалтера КАК ДолжностьГлавногоБухгалтера,
	|	&Кладовщик КАК Кладовщик,
	|	&ДолжностьКладовщика КАК ДолжностьКладовщика,
	|	ЛОЖЬ КАК ЦенаВключаетНДС,
	|	ЗаказПоставщику.Валюта КАК Валюта,
	|	ЗаказПоставщику.Валюта.Код КАК ВалютаКод,
	|	1 КАК Курс,
	|	ЗаказПоставщику.Основание КАК ДокументОснование,
	|	ЗаказПоставщику.ДоговорКонтрагента КАК ДоговорКонтрагента,
	|	ЗаказПоставщику.ДоговорКонтрагента.НомерДоговора КАК ДоговорНомер,
	|	ЗаказПоставщику.ДоговорКонтрагента.ДатаДоговора КАК ДоговорДата,
	|	ЗаказПоставщику.ДоговорКонтрагента.Наименование КАК ДоговорНаименование,
	|	ЗаказПоставщику.БанковскийСчет КАК БанковскийСчет,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.НомерСчета, """") КАК НомерСчета,
	|	ЗаказПоставщику.БанковскийСчет.Банк КАК Банк,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.Банк.Наименование, """") КАК БанкНаименование,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.Банк.КоррСчет, """") КАК БанкСчетКорр,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.Банк.Код, """") КАК БанкБИК,
	|	ЗаказПоставщику.БанковскийСчет.БанкДляРасчетов КАК БанкДляРасчетов,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.БанкДляРасчетов.Наименование, """") КАК БанкКоррНаименование,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.БанкДляРасчетов.КоррСчет, """") КАК БанкКоррСчетКорр,
	|	ЕСТЬNULL(ЗаказПоставщику.БанковскийСчет.БанкДляРасчетов.Код, """") КАК БанкКоррБИК,
	|	ЗаказПоставщику.АдресДоставки КАК АдресДоставки,
	|	ЗаказПоставщику.АдресДоставкиЗначенияПолей КАК АдресДоставкиЗначенияПолей,
	|	ЗаказПоставщику.СпособДоставки КАК СпособДоставки
	|ИЗ
	|	Документ._ДемоЗаказПоставщику КАК ЗаказПоставщику
	|ГДЕ
	|	ЗаказПоставщику.Ссылка В(&Ссылка)";

	Запрос.УстановитьПараметр("Ссылка",                      СсылкаНаОбъект);
	Запрос.УстановитьПараметр("ХозОперация",                 НСтр("ru = 'Заказ товара'"));
	Запрос.УстановитьПараметр("Роль",                        НСтр("ru = 'Продавец'"));
	Запрос.УстановитьПараметр("Руководитель",                НСтр("ru = 'Козлевич Адам Коземирович'"));
	Запрос.УстановитьПараметр("ДолжностьРуководителя",       НСтр("ru = 'Директор'"));
	Запрос.УстановитьПараметр("ГлавныйБухгалтер",            НСтр("ru = 'Синицкая Зося Викторовна'"));
	Запрос.УстановитьПараметр("ДолжностьГлавногоБухгалтера", НСтр("ru = 'Бухгалтер'"));
	Запрос.УстановитьПараметр("Кладовщик",                   НСтр("ru = 'Гайзенкамф Светлана Петровна'"));
	Запрос.УстановитьПараметр("ДолжностьКладовщика",         НСтр("ru = 'Кладовщик'"));
	Запрос.УстановитьПараметр("ПустаяНоменклатура",          Справочники.НоменклатураПоставщиков.ПустаяСсылка());
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	РезультатПоТабличнойЧасти = МассивРезультатов[1];
	РезультатПоШапке = МассивРезультатов[2];
	
	СтруктураДанныхДляПечати = Новый Структура("РезультатПоШапке, РезультатПоТабличнойЧасти",
												РезультатПоШапке, РезультатПоТабличнойЧасти);
	
	Возврат СтруктураДанныхДляПечати;
	
КонецФункции

#КонецОбласти

#КонецЕсли