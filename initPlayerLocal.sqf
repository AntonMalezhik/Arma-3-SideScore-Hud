// Работа в отдельном потоке
[] spawn {
    
	// Шаблон отображения
	private _template = "<img size='0.8' image='%1'/>  <t color='%2'>%3 </t>:<t color='%4'> %5</t>  <img size='0.8' image='%6'/>";
    
	// Флаг первой и второй стороны
	private _flag_OPFOR = "\A3\Data_F_Enoch\Flags\flag_rus_co.paa";
	private _flag_BLUEFOR = "\A3\Air_F\Data\plane_flag_CO.paa";

	// Цвета первой и второй стороны
	private _OPFOR_color = "#FF0000";
	private _BLUEFOR_color = "#00FF00";
    
	// Переменные хранящие старые очки комманды
    private _prevEast = -1; private _prevWest = -1;
    
    // Первоначальное отображение
    private _text = format[_template, _flag_OPFOR, _OPFOR_color, scoreSide east, _BLUEFOR_color, scoreSide west, _flag_BLUEFOR];
    
    // Запускаем перманентное отображение с большей длительностью
    private _dynamicText = [_text, 0, 1.3, 1e10, 0] spawn BIS_fnc_dynamicText;

	// Бесконечный цикл
    while {true} do {
        
		// Получаем очки комманд
		private _eastScore = scoreSide east;
		private _westScore = scoreSide west;
        
		// Проверка на то, что они изменились
        if (_eastScore != _prevEast || _westScore != _prevWest) then {
            
			// Обновляем текст
            _text = format[_template, _flag_OPFOR, _OPFOR_color, _eastScore, _BLUEFOR_color, _westScore, _flag_BLUEFOR];
            
        	// Убиваем старый текст если он есть
           	if (!isNil "_dynamicText") then { terminate _dynamicText };

		   	// Перезапускаем отображение с обновленным текстом
		   	_dynamicText = [_text, 0, 1.3, 1e10, 0] spawn BIS_fnc_dynamicText;
            
			// Запоминаем старые очки
            _prevEast = _eastScore; _prevWest = _westScore;
        };

		// Задержка
        sleep 1;
    };
};
