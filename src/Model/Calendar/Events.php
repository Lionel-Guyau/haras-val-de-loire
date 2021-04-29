<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Model\Calendar;

use App\Model\AbstractManager;
use DateTime;

class Events extends AbstractManager
{

    public const TABLE = 'activity';

    /**
     * Récupère les évènements commançant entre 2 dates
     * @param \DateTime $start
     * @param \DateTime $end
     * @return array
     */
    public function getEventsBetween(DateTime $start, DateTime $end): array
    {
        $start = $start->format('Y-m-d 00:00:00');
        $end = $end->format('Y-m-d 23:59:59');
        $query =
                "SELECT * 
                FROM activity
                    INNER JOIN planning ON activity.id = planning.activity_id
                WHERE planning.start_at BETWEEN '$start' AND '$end'
                ORDER BY activity.type, planning.start_at ASC";

        return $this->pdo->query($query)->fetchAll();
    }
}
