<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\HomeManager;
use App\Model\ActivityManager;

class HomeController extends AbstractController
{
    /**
     * Display home page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    public function index(): string
    {
        $homeManager = new HomeManager();
        $lastNews = $homeManager->selectLastNews();

        $activityManager = new ActivityManager();
        $lastEvents = $activityManager->selectLastEvents();

        return $this->twig->render('/Home/index.html.twig', ['lastnews' => $lastNews, 'lastevents' => $lastEvents]);
    }
}
