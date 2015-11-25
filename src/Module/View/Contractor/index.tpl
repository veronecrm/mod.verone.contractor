<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-briefcase"></i>
                {{ t('contractors') }}
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="{{ createUrl('Contractor', 'Contractor', 'add') }}" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-plus"></i>
                    <span>{{ t('contractorNew') }}</span>
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
            <li class="active"><a href="{{ createUrl('Contractor', 'Contractor', 'index') }}">{{ t('contractors') }}</a></li>
        </ul>
        <!-- <ul class="breadcrumb-elements">
            <li><a href="{{ createUrl('Contractor', 'Export', 'contractor') }}"><i class="fa fa-arrow-up"></i> {{ t('contractorContractorsExport') }}</a></li>
        </ul>
        <div class="breadcrumb-elements-toggle">
            <i class="fa fa-unsorted"></i>
        </div> -->
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="widget-alphabet-links">
                <div class="links-list">
                    @if $app->request()->get('letter')
                        <a class="cancel" href="<?=$app->request()->buildUriFromSegments([ 'query' => [ 'letter' => '' ] ])?>"><i class="fa fa-remove"></i></a>
                    @endif
                    <?php foreach($app->localisation()->alphabet() as $letter): ?>
                        <a <?php echo ($app->request()->get('letter') == $letter ? 'class="active" ' : ''); ?>href="<?=$app->request()->buildUriFromSegments([ 'query' => [ 'letter' => $letter ] ])?>">{{ $letter }}</a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php
                /**
                 * Here we store QuickEdit values for rows.
                 */
                $jsQuickEdit = [];
            ?>
            <table class="table table-default table-clicked-rows table-responsive">
                <thead>
                    <tr>
                        <th class="text-center span-1"><input type="checkbox" name="select-all" data-select-all="input_contractor" /></th>
                        <th>{{ t('contractorName') }}</th>
                        <th>{{ t('emailAddress') }}</th>
                        <th>{{ t('phoneNumber') }}</th>
                        <th class="text-right">{{ t('action') }}</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($elements as $item): ?>
                        <tr data-row-click-target="<?php echo $app->createUrl('Contractor', 'Contractor', 'summary', [ 'id' => $item->getId() ]); ?>" id="row-{{ $item->getId() }}">
                            <td class="text-center hidden-xs"><input type="checkbox" name="input_contractor" value="<?php echo $item->getId(); ?>" /></td>
                            <td data-th="{{ t('contractorName') }}" class="contractor-name th"><?php echo $item->getName(); ?></td>
                            <td data-th="{{ t('emailAddress') }}" class="contractor-email"><?php echo $item->getEmail(); ?></td>
                            <td data-th="{{ t('phoneNumber') }}" class="contractor-phone"><?php echo $item->getPhone(); ?></td>
                            <td data-th="{{ t('action') }}" class="app-click-prevent">
                                <div class="actions-box">
                                    <button type="button" class="btn btn-default btn-xs quick-edit-trigger hidden-xs" data-quick-edit-id="{{ $item->getId() }}" data-toggle="tooltip" title="{{ t('quickEdit') }}"><i class="fa fa-map-o"></i></button>
                                    <div class="btn-group right">
                                        <a href="<?php echo $app->createUrl('Contractor', 'Contractor', 'edit', [ 'id' => $item->getId() ]); ?>" class="btn btn-default btn-xs btn-main-action" title="{{ t('edit') }}"><i class="fa fa-pencil"></i></a>
                                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" >
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu with-headline right">
                                            <li class="headline">{{ t('moreOptions') }}</li>
                                            <li><a href="<?php echo $app->createUrl('Contractor', 'Contractor', 'edit', [ 'id' => $item->getId() ]); ?>" title="{{ t('edit') }}"><i class="fa fa-pencil"></i> {{ t('edit') }}</a></li>
                                            <li><a href="<?php echo $app->createUrl('Contractor', 'Contractor', 'summary', [ 'id' => $item->getId() ]); ?>" title="{{ t('summary') }}"><i class="fa fa-bars"></i> {{ t('summary') }}</a></li>
                                            <li role="separator" class="divider"></li>
                                            <li><a href="<?php echo $app->createUrl('Contractor', 'Contractor', 'copy', [ 'id' => $item->getId() ]); ?>" title="{{ t('contractorCopyContractor') }}"><i class="fa fa-copy"></i> {{ t('contractorCopyContractor') }}</a></li>
                                            <li role="separator" class="divider"></li>
                                            <li class="item-danger"><a href="#" data-toggle="modal" data-target="#contractor-delete" data-href="<?php echo $app->createUrl('Contractor', 'Contractor', 'delete', [ 'id' => $item->getId() ]); ?>" title="{{ t('delete') }}"><i class="fa fa-remove danger"></i> {{ t('delete') }}</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <?php
                            $jsQuickEdit[] = "{id:{$item->getId()},name:'{$item->getName()}',email:'{$item->getEmail()}',phone:'{$item->getPhone()}'}";
                        ?>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php $request = $app->request(); ?>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <form action="" method="get" class="form-inline">
                            <input type="hidden" name="mod" value="Contractor" />
                            <input type="hidden" name="cnt" value="Contractor" />
                            <input type="hidden" name="act" value="index" />
                            <input type="hidden" name="search" value="1" />
                            <div class="input-group">
                                <input type="text" class="form-control" name="q" value="{{ $request->get('q') }}" />
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-default"><i class="fa fa-search"></i> {{ t('search') }}</button>
                                    @if $request->get('q')
                                        <a href="<?php echo $app->createUrl('Contractor', 'Contractor', 'index'); ?>" class="btn"><i class="fa fa-remove"></i> {{ t('cancel') }}</a>
                                    @endif
                                </span>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        {{ $pagination|raw }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="contractor-delete" tabindex="-1" role="dialog" aria-labelledby="contractor-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-danger">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="contractor-delete-modal-label">{{ t('contractorDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('contractorDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-danger">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>

<div class="quick-edit-form">
    <div class="qef-cnt">
        <h4>{{ t('quickEdit') }}</h4>
        <form action="" method="post" class="form-validation" id="contractor-quick-edit">
            <div class="form-group">
                <label for="name" class="control-label">{{ t('productName') }}</label>
                <input class="form-control required" type="text" id="name" name="name" value="" />
            </div>
            <div class="form-group">
                <label for="phone" class="control-label">{{ t('phoneNumber') }}</label>
                <input class="form-control" type="text" id="phone" name="phone" value="" />
            </div>
            <div class="form-group">
                <label for="email" class="control-label">{{ t('emailAddress') }}</label>
                <input class="form-control" type="email" id="email" name="email" value="" />
            </div>
        </form>
    </div>
    <div class="bottom-actions">
        <button type="button" class="btn btn-circle btn-secondary btn-quick-edit-close left" data-toggle="tooltip" title="{{ t('close') }}"><i class="fa fa-angle-double-left"></i></button>
        <a href="#" class="btn btn-circle btn-default" data-toggle="tooltip" title="{{ t('fullEdition') }}"><i class="fa fa-pencil"></i></a>
        <button type="button" class="btn btn-circle btn-success btn-quick-edit-save" data-toggle="tooltip" title="{{ t('save') }}"><i class="fa fa-save"></i></button>
    </div>
</div>

<script>
    $(function() {
        $('#contractor-delete').on('show.bs.modal', function (event) {
            $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
        });

        APP.QuickEdit.create({
            url: APP.createUrl('Contractor', 'Contractor', 'update'),
            src: [ <?php echo implode(', ', $jsQuickEdit); ?> ],
            onChange: function(id) {
                $('.quick-edit-form .bottom-actions a.btn-default').attr('href', APP.createUrl('Contractor', 'Contractor', 'edit', { id: id }));
            },
            onSave: function(values) {
                if(! APP.FormValidation.validateForm($('#contractor-quick-edit')))
                {
                    return false;
                }

                var row = $('#row-' + values.id);
                row.find('.contractor-name').text(values.name);
                row.find('.contractor-email').text(values.email);
                row.find('.contractor-phone').text(values.phone);

                return values;
            }
        });
    });
</script>
