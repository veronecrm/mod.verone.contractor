<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

return [
    [
        'name' => 'contractorsManage',
        'id' => 'mod.Contractor.Contractor',
        'access' => [
            [
                'id' => 'core.module',
                'name' => 'auth.core.module'
            ],
            [
                'id' => 'core.read',
                'name' => 'auth.core.read'
            ],
            [
                'id' => 'core.write',
                'name' => 'auth.core.write'
            ],
            [
                'id' => 'core.delete',
                'name' => 'auth.core.delete'
            ]
        ]
    ],
    [
        'name' => 'contractorContactManage',
        'id' => 'mod.Contractor.Contact',
        'access' => [
            [
                'id' => 'core.read',
                'name' => 'auth.core.read'
            ],
            [
                'id' => 'core.write',
                'name' => 'auth.core.write'
            ],
            [
                'id' => 'core.delete',
                'name' => 'auth.core.delete'
            ]
        ]
    ],
    [
        'name' => 'contractorTilesPermissions',
        'id' => 'mod.Contractor.Tile',
        'access' => [
            [
                'id' => 'mod.contractor.tile.newcontractors',
                'name' => 'contractorTileNewContractors'
            ]
        ]
    ]
];
