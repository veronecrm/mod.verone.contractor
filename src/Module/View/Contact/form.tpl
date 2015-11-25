<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-phone-square"></i>
                <?=$app->t($contact->getId() ? 'contractorContactEdit' : 'contractorContactNew')?>
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
            <li><a href="{{ createUrl('Contractor', 'Contractor', 'summary', [ 'id' => $contractor->getId() ]) }}">{{ t('contractor') }} - {{ $contractor->getName() }}</a></li>
            @if $contact->getId()
                <li class="active"><a href="{{ createUrl('Contractor', 'Contact', 'edit', [ 'id' => $contact->getId() ]) }}">{{ t('contractorContactEdit') }}</a></li>
            @else
                <li class="active"><a href="{{ createUrl('Contractor', 'Contact', 'add', [ 'id' => $contractor->getId() ]) }}">{{ t('contractorContactNew') }}</a></li>
            @endif
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form action="<?php echo $app->createUrl('Contractor', 'Contact', $contact->getId() ? 'update' : 'save'); ?>" method="post" id="form" class="form-validation">
                <input type="hidden" name="id" value="<?php echo $contact->getId(); ?>" />
                <input type="hidden" name="contractorId" value="<?php echo $contact->getContractorId() ? $contact->getContractorId() : $app->request()->get('id'); ?>" />
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading"><?php echo $app->t('basicInformations'); ?></div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="firstName" class="control-label"><?php echo $app->t('firstName'); ?></label>
                                    <input class="form-control required" type="text" id="firstName" name="firstName" autofocus="" value="<?php echo $contact->getFirstName(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="lastName" class="control-label"><?php echo $app->t('lastName'); ?></label>
                                    <input class="form-control required" type="text" id="lastName" name="lastName" value="<?php echo $contact->getLastName(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="positionInCompany" class="control-label"><?php echo $app->t('positionInCompany'); ?></label>
                                    <input class="form-control" type="text" id="positionInCompany" name="positionInCompany" value="<?php echo $contact->getPositionInCompany(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="companyName" class="control-label"><?php echo $app->t('companyName'); ?></label>
                                    <input class="form-control" type="text" id="companyName" name="companyName" value="<?php echo $contact->getCompanyName(); ?>" />
                                </div>
                                <div class="bg-info panel-help"><h6>{{ t('prompt') }}</h6><p><?=str_replace('%companyName%', $contractor->getCompanyName() ? '<b>('.$contractor->getCompanyName().')</b>' : '', $app->t('contractorContactCompanyNameInfo'))?></p></div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading"><?php echo $app->t('contactDetails'); ?></div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="phone" class="control-label"><?php echo $app->t('phoneNumber'); ?></label>
                                    <input class="form-control" type="text" id="phone" name="phone" value="<?php echo $contact->getPhone(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="officePhone" class="control-label"><?php echo $app->t('officePhoneNumber'); ?></label>
                                    <input class="form-control" type="text" id="officePhone" name="officePhone" value="<?php echo $contact->getOfficePhone(); ?>" />
                                </div>
                                <div class="form-group">
                                    <label for="email" class="control-label"><?php echo $app->t('emailAddress'); ?></label>
                                    <input class="form-control" type="email" id="email" name="email" value="<?php echo $contact->getEmail(); ?>" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading"><?php echo $app->t('additionallyInformations'); ?></div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="control-label"><?php echo $app->t('contractor'); ?></label>
                                    <input type="text" readonly="readonly" value="<?php echo $contractor->getName(); ?>" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label for="description" class="control-label"><?php echo $app->t('enterDescription'); ?></label>
                                    <textarea class="form-control auto-grow" id="description" name="description"><?php echo $contact->getDescription(); ?></textarea>
                                </div>
                            </div>
                        </div>
                        <?php if($contact->getId()): ?>
                            <div class="panel panel-default">
                                <div class="panel-heading"><?php echo $app->t('summation'); ?></div>
                                <div class="panel-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label"><?php echo $app->t('recordOwner'); ?></label>
                                                    <p class="form-control-static"><?php echo $owner->getName(); ?></p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label"><?php echo $app->t('addDate'); ?></label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="<?php echo $app->datetime($contact->getCreated()); ?>"><?php echo $app->datetime()->timeAgo($contact->getCreated()) ?></p>
                                                </div>
                                                <div class="form-group">
                                                    <label for="trade" class="control-label"><?php echo $app->t('modificationDate'); ?></label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="<?php echo $app->datetime($contact->getModified()); ?>"><?php echo $app->datetime()->timeAgo($contact->getModified()); ?></p>
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
