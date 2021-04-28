<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Controller\Calendar\Calendar;
use App\Model\Calendar\Events;

class ActivityController extends AbstractController
{
    /**
     * Display activity page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    /**
     * Page par défault lors de l'arrivée sur xxx/activity
     */
    public function index()
    {
        $calendarInfo = new Calendar();
        $calendarInfo = $calendarInfo->getCalendarInfo();

        $events = new Events();
        $start = $calendarInfo['firstDay'];
        $end = (clone $start)->modify("+" . ($calendarInfo['weeks'] * 7 - 1) . " days");

        $eventsForDays = $events->getEventsBetweenByDay($start, $end);


        return $this->twig->render(
            '/Activity/activity.html.twig',
            [
                'calendarInfo' => $calendarInfo,
                'eventsForDays' => $eventsForDays
            ]
        );
    }
}
