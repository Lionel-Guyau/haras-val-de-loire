<?php

namespace App\Controller\Calendar;

use Exception;
use DateTime;

class Month
{
    private $months = [
        'Janvier',
        'Février',
        'Mars',
        'Avril',
        'Mai',
        'Juin',
        'Juillet',
        'Août',
        'Septembre',
        'Octobre',
        'Novembre',
        'Decembre'
    ];
    public $month;
    public $year;
    public $days = [
        'Lundi',
        'Mardi',
        'Mercredi',
        'Jeudi',
        'Vendredi',
        'Samedi',
        'Dimanche'
    ];

    /**
     * Month constructor
     * @param int $month Le mois compris entre 1 et 12
     * @param int $year L'année
     * @throws \Exception
     */
    public function __construct(?int $month = null, ?int $year = null)
    {
        if ($month === null) {
            $month = intval(date('m'));
        }

        if ($year === null) {
            $year = intval(date('Y'));
        }

        if (($month < 1) || ($month > 12)) {
            throw new Exception("Le mois $month n'est pas valide");
        }

        if ($year < 1970) {
            throw new Exception("L'année $year n'est pas valide (inférieur à 1970)");
        }

        $this->month = $month;
        $this->year = $year;
    }

    /**
     * Retourne le mois en toute lettre (ex: Mars 2018)
     * @return string
     */
    public function __toString(): string
    {
        return $this->months[$this->month - 1] . ' ' . $this->year;
    }

    /**
     * Renvoi le nombre de semaine que contient le mois
     * @return int
     */
    public function getWeeks(): int
    {
        $start = $this->getStartingDay();
        $end = (clone $start)->modify('+1 month -1 day');
        $weeks = intval($end->format('W')) - intval($start->format('W')) + 1;
        if ($weeks < 0) {
            $weeks = intval($end->format('W')) + 1;
        }
        return $weeks;
    }

    /**
     * Renvoie le premier jour du mois affiché
     * @return DateTime
     */
    public function getStartingDay(): DateTime
    {
        return new DateTime("{$this->year}-{$this->month}-01");
    }

    /**
     * Renvoi la liste des jours de la semaine
     * @return array
     */
    public function getDays(): array
    {
        return $this->days;
    }

    /**
     * Renvoi le mois suivant
     * @return Month
     */
    public function nextMonth(): Month
    {
        $month = $this->month + 1;
        $year = $this->year;
        if ($month > 12) {
            $month = 1;
            $year += 1;
        }
        return new Month($month, $year);
    }

    /**
     * Renvoi le mois précédent
     * @return Month
     */
    public function previousMonth(): Month
    {
        $month = $this->month - 1;
        $year = $this->year;
        if ($month < 1) {
            $month = 12;
            $year -= 1;
        }
        return new Month($month, $year);
    }
}
