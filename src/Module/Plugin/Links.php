<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\Plugin;

use CRM\App\Module\Plugin;

class Links extends Plugin
{
    public function mainMenu()
    {
        if($this->acl('mod.Contractor.Contractor', 'mod.Contractor')->isAllowed('core.module'))
        {
            return [
                [
                    'ordering' => 0,
                    'icon' => 'fa fa-briefcase',
                    'name' => $this->t('contractors'),
                    'href' => $this->createUrl('Contractor', 'Contractor'),
                    'module' => 'Contractor'
                ]
            ];
        }
    }
}
