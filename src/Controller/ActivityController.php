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


        //ajoute les tableau dans $typedActivity selon une indéxation par une clé
        foreach ($plannedActivity as $activity) {

            //défini la clé qui va servir à indexer
            $type = $activity['type'];
            $date = explode(' ', $activity['start_at'])[0];

            // $activity = $this->orderingActivitiesByDate($activity);

            // vérifie qu'il existe déjà ou non une indéxation avec la clé sélectionnée, sinon créé cette indéxation
            if (!isset($typedActivity[$type][$date])) {

                //créer l'indéxation et ajout le tableau à l'intérieur
                $typedActivity[$type][$date] = [$activity];
            } else {

                //ajoute le tableau à l'intérieur
                $typedActivity[$type][$date][] = $activity;
                // array_push($typedActivity[$type][$date], $activity);
            }
        }

        return $typedActivity;
    }
}
