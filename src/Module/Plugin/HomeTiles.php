<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\Plugin;

use CRM\App\Module\Plugin;

class HomeTiles extends Plugin
{
    public function tilesGet()
    {
        if($this->acl('mod.Contractor.Tile', 'mod.Contractor')->isAllowed('mod.contractor.tile.newcontractors') === false)
        {
            return;
        }

        $repo = $this->repo('Contractor', 'Contractor');

        $thisMonth = new \DateTime('now');
        $firstDay  = (new \DateTime(date('01-m-Y', $thisMonth->getTimestamp())))->getTimestamp(); // hard-coded '01' for first day
        $lastDay   = (new \DateTime(date('t-m-Y', $thisMonth->getTimestamp())))->getTimestamp();

        $thisMonth = $repo->countCreatedInPeriod($firstDay, $lastDay);

        $prevMonth = new \DateTime('- 1 month');

        $firstDay  = (new \DateTime(date('01-m-Y', $prevMonth->getTimestamp())))->getTimestamp(); // hard-coded '01' for first day
        $lastDay   = (new \DateTime(date('t-m-Y', $prevMonth->getTimestamp())))->getTimestamp();

        $prevMonth = $repo->countCreatedInPeriod($firstDay, $lastDay);

        return [
            [
                'color'   => 'tile-primary',
                'icon'    => '<i class="fa fa-briefcase"></i>',
                'heading' => $this->t('contractorNewClients'),
                'value'   => $thisMonth.' ',
                'footer'  => ($prevMonth == 0 ? '+'.$thisMonth.'00%' : (($thisMonth / $prevMonth) * 100).'%'),
            ]
        ];
    }
}
