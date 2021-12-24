/*SQL.1 - 1

Необходимо вывести все самолеты, максимальная дальность полета 
которых находится в пределах от 1300 до 5800 километров включительно. 
Элементы выборки должны быть упорядочены по возрастанию дальности полета.*/

/*SELECT model, range 
FROM aircrafts
WHERE range BETWEEN 1300 and 5800
ORDER BY range;
*/

/*SQL.1 - 2

Необходимо вывести все модели самолетов, на которых был совершен хотя бы
 один рейс, с указанием количества рейсов, выполненных на каждой модели. 
 Рейс считается выполненным, если самолет прибыл в пункт назначения. 
 Элементы выборки должны быть упорядочены по убыванию числа рейсов.*/

/*SELECT model, COUNT(status) AS flights_num
FROM 
	aircrafts INNER JOIN flights
	ON 	aircrafts.aircraft_code = flights.aircraft_code
WHERE status = 'Arrived'
GROUP BY model
HAVING COUNT(status) >= 1
ORDER BY flights_num DESC;*/

/*SQL.1 - 3

Требуется найти все рейсы, для которых средняя стоимость перелета более 3300,
но менее 5000 рублей.
Вхождения в выборку должны быть упорядочены по возрастанию flight_id.*/

/*SELECT flight_id, AVG(amount) as avg_amount
FROM ticket_flights
GROUP BY flight_id
HAVING (AVG(amount) > 3300) and (AVG(amount) < 5000)
ORDER BY flight_id;*/

/*SQL.1 - 4

Необходимо найти недополученную из-за отмены рейсов выручку авиакомпании */

/*SELECT 
	SUM(amount) as lost_profit
FROM
	ticket_flights inner join flights
	ON ticket_flights.flight_id = flights.flight_id
WHERE flights.status = 'Cancelled';*/

/*SQL.1 - 5
Необходимо найти недополученную из-за отмены рейсов выручку авиакомпании
 за период времени с 17 августа 2017 00:00:00 до 23 августа 2017 00:00:00
 включительно.*/

/*SELECT SUM(amount) as lost_profit
FROM 
	ticket_flights inner join flights
	ON ticket_flights.flight_id = flights.flight_id
WHERE (flights.scheduled_departure 
		BETWEEN '2017-08-17 00:00:00' AND '2017-08-23 00:00:00')
		AND flights.status = 'Cancelled';*/

/*SQL.2 - 1

Необходимо найти аэропорты вылета, из которых рейсы летают во Внуково (VKO), но не в Шереметьево (SVO).
То есть был запланирован рейс из данного аэропорта во Внуково, но ни разу не был запланирован рейс в Шереметьево.*/

/*select distinct f.departure_airport 
from flights f
left join flights b on b.departure_airport = f.departure_airport 
and b.arrival_airport = 'SVO'
where f.arrival_airport = 'VKO' and b.departure_airport is null*/

/*SQL.2 - 2*/

-- SELECT model, MAX(amount) as amount
-- FROM aircrafts
	-- inner join flights ON aircrafts.aircraft_code = flights.aircraft_code
	-- inner join ticket_flights ON flights.flight_id = ticket_flights.flight_id
-- WHERE fare_conditions = 'Business'
-- GROUP BY model
-- ORDER BY amount DESC;

/*SQL.2 - 3

Необходимо найти все рейсы за все месяцы из Шереметьево (код аэропорта SVO) в Ханты-Мансийск (код аэропорта HMA) 
с одним промежуточным аэропортом (пересадки, включенные в один билет, считать за один перелет).
Для каждой пары рейсов найдите минимальную сумму за билеты. Результирующую выборку отсортируйте по 
возрастанию полной суммы.*/

-- select f.flight_id as flight_id_1, e.flight_id as flight_id_2, 
-- min(w.amount) + min(r.amount) as total_amount
-- from flights f
-- inner join flights e on f.arrival_airport=e.departure_airport and e.arrival_airport = 'HMA'
-- inner join ticket_flights w on w.flight_id = f.flight_id
-- inner join ticket_flights r on r.flight_id = e.flight_id
-- where f.departure_airport = 'SVO' and  f.scheduled_arrival<e.scheduled_departure
-- group by f.flight_id, e.flight_id 


/*SQL.2 - 4

Найти все пары аэропортов, между которыми было больше одного рейса, которые должны были вылететь 24 августа 2017 года.*/

-- select  f.departure_airport, f.arrival_airport, count(f.flight_id) as amount
-- from flights f
-- where 
-- cast(strftime('%d.%m.%Y', f.scheduled_arrival) as date) = cast('24.08.2017' as date)
-- group by f.departure_airport, f.arrival_airport having count(f.flight_id)>1
-- order by  amount, departure_airport desc, arrival_airport desc 