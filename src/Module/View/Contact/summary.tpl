<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-phone-square"></i>
                {{ t('contractorContactSummary') }}
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
            <li><a href="{{ createUrl('Contractor', 'Contractor', 'summary', [ 'id' => $contractor->getId() ]) }}">{{ t('contractor') }} - {{ $contractor->getName() }}</a></li>
            <li class="active"><a href="{{ createUrl('Contractor', 'Contact', 'summary', [ 'id' => $contact->getId() ]) }}">{{ t('contractorContact') }} - {{ $contact->getName() }}</a></li>
        </ul>
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
                                <h3>{{ $contact->getName() }}
                                    @if $contact->getPositionInCompany()
                                        <small>(
                                            @if $contact->getCompanyName()
                                                <?=str_replace(['%positionInCompany%', '%companyName%'], ['<b>'.$contact->getPositionInCompany().'</b>', '<b>'.$contact->getCompanyName().'</b>'], $app->t('contractorPositionInCompany'))?>
                                            @else
                                                {{ $contact->getPositionInCompany() }}
                                            @endif
                                        )</small>
                                    @endif
                                </h3>
                                <span class="actions">
                                    <a href="{{ createUrl('Contractor', 'Contact', 'edit', [ 'id' => $contact->getId() ]) }}" class="btn btn-sm btn-default"><i class="fa fa-pencil"></i> {{ t('edit') }}</a>
                                </span>
                                <div class="summary-details">
                                    @if $contact->getPhone()
                                        <div class="item">
                                            <label>{{ t('phoneNumber') }}</label>
                                            <div>{{ $contact->getPhone() }} <a class="action-icon" href="tel:{{ $contact->getPhone() }}"><i class="fa fa-phone"></i></a></div>
                                        </div>
                                    @endif
                                    @if $contact->getEmail()
                                        <div class="item">
                                            <label>{{ t('emailAddress') }}</label>
                                            <div>{{ $contact->getEmail() }} <a class="action-icon" href="mailto:{{ $contact->getEmail() }}"><i class="fa fa-envelope"></i></a></div>
                                        </div>
                                    @endif
                                    @if $contact->getCompanyName()
                                        <div class="item">
                                            <label>{{ t('companyName') }}</label>
                                            <div>{{ $contact->getCompanyName() }}</div>
                                        </div>
                                    @endif
                                </div>
                                @if $contact->getDescription()
                                    <hr />
                                    <p>{{ $contact->getDescription() }}</p>
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
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="contact-delete" tabindex="-1" role="dialog" aria-labelledby="contact-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="contact-delete-modal-label">{{ t('contractorContactDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('contractorContactDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-primary">{{ t('syes') }}</a>
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
            entity: 'Contact',
            id: '{{ $contact->getId() }}'
        });
    });
</script>
