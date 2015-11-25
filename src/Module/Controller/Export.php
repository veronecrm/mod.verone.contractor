<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Contractor\Controller;

use System\Http\Response;
use CRM\App\Controller\BaseController;
use CRM\Pagination\Paginator;
use PHPExcel;
use PHPExcel_Writer_Excel2007;
use PHPExcel_Style_Fill;

//use App\Module\Contractor\ORM\Contractor;

/**
 * @section mod.Contractor.Export
 */
class Export extends BaseController
{
    /**
     * @access core.module
     */
    public function contractorAction($request)
    {
        /*$generator = new FakeDataGenerator;

        for($i = 0; $i < 2000; $i++)
        {
            $fn = $generator->generateFirstName();
            $ln = $generator->generateLastName();

            $a = new Contractor;
            $a->setOwner($this->user()->getId());
            $a->setName("$fn $ln");
            $a->setType(1);
            $a->setEmail($generator->generateEmail($fn, $ln));
            $a->setNip($generator->generateNIP());
            $a->setRegon($generator->generateREGON());
            $a->setBankAccountNumber($generator->generateNumber(26));
            $a->setCreated(time());
            $a->setBillAddressStreet('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setBillAddressCity('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setBillAddressState('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setBillAddressPostalCode('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setBillAddressCountry('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setShippAddressStreet('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setShippAddressCity('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setShippAddressState('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setShippAddressPostalCode('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setShippAddressCountry('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setDescription('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
            $a->setWebsiteUrl('http://www.veronecrm.com');

            $this->repo('Contractor', 'Contractor')->save($a);
        }

        exit;*/

        return $this->render('', [
            'columns' => $this->repo('Contractor', 'Contractor')->getExportFieldsNames()
        ]);
    }

    /**
     * @access core.module
     */
    public function contractorGenerateAction($request)
    {
        $repo        = $this->repo('Contractor', 'Contractor');
        $contractors = $repo->findAll();
        $allProperties = $repo->getExportFieldsNames();
        $properties  = [];
        $propNames   = [];
        $letters     = explode(' ', 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ');

        $selectedProps = (array) $request->get('properties');

        foreach($selectedProps as $prop)
        {
            foreach($allProperties as $key => $name)
            {
                if($prop == $key)
                {
                    $properties[] = $key;
                    $propNames[]  = $name;
                }
            }
        }

        $excel = new PHPExcel;
        $sheet = $excel->getActiveSheet();

        // Predefined values
        $row    = '1';
        $column = 'A';


        /**
         * Create header row.
         */
        foreach($propNames as $pi => $property)
        {
            $column = $letters[$pi];
            $sheet->setCellValue($column.$row, $property);
            $sheet->getColumnDimension($column)->setAutoSize(true);

            $sheet->getStyle($column.$row)->applyFromArray([
                'fill' => [
                    'type'  => PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => ['rgb' => 'f1f2f3']
                ]
            ]);
        }

        $sheet->getRowDimension($row)->setVisible(false);

        $row    = '1';
        $column = 'A';

        /**
         * Create list of Contractors data.
         */
        foreach($contractors as $ci => $contractor)
        {
            $row++;

            foreach($properties as $pi => $property)
            {
                $column = $letters[$pi];
                $sheet->setCellValue($column.$row, $repo->getEndValue($contractor, $property));
                $sheet->getColumnDimension($column)->setAutoSize(true);
            }
        }


        /**
         * Add metadata to document.
         */
        $excel->getProperties()
            ->setCreator("Verone CRM - http://www.veronecrm.com")
            ->setTitle($this->t('contractorContractorExportDocumentMetadataTitle'))
            ->setSubject($this->t('contractorContractorExportDocumentMetadataTitle'))
            ->setDescription($this->t('contractorContractorExportDocumentMetadataTitle'))
            ->setKeywords("verone crm, export, contractors");

        $directory = BASEPATH.'/app/Cache/exports/excell/';
        $filename  = $this->t('contractorContractorExportDocumentFilename').' - '.date('d-m-Y H-i-s').'.xlsx';

        if(is_dir($directory) == false)
        {
            mkdir($directory, 0777, true);
        }

        $writer = new PHPExcel_Writer_Excel2007($excel);
        $writer->save($directory.$filename);

        return $this->responseAJAX([
            'status' => 'success',
            'data'   => $filename
        ]);
    }

    public function downloadFileAction($request)
    {
        $filename = BASEPATH.'/app/Cache/exports/excell/'.$request->get('filename');

        if(is_file($filename) == false)
        {
            $this->flash('danger', 'Nie ma takiego pliku.');
            return $this->redirect('Contractor', 'Export', 'contractor');
        }

        $name = $this->t('contractorContractorExportDocumentFilename').' - '.date('d-m-Y H.i').'.xlsx';

        $content = file_get_contents($filename);

        $response = new Response($content, 200);
        $response->headers
            ->setDisposition('attachment', $name)
            ->set('Content-Description', 'File Transfer')
            ->set('Content-Type', 'application/octet-stream')
            ->set('Content-Transfer-Encoding', 'binary')
            ->set('Connection', 'Keep-Alive')
            ->set('Expires', '0')
            ->set('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
            ->set('Pragma', 'public')
            ->set('Content-Length', filesize($filename));

        return $response;
    }
}

/*class FakeDataGenerator
{
    public $lastNames    = ['Nowak','Kowalski','Wiśniewski','Dąbrowski','Lewandowski','Wójcik','Kamiński','Kowalczyk','Zieliński','Szymański','Woźniak','Kozłowski','Jankowski','Wojciechowski','Kwiatkowski','Kaczmarek','Mazur','Krawczyk','Piotrowski','Grabowski','Nowakowski','Pawłowski','Michalski','Nowicki','Adamczyk','Dudek','Zając','Wieczorek','Jabłoński','Król','Majewski','Olszewski','Jaworski','Wróbel','Malinowski','Pawlak','Witkowski','Walczak','Stępień','Górski','Rutkowski','Michalak','Sikora','Ostrowski','Baran','Duda','Szewczyk','Tomaszewski','Pietrzak','Marciniak','Wróblewski','Zalewski','Jakubowski','Jasiński','Zawadzki','Sadowski','Bąk','Chmielewski','Włodarczyk','Borkowski','Czarnecki','Sawicki','Sokołowski','Urbański','Kubiak','Maciejewski','Szczepański','Kucharski','Wilk','Kalinowski','Lis','Mazurek','Wysocki','Adamski','Kaźmierczak','Wasilewski','Sobczak','Czerwiński','Andrzejewski','Cieślak','Głowacki','Zakrzewski','Kołodziej','Sikorski','Krajewski','Gajewski','Szymczak','Szulc','Baranowski','Laskowski','Brzeziński','Makowski','Ziółkowski','Przybylski','Domański','Nowacki','Borowski','Błaszczyk','Chojnacki','Ciesielski','Mróz','Szczepaniak','Wesołowski','Górecki','Krupa','Kaczmarczyk','Leszczyński','Lipiński','Kowalewski','Urbaniak','Kozak','Kania','Mikołajczyk','Czajkowski','Mucha','Tomczak','Kozioł','Markowski','Kowalik','Nawrocki','Brzozowski','Janik','Musiał','Wawrzyniak','Markiewicz','Orłowski','Tomczyk','Jarosz','Kołodziejczyk','Kurek','Kopeć','Żak','Wolski','Łuczak','Dziedzic','Kot','Stasiak','Stankiewicz','Piątek','Jóźwiak','Urban','Dobrowolski','Pawlik','Kruk','Domagała','Piasecki','Wierzbicki','Karpiński','Jastrzębski','Polak','Zięba','Janicki','Wójtowicz','Stefański','Sosnowski','Bednarek','Majchrzak','Bielecki','Małecki','Maj','Sowa','Milewski','Gajda','Klimek','Olejniczak','Ratajczak','Romanowski','Matuszewski','Śliwiński','Madej','Kasprzak','Wilczyński','Grzelak','Socha','Czajka','Marek','Kowal','Bednarczyk','Skiba','Wrona','Owczarek','Marcinkowski','Matusiak','Orzechowski','Sobolewski','Kędzierski','Kurowski','Rogowski','Olejnik','Dębski','Barański','Skowroński','Mazurkiewicz','Pająk','Czech','Janiszewski','Bednarski','Łukasik','Chrzanowski','Bukowski','Leśniak','Cieślik','Kosiński','Jędrzejewski','Muszyński','Świątek','Kozieł','Osiński','Czaja','Lisowski','Kuczyński','Żukowski','Grzybowski','Kwiecień','Pluta','Morawski','Czyż','Sobczyk','Augustyniak','Rybak','Krzemiński','Marzec','Konieczny','Marczak','Zych','Michalik','Michałowski','Kaczor','Świderski','Kubicki','Gołębiowski','Paluch','Białek','Niemiec','Sroka','Stefaniak','Cybulski','Kacprzak','Marszałek','Kasprzyk','Małek','Szydłowski','Smoliński','Kujawa','Lewicki','Przybysz','Stachowiak','Popławski','Piekarski','Matysiak'];
    public $firstNames   = ['Jan','Antoni','Jakub','Filip','Franciszek','Adam','Szymon','Michał','Aleksander','Bartek','Mateusz','Kacper','Mikołaj','Stanisław','Wojciech','Piotr','Wiktor','Ignacy','Leon','Maksymilian','Tymon','Julian','Maciej','Karol','Dawid','Krzysztof','Miłosz','Igor','Marcel','Oskar','Kajetan','Oliwier','Sebastian','Tymoteusz','Dominik','Ksawery','Tomasz','Alan','Nikodem','Stefan','Adrian','Patryk','Bruno','Hubert','Kamil','Natan','Jerzy','Krystian','Paweł','Gabriel','Gustaw','Tadeusz','Iwo','Jacek','Marcin','Olaf','Eryk','Konstanty','Witold','Artur','Borys','Grzegorz','Jeremi','Łukasz','Marek','Robert','Aleks','Arkadiusz','Daniel','Fabian','Józef','Juliusz','Maurycy','Ryszard','Andrzej','Błażej','Cezary','Damian','Fryderyk','Jędrzej','Kazimierz','Kornel','Przemysław','Radosław','Cyprian','Leonard','Milan','Nataniel','Rafał','Teodor','Tobiasz','Tytus','Władysław','Zbigniew','Albert','Alex','Dorian','Henryk','Jan','Konrad','Zofia','Julia','Alicja','Zuzanna','Maja','Aleksandra','Maria','Natalia','Amelia','Hanna','Helena','Oliwia','Wiktoria','Lena','Liliana','Antonina','Pola','Barbara','Gabriela','Weronika','Emilia','Iga','Laura','Michalina','Nina','Łucja','Marcelina','Joanna','Anna','Blanka','Kaja','Karolina','Nikola','Jagoda','Aniela','Kornelia','Małgorzata','Nela','Ewa','Katarzyna','Milena','Marta','Urszula','Izabela','Kinga','Magdalena','Martyna','Matylda','Sara','Agata','Kalina','Nadia','Patrycja','Dominika','Marianna','Ada','Anastazja','Klara','Krystyna','Olga','Paulina','Róża','Dorota','Karina','Liwia','Marika','Mila','Rozalia','Sonia','Adrianna','Agnieszka','Alina','Aurelia','Diana','Eliza','Felicja','Jadwiga','Janina','Judyta','Lea','Natasza','Sylwia','Emma','Ida','Inga','Lilia','Malwina','Stefania','Stella','Angelika','Anna','Bianka','Celina','Daria','Elena','Estera','Jagna','Julita','Justyna','Klaudia'];
    public $emailDomains = ['example.com','gmail.com','yahoo.co.uk'];
    public $companyNameLetters1 = ['a','e','i','o','u','y'];
    public $companyNameLetters2 = ['q','w','r','t','p','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'];

    public function generateFirstName()
    {
        $total = count($this->firstNames) - 1;

        return $this->firstNames[rand(0, $total)];
    }

    public function generateLastName()
    {
        $total = count($this->lastNames) - 1;

        return $this->lastNames[rand(0, $total)];
    }

    public function generateEmail($firstName, $lastName)
    {
        $total  = count($this->emailDomains) - 1;
        $domain = $this->emailDomains[rand(0, $total)];

        $firstName = mb_strtolower($firstName);
        $lastName  = mb_strtolower($lastName);

        $numbers = rand(0, 2000);

        switch(rand(0, 1))
        {
            case 0: $pattern = "$numbers%s";
            case 1: $pattern = "%s$numbers";
        }

        switch(rand(0, 4))
        {
            // Last name with numbers
            case 1:
                $login = sprintf($pattern, $lastName);
            break;

            // First name with numbers
            case 2:
                $login = sprintf($pattern, $firstName);
            break;

            // Shuffled First name with numbers
            case 3:
                $login = sprintf($pattern, str_shuffle($firstName));
            break;

            // Shuffled Last name with numbers
            case 4:
                $login = sprintf($pattern, str_shuffle($lastName));
            break;

            // lastname.firstname
            default:
                $login = "$lastName.$firstName";
            break;
        }

        return $login.'@'.$domain;
    }

    public function generateNIP()
    {
        $weights = [6,5,7,2,3,4,5,6,7];
        $numbers = [];
        $total   = 0;

        for($i = 0; $i < 9; $i++)
        {
            $number = rand(0, 9);
            $total += $number * $weights[$i];

            $numbers[] = $number;
        }

        $numbers[] = $total % 11;

        return implode($numbers);
    }

    public function generateREGON()
    {
        $weights = [8,9,2,3,4,5,6,7];
        $numbers = [];
        $total   = 0;

        for($i = 0; $i < 8; $i++)
        {
            $number = rand(0, 9);
            $total += $number * $weights[$i];

            $numbers[] = $number;
        }

        $numbers[] = $total % 11;

        return implode($numbers);
    }

    public function generateNumber($length = 10)
    {
        $result = [];

        for($i = 0; $i < $length; $i++)
        {
            $result[] = rand(0, 9);
        }

        return implode($result);
    }
}*/
