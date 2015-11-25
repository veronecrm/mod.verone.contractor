<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\Controller;

use CRM\App\Controller\BaseController;

/**
 * @section mod.Contractor.Contact
 */
class Contact extends BaseController
{
    /**
     * @access core.write
     */
    public function addAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        return $this->render('form', [
            'contractor' => $contractor,
            'contact'    => $this->entity('Contact')
        ]);
    }

    /**
     * @access core.write
     */
    public function saveAction($request)
    {
        $contact = $this->entity('Contact')->fillFromRequest($request);
        $contact->setOwner($this->user()->getId());
        $contact->setCreated(time());

        $this->repo('Contact')->save($contact);

        $this->openUserHistory($contact)->flush('create', $this->t('contractorContact'));

        $this->flash('success', $this->t('contractorContactSaved'));

        if($request->request->has('apply'))
            return $this->redirect('Contractor', 'Contact', 'edit', [ 'id' => $contact->getId() ]);
        else
            return $this->redirect('Contractor', 'Contact', 'summary', [ 'id' => $contact->getId() ]);
    }

    /**
     * @access core.read
     */
    public function editAction($request)
    {
        $contact = $this->repo('Contact')->find($request->get('id'));

        if(! $contact)
        {
            $this->flash('danger', $this->t('contractorContactDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $contractor = $this->repo()->find($contact->getContractorId());

        if(! $contractor)
        {
            $contractor = $this->entity('Contractor');
        }

        return $this->render('form', [
            'contact' => $contact,
            'contractor' => $contractor,
            'owner' => $this->repo('User', 'User')->findWithComplement($contact->getOwner())
        ]);
    }

    /**
     * @access core.write
     */
    public function updateAction($request)
    {
        $contact = $this->repo('Contact')->find($request->get('id'));

        if(! $contact)
        {
            $this->flash('danger', $this->t('contractorContactDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $log = $this->openUserHistory($contact);

        $contact->fillFromRequest($request);
        $contact->setModified(time());

        $this->repo('Contact')->save($contact);

        $log->flush('change', $this->t('contractorContact'));

        $this->flash('success', $this->t('contractorContactSaved'));

        if($request->request->has('apply'))
            return $this->redirect('Contractor', 'Contact', 'edit', [ 'id' => $contact->getId() ]);
        else
            return $this->redirect('Contractor', 'Contact', 'summary', [ 'id' => $contact->getId() ]);
    }

    /**
     * @access core.delete
     */
    public function deleteAction($request)
    {
        $contact = $this->repo('Contact')->find($request->get('id'));

        if(! $contact)
        {
            $this->flash('danger', $this->t('contractorContactDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $this->repo('Contact')->delete($contact);

        $this->openUserHistory($contact)->flush('delete', $this->t('contractorContact'));

        $this->flash('success', $this->t('contractorContactDeletedSuccess'));

        return $this->redirect('Contractor', 'Contractor', 'summary', [ 'id' => $contact->getContractorId() ]);
    }

    /**
     * @access core.read
     */
    public function summaryAction($request)
    {
        $contact = $this->repo('Contact')->find($request->get('id'));

        if(! $contact)
        {
            $this->flash('danger', $this->t('contractorContactDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }
        $contractor = $this->repo()->find($contact->getContractorId());

        if(! $contractor)
        {
            $contractor = $this->entity('Contractor');
        }

        return $this->render('summary', [
            'contractor' => $contractor,
            'contact' => $contact,
            'owner'   => $this->repo('User', 'User')->findWithComplement($contact->getOwner()),
            'entity'  => null
        ]);
    }
}
