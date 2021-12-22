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

