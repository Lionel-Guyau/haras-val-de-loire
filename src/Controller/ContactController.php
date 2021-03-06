<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\ContactManager;

class ContactController extends AbstractController
{
    /**
     * Display contact page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    public function index()
    {
        return $this->twig->render('/Contact/contact.html.twig');
    }

    public function add()
    {
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $email = $_POST['email'];
        $number = $_POST['number'];
        $subject = $_POST['subject'];
        $message = $_POST['message'];
        $hasSentMessage = false;

        if ($_SERVER["REQUEST_METHOD"] === 'POST') {
            // test des valeurs d'entrées ($_POST)
            if (
                !empty($firstname) &&
                !empty($lastname) &&
                !empty($email) &&
                !empty($subject) &&
                !empty($message) &&
                !empty($number) &&
                filter_var($email, FILTER_VALIDATE_EMAIL)
            ) {
                // intégrer les valeurs dans une table $contactInfos
                $contactInfos = [
                    'firstname' => $firstname,
                    'lastname' => $lastname,
                    'email' => $email,
                    'subject' => $subject,
                    'message' => $message,
                    'number' => $number,
                ];

                // appeler la requête SQL $this->addContactInfo($contactInfos)
                $objetModel = new ContactManager();
                $objetModel->addContactInfo($contactInfos);
                $hasSentMessage = true;
                // est égal à (new ContactManager())-> addContactInfo($contactInfos);
            }
        }

        // retourne sur la page Contact
        return $this->twig->render('/Contact/contact.html.twig', [
            'hasSentMessage' => $hasSentMessage,
        ]);
    }
}
