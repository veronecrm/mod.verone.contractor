<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\ORM;

use CRM\ORM\Entity;

class Contact extends Entity
{
    protected $id;
    protected $contractorId;
    protected $owner;
    protected $firstName;
    protected $lastName;
    protected $phone;
    protected $officePhone;
    protected $email;
    protected $companyName;
    protected $positionInCompany;
    protected $description;
    protected $created;
    protected $modified;

    /**
     * Gets the id.
     *
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Sets the $id.
     *
     * @param mixed $id the id
     *
     * @return self
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Gets the contractorId.
     *
     * @return mixed
     */
    public function getContractorId()
    {
        return $this->contractorId;
    }

    /**
     * Sets the $contractorId.
     *
     * @param mixed $contractorId the contractor id
     *
     * @return self
     */
    public function setContractorId($contractorId)
    {
        $this->contractorId = $contractorId;

        return $this;
    }

    /**
     * Gets the owner.
     *
     * @return mixed
     */
    public function getOwner()
    {
        return $this->owner;
    }

    /**
     * Sets the $owner.
     *
     * @param mixed $owner the owner
     *
     * @return self
     */
    public function setOwner($owner)
    {
        $this->owner = $owner;

        return $this;
    }

    /**
     * Gets the firstName.
     *
     * @return mixed
     */
    public function getFirstName()
    {
        return $this->firstName;
    }

    /**
     * Sets the $firstName.
     *
     * @param mixed $firstName the first Name
     *
     * @return self
     */
    public function setFirstName($firstName)
    {
        $this->firstName = $firstName;

        return $this;
    }

    /**
     * Gets the lastName.
     *
     * @return mixed
     */
    public function getLastName()
    {
        return $this->lastName;
    }

    /**
     * Sets the $lastName.
     *
     * @param mixed $lastName the last Name
     *
     * @return self
     */
    public function setLastName($lastName)
    {
        $this->lastName = $lastName;

        return $this;
    }

    /**
     * Gets full Contact name
     * 
     * @return string
     */
    public function getName()
    {
        return $this->firstName.' '.$this->lastName;
    }

    /**
     * Gets the phone.
     *
     * @return mixed
     */
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * Sets the $phone.
     *
     * @param mixed $phone the phone
     *
     * @return self
     */
    public function setPhone($phone)
    {
        $this->phone = $phone;

        return $this;
    }

    /**
     * Gets the officePhone.
     *
     * @return mixed
     */
    public function getOfficePhone()
    {
        return $this->officePhone;
    }

    /**
     * Sets the $officePhone.
     *
     * @param mixed $officePhone the office phone
     *
     * @return self
     */
    public function setOfficePhone($officePhone)
    {
        $this->officePhone = $officePhone;

        return $this;
    }

    /**
     * Gets the email.
     *
     * @return mixed
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Sets the $email.
     *
     * @param mixed $email the email
     *
     * @return self
     */
    public function setEmail($email)
    {
        $this->email = $email;

        return $this;
    }

    /**
     * Gets the value of companyName.
     *
     * @return mixed
     */
    public function getCompanyName()
    {
        return $this->companyName;
    }

    /**
     * Sets the value of companyName.
     *
     * @param mixed $companyName the company name
     *
     * @return self
     */
    public function setCompanyName($companyName)
    {
        $this->companyName = $companyName;

        return $this;
    }

    /**
     * Gets the positionInCompany.
     *
     * @return mixed
     */
    public function getPositionInCompany()
    {
        return $this->positionInCompany;
    }

    /**
     * Sets the $positionInCompany.
     *
     * @param mixed $positionInCompany the positionInCompany
     *
     * @return self
     */
    public function setPositionInCompany($positionInCompany)
    {
        $this->positionInCompany = $positionInCompany;

        return $this;
    }

    /**
     * Gets the description.
     *
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Sets the $description.
     *
     * @param mixed $description the description
     *
     * @return self
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Gets the created.
     *
     * @return mixed
     */
    public function getCreated()
    {
        return $this->created;
    }

    /**
     * Sets the $created.
     *
     * @param mixed $created the created
     *
     * @return self
     */
    public function setCreated($created)
    {
        $this->created = $created;

        return $this;
    }

    /**
     * Gets the modified.
     *
     * @return mixed
     */
    public function getModified()
    {
        return $this->modified;
    }

    /**
     * Sets the $modified.
     *
     * @param mixed $modified the modified
     *
     * @return self
     */
    public function setModified($modified)
    {
        $this->modified = $modified;

        return $this;
    }
}
