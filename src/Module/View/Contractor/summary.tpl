<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-briefcase"></i>
                {{ t('contractorSummary') }}
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
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
            <li class="active"><a href="{{ createUrl('Contractor', 'Contractor', 'summary', [ 'id' => $contractor->getId() ]) }}">{{ t('contractor') }} - {{ $contractor->getName() }}</a></li>
        </ul>
        <ul class="breadcrumb-elements">
            <li><a href="<?=$app->createUrl('Contractor', 'Contact', 'add', [ 'id' => $contractor->getId() ]); ?>"><i class="fa fa-plus"></i> {{ t('contractorContactNew') }}</a></li>
        </ul>
        <div class="breadcrumb-elements-toggle">
            <i class="fa fa-unsorted"></i>
        </div>
    </div>
</div>


<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="summary-panel">
                                <h3>{{ $contractor->getName() }}
                                    @if $contractor->getPositionInCompany()
                                        <small>(
                                            @if $contractor->getCompanyName()
                                                <?=str_replace(['%positionInCompany%', '%companyName%'], ['<b>'.$contractor->getPositionInCompany().'</b>', '<b>'.$contractor->getCompanyName().'</b>'], $app->t('contractorPositionInCompany'))?>
                                            @else
                                                {{ $contractor->getPositionInCompany() }}
                                            @endif
                                        )</small>
                                    @endif
                                </h3>
                                <span class="actions">
                                    <a href="{{ createUrl('Contractor', 'Contractor', 'edit', [ 'id' => $contractor->getId() ]) }}" class="btn btn-sm btn-default"><i class="fa fa-pencil"></i> {{ t('edit') }}</a>
                                </span>
                                <div class="summary-details">
                                    @if $contractor->getPhone()
                                        <div class="item">
                                            <label>{{ t('phoneNumber') }}</label>
                                            <div>{{ $contractor->getPhone() }} <a class="action-icon" href="tel:{{ $contractor->getPhone() }}"><i class="fa fa-phone"></i></a></div>
                                        </div>
                                    @endif
                                    @if $contractor->getEmail()
                                        <div class="item">
                                            <label>{{ t('emailAddress') }}</label>
                                            <div>{{ $contractor->getEmail() }} <a class="action-icon" href="mailto:{{ $contractor->getEmail() }}"><i class="fa fa-envelope"></i></a></div>
                                        </div>
                                    @endif
                                    @if $contractor->getTrade()
                                        <div class="item">
                                            <label>{{ t('trade') }}</label>
                                            <div>{{ $contractor->getTrade() }}</div>
                                        </div>
                                    @endif
                                    @if $contractor->getCompanyName()
                                        <div class="item">
                                            <label>{{ t('companyName') }}</label>
                                            <div>{{ $contractor->getCompanyName() }}</div>
                                        </div>
                                    @endif
                                </div>
                                @if $contractor->getDescription()
                                    <hr />
                                    <p>{{ $contractor->getDescription() }}</p>
                                @endif
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            {{ t('historyOfChanges') }} (<span class="summary-history-total">0</span>)
                        </div>
                        <div class="panel-body">
                            <div class="summary-panel history-summary"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            {{ t('contractorContacts') }}
                        </div>
                        <div class="panel-body">
                            <?php if(count($contacts)): ?>
                                <table class="table table-default table-clicked-rows table-responsive">
                                    <thead>
                                        <tr>
                                            <th class="text-center span-1"><input type="checkbox" name="select-all" data-select-all="input_contractor" /></th>
                                            <th>{{ t('nameAndSurname') }}</th>
                                            <th>{{ t('phoneNumber') }}</th>
                                            <th class="text-right">{{ t('action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach $contacts
                                            <tr data-row-click-target="<?=$app->createUrl('Contractor', 'Contact', 'summary', [ 'id' => $item->getId() ]); ?>">
                                                <td class="text-center hidden-xs"><input type="checkbox" name="input_contractor" value="<?=$item->getId(); ?>" /></td>
                                                <td data-th="{{ t('nameAndSurname') }}" class="th">{{ $item->getName() }}</td>
                                                <td data-th="{{ t('phoneNumber') }}">{{ $item->getPhone() }}</td>
                                                <td data-th="{{ t('action') }}" class="app-click-prevent">
                                                    <div class="actions-box">
                                                        <div class="btn-group right">
                                                            <a href="<?=$app->createUrl('Contractor', 'Contact', 'edit', [ 'id' => $item->getId() ]); ?>" class="btn btn-default btn-xs btn-main-action" title="{{ t('edit') }}"><i class="fa fa-pencil"></i></a>
                                                            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                                                <span class="caret"></span>
                                                            </button>
                                                            <ul class="dropdown-menu with-headline right">
                                                                <li class="headline">{{ t('moreOptions') }}</li>
                                                                <li><a href="<?php echo $app->createUrl('Contractor', 'Contact', 'edit', [ 'id' => $item->getId() ]); ?>" title="{{ t('edit') }}"><i class="fa fa-pencil"></i> {{ t('edit') }}</a></li>
                                                                <li><a href="<?php echo $app->createUrl('Contractor', 'Contact', 'summary', [ 'id' => $item->getId() ]); ?>" title="{{ t('summary') }}"><i class="fa fa-bars"></i> {{ t('summary') }}</a></li>
                                                                <li role="separator" class="divider"></li>
                                                                <li class="item-danger"><a href="#" data-toggle="modal" data-target="#contact-delete" data-href="<?=$app->createUrl('Contractor', 'Contact', 'delete', [ 'id' => $item->getId() ]); ?>" title="{{ t('delete') }}"><i class="fa fa-remove"></i> {{ t('delete') }}</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            <?php else: ?>
                                <div style="padding:50px;font-size:15px;text-transform:uppercase;color:#ddd;text-align:center">{{ t('contractorNoContacts') }}</div>
                            <?php endif; ?>
                            <div class="text-right">
                                <a href="<?=$app->createUrl('Contractor', 'Contact', 'add', [ 'id' => $contractor->getId() ]); ?>" class="btn btn-xs btn-default"><i class="fa fa-plus"></i> {{ t('contractorContactNew') }}</a>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            {{ t('comments') }}
                        </div>
                        <div class="panel-body">
                            <div class="comments-panel"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="contact-delete" tabindex="-1" role="dialog" aria-labelledby="contact-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-danger">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="contact-delete-modal-label">{{ t('contractorContactDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('contractorContactDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-danger">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>
<script>
    $('#contact-delete').on('show.bs.modal', function (event) {
        $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
    });

    $(function() {
        APP.RecordHistoryLog.create({
            target: '.summary-panel.history-summary',
            targetTotalCount: '.summary-history-total',
            module: 'Contractor',
            entity: 'Contractor',
            id: '{{ $contractor->getId() }}'
        });

        APP.Comments.create({
            target: '.comments-panel',
            module: 'Contractor',
            entity: 'Contractor',
            id: '{{ $contractor->getId() }}'
        });
    });
</script>
