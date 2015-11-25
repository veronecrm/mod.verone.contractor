<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\ORM;

use CRM\ORM\Entity;

class Contractor extends Entity
{
    protected $id;
    protected $owner;
    protected $name;
    protected $type;
    protected $positionInCompany;
    protected $companyName;
    protected $websiteUrl;
    protected $phone;
    protected $email;
    protected $trade;
    protected $nip;
    protected $regon;
    protected $bankAccountNumber;
    protected $billAddressStreet;
    protected $billAddressCity;
    protected $billAddressState;
    protected $billAddressPostalCode;
    protected $billAddressCountry;
    protected $shippAddressStreet;
    protected $shippAddressCity;
    protected $shippAddressState;
    protected $shippAddressPostalCode;
    protected $shippAddressCountry;
    protected $description;
    protected $created;
    protected $modified;

    /**
     * Gets the value of id.
     *
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Sets the value of id.
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
     * Gets the value of owner.
     *
     * @return mixed
     */
    public function getOwner()
    {
        return $this->owner;
    }

    /**
     * Sets the value of owner.
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
     * Gets the value of name.
     *
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Sets the value of name.
     *
     * @param mixed $name the name
     *
     * @return self
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Gets the type.
     *
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * Sets the $type.
     *
     * @param mixed $type the type
     *
     * @return self
     */
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * Gets the value of positionInCompany.
     *
     * @return mixed
     */
    public function getPositionInCompany()
    {
        return $this->positionInCompany;
    }

    /**
     * Sets the value of positionInCompany.
     *
     * @param mixed $positionInCompany the position in company
     *
     * @return self
     */
    public function setPositionInCompany($positionInCompany)
    {
        $this->positionInCompany = $positionInCompany;

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
     * Gets the value of websiteUrl.
     *
     * @return mixed
     */
    public function getWebsiteUrl()
    {
        return $this->websiteUrl;
    }

    /**
     * Sets the value of websiteUrl.
     *
     * @param mixed $websiteUrl the website url
     *
     * @return self
     */
    public function setWebsiteUrl($websiteUrl)
    {
        $this->websiteUrl = $websiteUrl;

        return $this;
    }

    /**
     * Gets the value of phone.
     *
     * @return mixed
     */
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * Sets the value of phone.
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
     * Gets the value of email.
     *
     * @return mixed
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Sets the value of email.
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
     * Gets the value of trade.
     *
     * @return mixed
     */
    public function getTrade()
    {
        return $this->trade;
    }

    /**
     * Sets the value of trade.
     *
     * @param mixed $trade the trade
     *
     * @return self
     */
    public function setTrade($trade)
    {
        $this->trade = $trade;

        return $this;
    }

    /**
     * Gets the value of nip.
     *
     * @return mixed
     */
    public function getNip()
    {
        return $this->nip;
    }

    /**
     * Sets the value of nip.
     *
     * @param mixed $nip the nip
     *
     * @return self
     */
    public function setNip($nip)
    {
        $this->nip = $nip;

        return $this;
    }

    /**
     * Gets the value of regon.
     *
     * @return mixed
     */
    public function getRegon()
    {
        return $this->regon;
    }

    /**
     * Sets the value of regon.
     *
     * @param mixed $regon the regon
     *
     * @return self
     */
    public function setRegon($regon)
    {
        $this->regon = $regon;

        return $this;
    }

    /**
     * Gets the value of bankAccountNumber.
     *
     * @return mixed
     */
    public function getBankAccountNumber()
    {
        return $this->bankAccountNumber;
    }

    /**
     * Sets the value of bankAccountNumber.
     *
     * @param mixed $bankAccountNumber the bank account number
     *
     * @return self
     */
    public function setBankAccountNumber($bankAccountNumber)
    {
        $this->bankAccountNumber = $bankAccountNumber;

        return $this;
    }

    /**
     * Gets the billAddressStreet.
     *
     * @return mixed
     */
    public function getBillAddressStreet()
    {
        return $this->billAddressStreet;
    }

    /**
     * Sets the $billAddressStreet.
     *
     * @param mixed $billAddressStreet the bill address street
     *
     * @return self
     */
    public function setBillAddressStreet($billAddressStreet)
    {
        $this->billAddressStreet = $billAddressStreet;

        return $this;
    }

    /**
     * Gets the billAddressCity.
     *
     * @return mixed
     */
    public function getBillAddressCity()
    {
        return $this->billAddressCity;
    }

    /**
     * Sets the $billAddressCity.
     *
     * @param mixed $billAddressCity the bill address city
     *
     * @return self
     */
    public function setBillAddressCity($billAddressCity)
    {
        $this->billAddressCity = $billAddressCity;

        return $this;
    }

    /**
     * Gets the billAddressState.
     *
     * @return mixed
     */
    public function getBillAddressState()
    {
        return $this->billAddressState;
    }

    /**
     * Sets the $billAddressState.
     *
     * @param mixed $billAddressState the bill address state
     *
     * @return self
     */
    public function setBillAddressState($billAddressState)
    {
        $this->billAddressState = $billAddressState;

        return $this;
    }

    /**
     * Gets the billAddressPostalCode.
     *
     * @return mixed
     */
    public function getBillAddressPostalCode()
    {
        return $this->billAddressPostalCode;
    }

    /**
     * Sets the $billAddressPostalCode.
     *
     * @param mixed $billAddressPostalCode the bill address postal code
     *
     * @return self
     */
    public function setBillAddressPostalCode($billAddressPostalCode)
    {
        $this->billAddressPostalCode = $billAddressPostalCode;

        return $this;
    }

    /**
     * Gets the billAddressCountry.
     *
     * @return mixed
     */
    public function getBillAddressCountry()
    {
        return $this->billAddressCountry;
    }

    /**
     * Sets the $billAddressCountry.
     *
     * @param mixed $billAddressCountry the bill address country
     *
     * @return self
     */
    public function setBillAddressCountry($billAddressCountry)
    {
        $this->billAddressCountry = $billAddressCountry;

        return $this;
    }

    /**
     * Gets the shippAddressStreet.
     *
     * @return mixed
     */
    public function getShippAddressStreet()
    {
        return $this->shippAddressStreet;
    }

    /**
     * Sets the $shippAddressStreet.
     *
     * @param mixed $shippAddressStreet the shipp address street
     *
     * @return self
     */
    public function setShippAddressStreet($shippAddressStreet)
    {
        $this->shippAddressStreet = $shippAddressStreet;

        return $this;
    }

    /**
     * Gets the shippAddressCity.
     *
     * @return mixed
     */
    public function getShippAddressCity()
    {
        return $this->shippAddressCity;
    }

    /**
     * Sets the $shippAddressCity.
     *
     * @param mixed $shippAddressCity the shipp address city
     *
     * @return self
     */
    public function setShippAddressCity($shippAddressCity)
    {
        $this->shippAddressCity = $shippAddressCity;

        return $this;
    }

    /**
     * Gets the shippAddressState.
     *
     * @return mixed
     */
    public function getShippAddressState()
    {
        return $this->shippAddressState;
    }

    /**
     * Sets the $shippAddressState.
     *
     * @param mixed $shippAddressState the shipp address state
     *
     * @return self
     */
    public function setShippAddressState($shippAddressState)
    {
        $this->shippAddressState = $shippAddressState;

        return $this;
    }

    /**
     * Gets the shippAddressPostalCode.
     *
     * @return mixed
     */
    public function getShippAddressPostalCode()
    {
        return $this->shippAddressPostalCode;
    }

    /**
     * Sets the $shippAddressPostalCode.
     *
     * @param mixed $shippAddressPostalCode the shipp address postal code
     *
     * @return self
     */
    public function setShippAddressPostalCode($shippAddressPostalCode)
    {
        $this->shippAddressPostalCode = $shippAddressPostalCode;

        return $this;
    }

    /**
     * Gets the shippAddressCountry.
     *
     * @return mixed
     */
    public function getShippAddressCountry()
    {
        return $this->shippAddressCountry;
    }

    /**
     * Sets the $shippAddressCountry.
     *
     * @param mixed $shippAddressCountry the shipp address country
     *
     * @return self
     */
    public function setShippAddressCountry($shippAddressCountry)
    {
        $this->shippAddressCountry = $shippAddressCountry;

        return $this;
    }

    /**
     * Gets the value of description.
     *
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Sets the value of description.
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
     * Gets the value of created.
     *
     * @return mixed
     */
    public function getCreated()
    {
        return $this->created;
    }

    /**
     * Sets the value of created.
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
     * Gets the value of modified.
     *
     * @return mixed
     */
    public function getModified()
    {
        return $this->modified;
    }

    /**
     * Sets the value of modified.
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
