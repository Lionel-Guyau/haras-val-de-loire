<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\ActivityManager;

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

    public function index()
    {
        return $this->twig->render('/Activity/activity.html.twig');
    }

    public function register()
    {
        $activity = new ActivityManager();
        $activityType = $activity->selectActivity();
        $plannedActivity = $activity->selectPlannedActivity();
        $plannedActivityOrdered = $this->orderingActivitiesByType($plannedActivity);

        return $this->twig->render('/Activity/register.html.twig', [
            'activityType' => $activityType,
            'plannedActivityOrdered' => $plannedActivityOrdered
        ]);
    }


    public function showActivity()
    {
        $activityManager = new ActivityManager();
        $activities = $activityManager->selectActivity();

        return $this->twig->render('/Activity/activity.html.twig', [
            'activities' => $activities,
        ]);
        return $this->twig->render('/Activity/register.html.twig');
    }

    public function orderingActivitiesByType(array $plannedActivity): array
    {
        $typedActivity = [];

        // echo '<pre>';
        // print_r($plannedActivity);
        // echo '</pre>';
        // exit;

        //ajoute les tableau dans $typedActivity selon une indéxation par une clé
        foreach ($plannedActivity as $activity) {

            //défini la clé qui va servir à indexer
            $type = $activity['type'];
            $date = explode(' ', $activity['start_at'])[0];
            // echo '<pre>';
            // print_r($type);
            // print_r($activity);
            // echo '</pre>';
            // exit;

            // $activity = $this->orderingActivitiesByDate($activity);

            // vérifie qu'il existe déjà ou non une indéxation avec la clé sélectionnée, sinon créé cette indéxation
            if (!isset($typedActivity[$type])) {

                // echo '<pre>';
                // print_r($activity);
                // echo '</pre>';
                // exit;


                //créer l'indéxation et ajout le tableau à l'intérieur
                $typedActivity[$type] = [$date => $activity];
            } else {

                //ajoute le tableau à l'intérieur
                $typedActivity[$type][$date] = $activity;
                // array_push($typedActivity[$type][$date], $activity);
            }
        }

        echo '<pre>';
        print_r($typedActivity);
        echo '</pre>';
        exit;

        return $typedActivity;
    }

    public function orderingActivitiesByDate(array $activity): array
    {
        $typedActivity = [];

        // echo '<pre>';
        // print_r($activity);
        // echo '</pre>';
        // exit;

        //défini la clé qui va servir à indexer
        $type = explode(' ', $activity['start_at'])[0];

        // echo '<pre>';
        // print_r($type);
        // echo '</pre>';
        // exit;

        foreach ($activity as $key => $line) {

            // vérifie qu'il existe déjà ou non une indéxation avec la clé sélectionnée, sinon créé cette indéxation
            if (!isset($typedActivity[$type])) {

                //créer l'indéxation et ajout le tableau à l'intérieur
                $typedActivity[$type] = [$key => $line];
            } else {

                //ajoute le tableau à l'intérieur
                $typedActivity[$type][$key] = $line;
            }
        }


        // echo '<pre>';
        // print_r($typedActivity);
        // echo '</pre>';
        // exit;

        return $typedActivity;
    }
}

// /**
//      * Récupère les évènements commançant entre 2 dates
//      * @param \DateTime $start
//      * @param \DateTime $end
//      * @return array
//      */
//     public function getEventsBetween(DateTime $start, DateTime $end): array
//     {
//         $start = $start->format('Y-m-d 00:00:00');
//         $end = $end->format('Y-m-d 23:59:59');
//         $query =
//                 "SELECT * 
//                 FROM activity
//                     INNER JOIN planning ON activity.id = planning.activity_id
//                 WHERE planning.start_at BETWEEN '$start' AND '$end'";

//         return $this->pdo->query($query)->fetchAll();
//     }

//     /**
//      * Récupère les évènements commançant entre 2 dates par jour
//      * @param \DateTime $start
//      * @param \DateTime $end
//      * @return array
//      */
//     public function getEventsBetweenByDay(DateTime $start, DateTime $end): array
//     {
//         $events = $this->getEventsBetween($start, $end);
//         $days = [];
//         foreach ($events as $event) {
//             $date = explode(' ', $event['start_at'])[0]; //'2021-04-05'
//             if (!isset($days[$date])) {
//                 $days[$date] = [$event];
//             } else {
//                 $days[$date][] = $event;
//             }
//         }

//         return $days;
//     }
