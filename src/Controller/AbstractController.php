<?php

/**
 * Created by PhpStorm.
 * User: root
 * Date: 11/10/17
 * Time: 15:38
 * PHP version 7
 */

namespace App\Controller;

use App\Service\AuthService;
use Twig\Environment;
use Twig\Extension\DebugExtension;
use Twig\Loader\FilesystemLoader;

abstract class AbstractController
{
    /**
     * @var Environment
     */
    protected Environment $twig;

    /**
     *  Initializes this class.
     */
    public function __construct()
    {
        $loader = new FilesystemLoader(APP_VIEW_PATH);
        $this->twig = new Environment(
            $loader,
            [
                'cache' => !APP_DEV, // @phpstan-ignore-line
                'debug' => APP_DEV,
            ]
        );
        $this->twig->addExtension(new DebugExtension());

        /**
         *  Class AuthService pour retourner la variable $_SESSION
         *  Et pouvoir l'afficher dans le Twig avec condition.
         */
        $authService = new AuthService();
        $this->twig->addGlobal('is_logged', $authService->isLogged());
        $this->twig->addGlobal('user', $authService->getUser());
    }
}
