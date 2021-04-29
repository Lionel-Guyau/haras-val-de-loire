<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller\Calendar;

use App\Controller\Calendar\Month;
use App\Model\Calendar\Events;
use DateTime;

class Calendar
{
    /**
     * Return calendar information
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    /**
     * Renvoi un tableau contenant les informations liées au mois
     * sélectionné
     * @return array
     */
    public function getCalendarInfo(): array
    {
        try {
            $selectedMonthYear = new Month($_GET['month'] ?? null, $_GET['year'] ?? null);
        } catch (\Exception $e) {
            $selectedMonthYear = new Month();
        }

        $firstDay = $selectedMonthYear->getStartingDay();
        if ($firstDay->format('N') !== '1') {
            $firstDay = (clone $selectedMonthYear)->getStartingDay()->modify('last monday');
        }

        if ($selectedMonthYear->month < 10) {
            $actualMonth = new DateTime("$selectedMonthYear->year/0$selectedMonthYear->month/01");
        } else {
            $actualMonth = new DateTime("$selectedMonthYear->year/$selectedMonthYear->month/01");
        }

        return [
            'selectedMonthYear' => $selectedMonthYear,
            'weeks' => $selectedMonthYear->getWeeks(),
            'firstDay' => $firstDay,
            'days' => $selectedMonthYear->getDays(),
            'actualMonth' => $actualMonth,
            'nextMonth' => (clone $actualMonth)->modify('+1 month')->format('m'),
            'previousMonth' => (clone $actualMonth)->modify('-1 month')->format('m'),
            'nextYear' => (clone $actualMonth)->modify('+1 month')->format('Y'),
            'previousYear' => (clone $actualMonth)->modify('-1 month')->format('Y')
        ];
    }

    /**
     * Récupère les évènements commançant entre 2 dates par jour
     * @param \DateTime $start
     * @param \DateTime $end
     * @return array
     */
    public function getEventsBetweenByDay(DateTime $start, DateTime $end): array
    {
        $events = new Events();
        $eventsBetween = $events->getEventsBetween($start, $end);
        $days = [];
        foreach ($eventsBetween as $event) {
            $date = explode(' ', $event['start_at'])[0];
            if (!isset($days[$date])) {
                $days[$date] = [$event];
            } else {
                $days[$date][] = $event;
            }
        }

        return $days;
    }
}
