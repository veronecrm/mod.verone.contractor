<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\ORM;

use CRM\ORM\Repository;
use CRM\ORM\Entity;

class ContactRepository extends Repository
{
    public $dbTable = '#__contractor_contact';

    public function findByContractor($contractorId)
    {
        return $this->selectQuery("SELECT * FROM `{$this->dbTable}` WHERE contractorId = :contractorId", [ 'contractorId' => $contractorId ]);
    }

    public function findAllByEmail($email)
    {
        return $this->selectQuery("SELECT * FROM `{$this->dbTable}` WHERE email = :email", [ 'email' => $email ]);
    }

    public function getFieldsNames()
    {
        return [
            'id'          => 'ID',
            'owner'       => $this->t('recordOwner'),
            'firstName'   => $this->t('firstName'),
            'lastName'    => $this->t('lastName'),
            'phone'       => $this->t('phoneNumber'),
            'officePhone' => $this->t('officePhoneNumber'),
            'email'       => $this->t('emailAddress'),
            'companyName' => $this->t('companyName'),
            'positionInCompany' => $this->t('positionInCompany'),
            'description' => $this->t('enterDescription'),
            'created'     => $this->t('addDate'),
            'modified'    => $this->t('modificationDate')
        ];
    }

    public function getEndValue(Entity $entity, $field)
    {
        if($field == 'owner')
        {
            $user = $this->repo('User', 'User')->find($entity->getOwner());

            if($user)
                return $user->getName().' (ID:'.$entity->getOwner().')';
            else
                return $entity->getOwner();
        }

        return parent::getEndValue($entity, $field);
    }

    public function getBussinessCardDetails(Contact $entity)
    {
        $contractor = $this->repo('Contractor', 'Contractor')->find($entity->getContractorId());

        if(! $contractor)
        {
            $contractor = $this->entity('Contractor', 'Contractor');
        }

        $result = new \stdClass;
        $result->id     = $entity->getId();
        $result->name   = $entity->getName();
        $result->phone  = $entity->getPhone();
        $result->email  = $entity->getEmail();
        $result->companyName  = $entity->getCompanyName() ? $entity->getCompanyName() : $contractor->getCompanyName();
        $result->position     = $entity->getPositionInCompany();
        $result->isContractor = false;

        return $result;
    }
}
