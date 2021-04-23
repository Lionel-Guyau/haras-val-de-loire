<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\AdminManager;

class AdminController extends AbstractController
{
    /**
     * Display home page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    public function index()
    {
        return $this->twig->render('/Admin/admin.html.twig');
    }

    public function controlDataPost($input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'POST') {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }

    public function controlDataGet(string $input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'GET') {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }

    public function testInput($data)
    {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    public function news()
    {
        $adminManager = new AdminManager();
        $selectNews = $adminManager->selectNews();

        return $this->twig->render('/Admin/adminNews.html.twig', ['selectnews' => $selectNews]);
    }

    public function addNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataPost($_POST['description'])) {
            $description = $this->testInput($_POST['description']);

            if (strlen($description) < 50) {
                $adminManager->insertNews($description);
            } else {
                echo 'Texte supérieur à 50 charactères';
            }
        } else {
            echo 'Veuillez rentrer un champ';
        }
        header('Location: /admin/news');
    }

    public function delNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataGet($_GET['id'])) {
            $id = $this->testInput($_GET['id']);
            if (filter_var($id, FILTER_VALIDATE_INT)) {
                $adminManager->deleteNews($id);
            } else {
                echo 'Veuillez rentrer un champ valide';
            }
        } else {
            echo 'Veuillez ne pas toucher aux liens des boutons';
        }
        header('Location: /admin/news');
    }

    public function majNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataPost($_POST['description']) && $this->controlDataPost($_POST['id'])) {
            $id = $this->testInput($_POST['id']);
            $description = $this->testInput($_POST['description']);

            if (strlen($description) < 50 && filter_var($id, FILTER_VALIDATE_INT)) {
                $adminManager->updateNews($id, $description);
            } else {
                echo 'Veuillez rentrer des champs valides';
            }
        } else {
            echo 'Veuillez rentrer des champs';
        }
        header('Location: /admin/news');
    }
}
