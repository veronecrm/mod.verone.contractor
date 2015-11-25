<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\Controller;

use CRM\App\Controller\BaseController;
use CRM\Pagination\Paginator;

/**
 * @section mod.Contractor.Contractor
 */
class Contractor extends BaseController
{
    /**
     * @access core.module
     */
    public function indexAction($request)
    {
        $paginator = new Paginator($this->repo(), $request->get('page'), $this->createUrl($this->request()->query->all()));

        return $this->render('', [
            'elements'    => $paginator->getElements(),
            'pagination'  => $paginator
        ]);
    }

    /**
    * @access core.read
    */
    public function copyAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $repo = $this->repo('Event', 'Calendar');

        $contractor->setId(null);

        return $this->render('form', [
            'contractor' => $contractor
        ]);
    }

    /**
     * @access core.write
     */
    public function addAction()
    {
        return $this->render('form', [
            'contractor' => $this->entity()
        ]);
    }

    /**
     * @access core.write
     */
    public function saveAction($request)
    {
        $existing = $this->repo()->findAll('name = :name', [ ':name' => $request->get('name') ]);

        if($existing)
        {
            $this->flash('warning', $this->t('contractorWithNameExists'));
            return $this->redirect('Contractor', 'Contractor', 'add');
        }

        $contractor = $this->entity()->fillFromRequest($request);
        $contractor->setOwner($this->user()->getId());
        $contractor->setCreated(time());

        $this->repo()->save($contractor);

        $this->openUserHistory($contractor)->flush('create', $this->t('contractor'));

        $this->flash('success', $this->t('contractorSaved'));

        if($request->request->has('apply'))
            return $this->redirect('Contractor', 'Contractor', 'edit', [ 'id' => $contractor->getId() ]);
        else
            return $this->redirect('Contractor', 'Contractor', 'index');
    }

    /**
     * @access core.read
     */
    public function editAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        return $this->render('form', [
            'contractor' => $contractor,
            'owner' => $this->repo('User', 'User')->findWithComplement($contractor->getOwner())
        ]);
    }

    /**
     * @access core.write
     */
    public function updateAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $existing = $this->repo()->findAll('name = :name AND id != :id', [ ':name' => $request->get('name'), ':id' => $contractor->getId() ]);

        if($existing)
        {
            $this->flash('warning', $this->t('contractorWithNameExists'));
            return $this->redirect('Contractor', 'Contractor', 'edit', [ 'id' => $contractor->getId() ]);
        }

        $log = $this->openUserHistory($contractor);

        $contractor->fillFromRequest($request);
        $contractor->setModified(time());

        $log->flush('change', $this->t('contractor'));

        $this->repo()->save($contractor);

        if($request->isAJAX())
        {
            return $this->responseAJAX([
                'status'  => 'success',
                'message' => $this->t('contractorSaved')
            ]);
        }
        else
        {
            $this->flash('success', $this->t('contractorSaved'));

            if($request->request->has('apply'))
                return $this->redirect('Contractor', 'Contractor', 'edit', [ 'id' => $contractor->getId() ]);
            else
                return $this->redirect('Contractor', 'Contractor', 'index');
        }
    }

    /**
     * @access core.delete
     */
    public function deleteAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        $repo = $this->repo('Contact');

        foreach($repo->findByContractor($contractor->getId()) as $contact)
        {
            $repo->delete($contact);
        }

        $this->repo()->delete($contractor);

        $this->openUserHistory($contractor)->flush('delete', $this->t('contractor'));

        $this->flash('success', $this->t('contractorDeletedSuccess'));

        return $this->redirect('Contractor', 'Contractor', 'index');
    }

    /**
     * @access core.read
     */
    public function summaryAction($request)
    {
        $contractor = $this->repo()->find($request->get('id'));

        if(! $contractor)
        {
            $this->flash('danger', $this->t('contractorDoesntExists'));
            return $this->redirect('Contractor', 'Contractor', 'index');
        }

        return $this->render('summary', [
            'contractor' => $contractor,
            'contacts'   => $this->repo('Contact')->findByContractor($contractor->getId()),
            'owner'      => $this->repo('User', 'User')->findWithComplement($contractor->getOwner()),
            'entity'     => null
        ]);
    }
}
