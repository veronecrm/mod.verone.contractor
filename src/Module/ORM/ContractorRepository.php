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
use CRM\Pagination\PaginationInterface;

class ContractorRepository extends Repository implements PaginationInterface
{
    public $dbTable = '#__contractor';

    /**
     * @see CRM\Pagination\PaginationInterface::paginationCount()
     */
    public function paginationCount()
    {
        $request = $this->request();

        $query = [];
        $binds = [];

        if($request->get('letter'))
        {
            $query[] = 'name LIKE :name';
            $binds[':name'] = $request->get('letter').'%';
        }
        if($request->get('q'))
        {
            $query[] = 'name LIKE \'%'.$request->get('q').'%\'';
            $binds[':q'] = $request->get('q');
        }

        return $this->countAll(implode(' AND ', $query), $binds);
    }

    /**
     * @see CRM\Pagination\PaginationInterface::paginationGet()
     */
    public function paginationGet($start, $limit)
    {
        $request = $this->request();

        $query = [];
        $binds = [];

        if($request->get('letter'))
        {
            $query[] = 'name LIKE :name';
            $binds[':name'] = $request->get('letter').'%';
        }
        if($request->get('q'))
        {
            $query[] = 'name LIKE \'%'.$request->get('q').'%\'';
            $binds[':q'] = $request->get('q');
        }

        return $this->findAll(implode(' AND ', $query), $binds, $start, $limit);
    }

    public function findAll($conditions = '', array $binds = [], $start = null, $limit = null)
    {
        $pagination = '';

        if($start !== null && $limit !== null)
        {
            $pagination = "LIMIT $start, $limit";
        }

        if($conditions != '')
        {
            $conditions = "WHERE {$conditions}";
        }

        return $this->doPostSelect($this->prepareAndExecute("SELECT * FROM `{$this->dbTable}` {$conditions} ORDER BY name ASC {$pagination}", $binds, true));
    }

    public function findAllByEmail($email)
    {
        return $this->selectQuery("SELECT * FROM `{$this->dbTable}` WHERE email = :email", [ 'email' => $email ]);
    }

    public function countCreatedInPeriod($from, $to)
    {
        return $this->countAll('created >= :from AND created <= :to', [
            ':from' => $from,
            ':to'   => $to,
        ]);
    }

    public function getFieldsNames()
    {
        return [
            'id'          => 'ID',
            'owner'       => $this->t('recordOwner'),
            'name'        => $this->t('contractorName'),
            'type'        => $this->t('contractorType'),
            'positionInCompany' => $this->t('positionInCompany'),
            'companyName' => $this->t('companyName'),
            'websiteUrl'  => $this->t('website'),
            'phone'       => $this->t('phoneNumber'),
            'email'       => $this->t('emailAddress'),
            'trade'       => $this->t('trade'),
            'nip'         => $this->t('contractorNIP'),
            'regon'       => $this->t('contractorREGON'),
            'bankAccountNumber'     => $this->t('bankAccountNumber'),
            'billAddressStreet'     => $this->t('contractorBillingAddress').' - '.$this->t('streetFull'),
            'billAddressCity'       => $this->t('contractorBillingAddress').' - '.$this->t('city'),
            'billAddressState'      => $this->t('contractorBillingAddress').' - '.$this->t('state'),
            'billAddressPostalCode' => $this->t('contractorBillingAddress').' - '.$this->t('postalCode'),
            'billAddressCountry'    => $this->t('contractorBillingAddress').' - '.$this->t('country'),
            'shippAddressStreet'    => $this->t('contractorShippingAddress').' - '.$this->t('streetFull'),
            'shippAddressCity'      => $this->t('contractorShippingAddress').' - '.$this->t('city'),
            'shippAddressState'     => $this->t('contractorShippingAddress').' - '.$this->t('state'),
            'shippAddressPostalCode'=> $this->t('contractorShippingAddress').' - '.$this->t('postalCode'),
            'shippAddressCountry'   => $this->t('contractorShippingAddress').' - '.$this->t('country'),
            'description' => $this->t('enterDescription'),
            'created'     => $this->t('addDate'),
            'modified'    => $this->t('modificationDate')
        ];
    }

    public function getExportFieldsNames()
    {
        return [
            'id'          => 'ID',
            'name'        => $this->t('contractorName'),
            'type'        => $this->t('contractorType'),
            'positionInCompany' => $this->t('positionInCompany'),
            'companyName' => $this->t('companyName'),
            'websiteUrl'  => $this->t('website'),
            'phone'       => $this->t('phoneNumber'),
            'email'       => $this->t('emailAddress'),
            'trade'       => $this->t('trade'),
            'nip'         => $this->t('contractorNIP'),
            'regon'       => $this->t('contractorREGON'),
            'bankAccountNumber'     => $this->t('bankAccountNumber'),
            'billAddressStreet'     => $this->t('contractorBillingAddress').' - '.$this->t('streetFull'),
            'billAddressCity'       => $this->t('contractorBillingAddress').' - '.$this->t('city'),
            'billAddressState'      => $this->t('contractorBillingAddress').' - '.$this->t('state'),
            'billAddressPostalCode' => $this->t('contractorBillingAddress').' - '.$this->t('postalCode'),
            'billAddressCountry'    => $this->t('contractorBillingAddress').' - '.$this->t('country'),
            'shippAddressStreet'    => $this->t('contractorShippingAddress').' - '.$this->t('streetFull'),
            'shippAddressCity'      => $this->t('contractorShippingAddress').' - '.$this->t('city'),
            'shippAddressState'     => $this->t('contractorShippingAddress').' - '.$this->t('state'),
            'shippAddressPostalCode'=> $this->t('contractorShippingAddress').' - '.$this->t('postalCode'),
            'shippAddressCountry'   => $this->t('contractorShippingAddress').' - '.$this->t('country'),
            'description' => $this->t('enterDescription')
        ];
    }

    public function getEndValue(Entity $entity, $field)
    {
        if($field == 'type')
        {
            if($entity->getType() == 1)
                return $this->t('contractorTypePerson');
            if($entity->getType() == 2)
                return $this->t('contractorTypeCompany');
        }

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

    public function getBussinessCardDetails(Contractor $entity)
    {
        $result = new \stdClass;
        $result->id     = $entity->getId();
        $result->name   = $entity->getName();
        $result->phone  = $entity->getPhone();
        $result->email  = $entity->getEmail();
        $result->companyName  = $entity->getCompanyName();
        $result->position     = $entity->getPositionInCompany();
        $result->isContractor = true;

        return $result;
    }
}
