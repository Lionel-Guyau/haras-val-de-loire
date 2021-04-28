<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Model\Calendar;

use App\Model\AbstractManager;

class Events extends AbstractManager
{

    public const TABLE = 'course';
    public const TABLE2 =  'lesson';

    /**
     * Récupère les évènements commançant entre 2 dates
     * @param \DateTime $start
     * @param \DateTime $end
     * @return array
     */
    public function getEventsBetween(\DateTime $start, \DateTime $end): array
    {
        $start = $start->format('Y-m-d 00:00:00');
        $end = $end->format('Y-m-d 23:59:59');
        $query = "SELECT * FROM " . static::TABLE . " WHERE start_at BETWEEN '$start' AND '$end' AND is_active = 1";

        return $this->pdo->query($query)->fetchAll();
    }

    /**
     * Récupère les évènements commançant entre 2 dates par jour
     * @param \DateTime $start
     * @param \DateTime $end
     * @return array
     */
    public function getEventsBetweenByDay(\DateTime $start, \DateTime $end): array
    {
        $events = $this->getEventsBetween($start, $end);
        $days = [];
        foreach ($events as $event) {
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
