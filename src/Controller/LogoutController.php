<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

class LogoutController extends AbstractController
{
    /**
     * Display login page
     */

    public function index()
    {
        // On supprime la session
        session_destroy();
        // On redirige vers la racine du site
        header('Location: /');
    }
}
