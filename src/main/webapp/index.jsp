<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp-config development="true"/>
<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>Web Programming №2</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<!-- Шапка -->
<div class="header">
    <span>
        Rudenko Ilya, P32101
    </span>
    <div>Variant 1204</div>
</div>

<!-- Основная часть -->
<div class="main">
    <div class="main_window" >
    <svg xmlns="http://www.w3.org/2000/svg" id="graph">

        <!-- Оси координат -->
        <line stroke="black" x1="0" y1="175" x2="350" y2="175"/>
        <line stroke="black" x1="175" y1="0" x2="175" y2="350"/>

        <!-- Стрелки к осям -->
        <polygon points="175,0 170,15 180,15" stroke="black"></polygon>
        <polygon points="350,175 335,170 335,180" stroke="black"></polygon>

        <!-- Значения на осях -->
        <text x="335" y="165" font-size="25">x</text>
        <text x="185" y="15" font-size="25">y</text>

        <!-- Метки на оси X -->
        <line stroke="black" x1="45" y1="170" x2="45" y2="180"/>
        <line stroke="black" x1="110" y1="170" x2="110" y2="180"/>
        <line stroke="black" x1="240" y1="170" x2="240" y2="180"/>
        <line stroke="black" x1="305" y1="170" x2="305" y2="180"/>

        <!-- Метки на оси Y -->
        <line stroke="black" x1="170" y1="45" x2="180" y2="45"/>
        <line stroke="black" x1="170" y1="110" x2="180" y2="110"/>
        <line stroke="black" x1="170" y1="240" x2="180" y2="240"/>
        <line stroke="black" x1="170" y1="305" x2="180" y2="305"/>

        <!-- Подписи к меткам на оси X -->
        <text x="35" y="160" font-size="20">-R</text>
        <text x="90" y="160" font-size="20">-R/2</text>
        <text x="225" y="160" font-size="20">R/2</text>
        <text x="305" y="160" font-size="20">R</text>

        <!-- Подписи к меткам на оси Y -->
        <text x="185" y="45" font-size="20">R</text>
        <text x="185" y="115" font-size="20">R/2</text>
        <text x="185" y="245" font-size="20">-R/2</text>
        <text x="185" y="315" font-size="20">-R</text>

        <!-- 2-я четверть -->
        <polygon points="175,175 45,175 175,110" fill="blue" fill-opacity="0.4"></polygon>

        <!-- 1-я четверть -->
        <polygon points="175,175 175,45 305,175" fill="blue" fill-opacity="0.4"></polygon>
        <path fill="blue" fill-opacity="0.4"
              d="M175,45 A130,130 50 0,1 305,175" L 150,150 Z></path>

        <!-- 4-я четверть -->
        <polygon points="175,175 305,175 305,305 175,305" fill="blue" fill-opacity="0.4"></polygon>

    </svg>

    <form id="input-form" action="/control" class="validate_form" method="post"> <!-- координаты -->
        <!-- Блок взаимодействия с пользователем -->
        <div class="forUsers">
            <div class="xCoordinate"> </div>
            <text>Select X coordinate:</text>
            <div class="form_radio_group">
                <div class="form_radio_group-item">
                    <input id="radio--5" type="radio" name="X" value="-5" class="X">
                    <label for="radio--5">-5</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio--4" type="radio" name="X" value="-4" class="X">
                    <label for="radio--4">-4</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio--3" type="radio" name="X" value="-3" class="X">
                    <label for="radio--3">-3</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio--2" type="radio" name="X" value="-2" class="X">
                    <label for="radio--2">-2</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio--1" type="radio" name="X" value="-1" class="X">
                    <label for="radio--1">-1</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio-0" type="radio" name="X" value="0" class="X">
                    <label for="radio-0">0</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio-1" type="radio" name="X" value="1" class="X">
                    <label for="radio-1">1</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio-2" type="radio" name="X" value="2" class="X">
                    <label for="radio-2">2</label>
                </div>
                <div class="form_radio_group-item">
                    <input id="radio-3" type="radio" name="X" value="3" class="X">
                    <label for="radio-3">3</label>
                </div>
            </div>

            <!-- Блок для значения Y -->
            <div class="Y_value">
                <text>Input Y coordinate:</text>
                <input autocomplete="off" type="number" id="Y" name="Y" class="y" placeholder="Value [-3...5]">
            </div>

            <!-- Блок для значения R -->
            <div class="R_value">
                <text>Select R value:</text>
                <span class="R_options">
                    <button id="R1" value="1" class="R" >1</button>
                    <button id="R2" value="2" class="R" >2</button>
                    <button id="R3" value="3" class="R" >3</button>
                    <button id="R4" value="4" class="R" >4</button>
                    <button id="R5" value="5" class="R" >5</button>
                </span>
            </div>
            <input type="hidden" id="hiddenR" name="R" value="">

            <!-- Блок кнопок -->
            <div class="buttons">
                <input id="check" name="check" type="submit" value="Check" class="check_button">
                <input id="reset" name="reset" type="reset" value="Reset" class="reset_button">
            </div>
        </div>
    </form>
    </div>

    <!-- Блок графика -->


    <!-- Блок таблицы результатов -->
    <div>
        <jsp:include page="all_table.jsp" />
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>