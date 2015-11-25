<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-briefcase"></i>
                <?=$app->t($contractor->getId() ? 'contractorEdit' : 'contractorNew')?>
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="#" data-form-submit="form" data-form-param="apply" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('apply') }}</span>
                </a>
                <a href="#" data-form-submit="form" data-form-param="save" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('save') }}</span>
                </a>
                <a href="#" class="btn btn-icon-block btn-link-danger app-history-back">
                    <i class="fa fa-remove"></i>
                    <span>{{ t('cancel') }}</span>
                </a>
            </div>
        </div>
        <div class="heading-elements-toggle">
            <i class="fa fa-ellipsis-h"></i>
        </div>
    </div>
    <div class="breadcrumb-line">
        <ul class="breadcrumb">
            <li><a href="{{ createUrl() }}"><i class="fa fa-home"> </i>Verone</a></li>
            <li><a href="{{ createUrl('Contractor', 'Contractor', 'index') }}">{{ t('contractors') }}</a></li>
            @if $contractor->getId()
                <li class="active"><a href="{{ createUrl('Contractor', 'Contact', 'edit', [ 'id' => $contractor->getId() ]) }}">{{ t('contractorEdit') }}</a></li>
            @else
                <li class="active"><a href="{{ createUrl('Contractor', 'Contact', 'add') }}">{{ t('contractorNew') }}</a></li>
            @endif
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form action="<?php echo $app->createUrl('Contractor', 'Contractor', $contractor->getId() ? 'update' : 'save'); ?>" method="post" id="form" class="form-validation">
                <input type="hidden" name="id" value="<?php echo $contractor->getId(); ?>" />
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('basicInformations') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="name" class="control-label">{{ t('contractorName') }}</label>
                                    <input class="form-control required" type="text" id="name" name="name" autofocus="" value="<?php echo $contractor->getName(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="type" class="control-label">{{ t('contractorType') }}</label>
                                    <select name="type" id="type" class="form-control">
                                        <option value="1"<?php echo $contractor->getType() == 1 ? ' selected="selected"' : ''; ?>>{{ t('contractorTypePerson') }}</option>
                                        <option value="2"<?php echo $contractor->getType() == 2 ? ' selected="selected"' : ''; ?>>{{ t('contractorTypeCompany') }}</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="trade" class="control-label">{{ t('trade') }}</label>
                                    <input class="form-control" type="text" id="trade" name="trade" value="<?php echo $contractor->getTrade(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="companyName" class="control-label">{{ t('companyName') }}</label>
                                    <input class="form-control" type="text" id="companyName" name="companyName" value="<?php echo $contractor->getCompanyName(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="positionInCompany" class="control-label">{{ t('positionInCompany') }}</label>
                                    <input class="form-control" type="text" id="positionInCompany" name="positionInCompany" value="<?php echo $contractor->getPositionInCompany(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="bankAccountNumber" class="control-label">{{ t('bankAccountNumber') }}</label>
                                    <input class="form-control" type="text" id="bankAccountNumber" name="bankAccountNumber" value="<?php echo $contractor->getBankAccountNumber(); ?>" />
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('additionallyInformations') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="description" class="control-label">{{ t('enterDescription') }}</label>
                                    <textarea class="form-control auto-grow" id="description" name="description"><?php echo $contractor->getDescription(); ?></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="websiteUrl" class="control-label">{{ t('website') }}</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">http://</div>
                                        <input class="form-control" data-toggle="tooltip" data-placement="top" title="Podaj adres URL bez HTTP na początku" type="text" id="websiteUrl" name="websiteUrl" value="<?php echo $contractor->getWebsiteUrl(); ?>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('contactDetails') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="phone" class="control-label">{{ t('phoneNumber') }}</label>
                                    <input class="form-control" type="text" id="phone" name="phone" value="<?php echo $contractor->getPhone(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="email" class="control-label">{{ t('emailAddress') }}</label>
                                    <input class="form-control" type="email" id="email" name="email" value="<?php echo $contractor->getEmail(); ?>" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('contractorBillingAddress') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="billAddressStreet" class="control-label">{{ t('streetFull') }}</label>
                                    <input class="form-control" id="billAddressStreet" name="billAddressStreet" value="<?php echo $contractor->getBillAddressStreet(); ?>" />
                                </div>
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="billAddressCity" class="control-label">{{ t('city') }}</label>
                                                <input class="form-control" id="billAddressCity" name="billAddressCity" value="<?php echo $contractor->getBillAddressCity(); ?>" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="billAddressPostalCode" class="control-label">{{ t('postalCode') }}</label>
                                                <input class="form-control" id="billAddressPostalCode" name="billAddressPostalCode" value="<?php echo $contractor->getBillAddressPostalCode(); ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="billAddressState" class="control-label">{{ t('state') }}</label>
                                                <input class="form-control" id="billAddressState" name="billAddressState" value="<?php echo $contractor->getBillAddressState(); ?>" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="billAddressCountry" class="control-label">{{ t('country') }}</label>
                                                <input class="form-control" id="billAddressCountry" name="billAddressCountry" value="<?php echo $contractor->getBillAddressCountry(); ?>" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('contractorShippingAddress') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="shippAddressStreet" class="control-label">{{ t('streetFull') }}</label>
                                    <input class="form-control" id="shippAddressStreet" name="shippAddressStreet" value="<?php echo $contractor->getShippAddressStreet(); ?>" />
                                </div>
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="shippAddressCity" class="control-label">{{ t('city') }}</label>
                                                <input class="form-control" id="shippAddressCity" name="shippAddressCity" value="<?php echo $contractor->getShippAddressCity(); ?>" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="shippAddressPostalCode" class="control-label">{{ t('postalCode') }}</label>
                                                <input class="form-control" id="shippAddressPostalCode" name="shippAddressPostalCode" value="<?php echo $contractor->getShippAddressPostalCode(); ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="shippAddressState" class="control-label">{{ t('state') }}</label>
                                                <input class="form-control" id="shippAddressState" name="shippAddressState" value="<?php echo $contractor->getShippAddressState(); ?>" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="shippAddressCountry" class="control-label">{{ t('country') }}</label>
                                                <input class="form-control" id="shippAddressCountry" name="shippAddressCountry" value="<?php echo $contractor->getShippAddressCountry(); ?>" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('contractorCompanyIdentificationData') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="nip" class="control-label">{{ t('contractorNIP') }}</label>
                                    <input class="form-control" id="nip" name="nip" value="<?php echo $contractor->getNip(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="regon" class="control-label">{{ t('contractorREGON') }}</label>
                                    <input class="form-control" id="regon" name="regon" value="<?php echo $contractor->getRegon(); ?>" />
                                </div>
                            </div>
                        </div>

                        <?php if($contractor->getId()): ?>
                            <div class="panel panel-default">
                                <div class="panel-heading">{{ t('summation') }}</div>
                                <div class="panel-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('recordOwner') }}</label>
                                                    <p class="form-control-static"><?php echo $owner->getName(); ?></p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('addDate') }}</label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="<?php echo $app->datetime($contractor->getCreated()); ?>"><?php echo $app->datetime()->timeAgo($contractor->getCreated()) ?></p>
                                                </div>
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('modificationDate') }}</label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="<?php echo $app->datetime($contractor->getModified()); ?>"><?php echo $app->datetime()->timeAgo($contractor->getModified()); ?></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

@section('body.bottom')
<script>
    $(function() {
        // NIP number
        APP.FormValidation.bind('form', '#nip', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    if(val.length != 10)
                    {
                        return false;
                    }
                }
            },
            errorText: 'Numer NIP musi mieć 10 cyfr.'
        });
        APP.FormValidation.bind('form', '#nip', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    return NIPIsValid(val);
                }
            },
            errorText: 'Nieprawidłowy numer NIP. Obliczona suma kontrolna numeru jest nieprawidłowa.'
        });

        // REGON number
        APP.FormValidation.bind('form', '#regon', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    if(val.length == 9 || val.length == 14)
                    {
                        return;
                    }

                    return false;
                }
            },
            errorText: 'Numer REGON musi mieć 9 lub 14 cyfr.'
        });
        APP.FormValidation.bind('form', '#regon', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    if(val.length == 9)
                    {
                        return REGON9IsValid(val);
                    }
                    else if(val.length == 14)
                    {
                        return REGON14IsValid(val);
                    }
                }
            },
            errorText: 'Nieprawidłowy numer REGON. Obliczona suma kontrolna numeru jest nieprawidłowa.'
        });

        // NRB number
        APP.FormValidation.bind('form', '#bankAccountNumber', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    if(val.length == 26)
                    {
                        return;
                    }

                    return false;
                }
            },
            errorText: 'Numer Konta Bankowego musi mieć 26 cyfr.'
        });
        APP.FormValidation.bind('form', '#bankAccountNumber', {
            validate: function(elm, val) {
                if(jQuery.trim(val) != '')
                {
                    return NRBvalidatior(val);
                }
            },
            errorText: 'Nieprawidłowy numer Konta Bankowego. Obliczona suma kontrolna numeru jest nieprawidłowa.'
        });
    });

    function NIPIsValid(nip)
    {
        var weights = [6, 5, 7, 2, 3, 4, 5, 6, 7];
        nip = nip.replace(/[\s-]/g, '');

        if(nip.length == 10 && parseInt(nip, 10) > 0)
        {
            var sum = 0;

            for(var i = 0; i < 9; i++)
            {
                sum += nip[i] * weights[i];
            }

            return (sum % 11) == nip[9];
        }

        return false;
    };

    function REGON9IsValid(regon)
    {
        var weights = [8, 9, 2, 3, 4, 5, 6, 7];
        regon = regon.replace(/[\s-]/g, '');

        if(regon.length == 9 && parseInt(regon, 9) > 0)
        {
            var sum = 0;

            for(var i = 0; i < 8; i++)
            {
                sum += regon[i] * weights[i];
            }

            var mod = (sum % 11);

            return (mod == 10 ? 0 : mod) == regon[8];
        }

        return false;
    };

    function REGON14IsValid(regon)
    {
        var weights = [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8];
        regon = regon.replace(/[\s-]/g, '');

        if(regon.length == 14 && parseInt(regon, 14) > 0)
        {
            var sum = 0;

            for(var i = 0; i < 13; i++)
            {
                sum += regon[i] * weights[i];
            }

            var mod = (sum % 11);

            return (mod == 10 ? 0 : mod) == regon[13];
        }

        return false;
    };

    // http://blog.mmx3.pl/2010/11/16/javascript-walidator-numeru-rachunku-bankowego-nrb/
    function NRBvalidatior(nrb) {
        nrb = nrb.replace(/[^0-9]+/g, '');
        var weights = [1, 10, 3, 30, 9, 90, 27, 76, 81, 34, 49, 5, 50, 15, 53, 45, 62, 38, 89, 17, 73, 51, 25, 56, 75, 71, 31, 19, 93, 57];

        if(nrb.length == 26)
        {
            nrb = nrb + '2521'; // 2521 = PL
            nrb = nrb.substr(2) + nrb.substr(0, 2);
            var Z = 0;

            for(var i = 0; i < 30; i++)
            {
                Z += nrb[29 - i] * weights[i];
            }

            if(Z % 97 == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
</script>
@endsection
