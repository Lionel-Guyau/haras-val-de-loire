<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\LoginManager;

class LoginController extends AbstractController
{
    /**
     * Display login page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    public function index()
    {
        // On initialise $error
        $error = '';

        // Si l'utilisateur est connecté et qu'il tente d'aller sur login, il est redirigé
        if (isset($_SESSION['email']) && isset($_SESSION['pass'])) {
            header('Location: /');
        }

        // Si les champs du formulaire ne sont pas vides, on appelle la class LoginManager pour 
        // requêter en BDD et retourner l'utilisateur. 
        if (!empty($_POST['email']) && !empty($_POST['pass'])) {

            $loginManager = new LoginManager();
            $user = $loginManager->connectAdminUser($_POST['email']);

            // On vérifie que l'utilisateur en BDD et le mdp haché soit identique aux saisies des champs du formulaire.
            if (!empty($user) && password_verify($_POST['pass'], $user['password'])) {

                // Si c'est vérifié, alors on enregistre le user en session
                $_SESSION['user'] = $user;

                // Et on redirige vers admin
                header('Location: /admin');
                exit;
            } else {
                // Sinon on affiche le message d'erreur
                $error = 'Utilisateur ou mot de passe incorrect !';
            }
        }
        // On passe $error au Twig pour l'afficher sur la page
        return $this->twig->render('/Login/login.html.twig', [
            'error' => $error
        ]);
    }
}
