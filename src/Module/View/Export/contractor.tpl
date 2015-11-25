<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-briefcase"></i>
                {{ t('contractorContractorsExport') }}
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
            <li class="active"><a href="{{ createUrl('Contractor', 'Export', 'contractor') }}">{{ t('contractorContractorsExport') }}</a></li>
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 col-lg-5">
            <p class="bg-info" style="padding:10px 13px;margin:0 0 10px;">{{ t('contractorContractorExportSelectColumnsToExport') }}</p>
            <div class="columns-selector">
                <div class="to-select columns-list">
                    <div>
                        @loop $columns
                            @if $key != 'id'
                                <div data-name="{{ $key }}" class="item">{{ $item }}</div>
                            @endif
                        @endloop
                    </div>
                </div>
                <div class="selected columns-list">
                    <div>
                        <div data-name="id" class="disabled item">ID</div>
                    </div>
                </div>
                <div class="arrows">
                    <i class="fa fa-chevron-right"></i>
                    <i class="fa fa-chevron-left"></i>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-7">
            <p class="text-center" style="font-size:17px;margin:40px 0;">{{ t('contractorContractorExportGeneratedDocumentWillbeCompatibleWithExcell2007') }}<br />{{ t('contractorContractorExportGenerateFirstToDownload') }}</p>
            <p class="text-center">
                <button type="button" class="btn btn-lg btn-primary btn-action-generate">{{ t('contractorContractorExportGenerateFileExcell2007') }}</button>
            </p>
            <p class="bg-info text-center" style="padding:10px 13px;margin:40px 0 10px;">{{ t('contractorContractorExportGeneratedFileWillContainDataFromSelectedColumnsFromAllDatabaseRows') }}</p>
        </div>
    </div>
</div>
<style>
    .columns-selector {width:100%;max-width:100%;height:300px;position:relative;}
    .columns-selector:after {content:" ";display:table;clear:both;}
    .columns-selector .arrows {position:absolute;width:20px;height:80px;left:50%;top:50%;margin-top:-40px;margin-left:-10px;text-align:center;}
    .columns-selector .arrows i {display:block;text-align:center;line-height:40px;width:20px;height:40px;font-size:18px;color:#000;}
    .columns-selector > .columns-list {width:50%;float:left;}
    .columns-selector > .columns-list.to-select {padding-right:15px;}
    .columns-selector > .columns-list.selected {padding-left:15px;}
    .columns-selector > .columns-list > div {padding:0;border:1px solid #ddd;overflow:auto;position:relative;max-height:300px;}
    .columns-selector > .columns-list > div > div {width:100%;padding:4px 7px;font-size:12px;border-bottom:1px solid #ddd;background-color:#fff;}
    .columns-selector > .columns-list > div > div:last-child {border:none;}
    .columns-selector > .columns-list > div > div:hover {background-color:#f1f1f1;cursor:pointer;}
    .columns-selector > .columns-list > div > div.disabled {background-color:#f1f1f1;color:#888;}
    .columns-selector > .columns-list > div > div.disabled:hover {cursor:default;}
</style>
<script>
    var sortColumns = function() {
        $('.columns-selector .columns-list').each(function() {
            var items  = [];
            var target = $(this).find('> div');

            $(this).find('.item').not('.disabled').each(function() {
                items.push({
                    text  : $(this).text(),
                    class : $(this).attr('class'),
                    name  : $(this).attr('data-name'),
                });
            });

            items.sort(function(a, b) {
                if(a.text > b.text)
                    return 1;
                else if(a.text < b.text)
                    return -1;
                else
                    return 0;
            });

            target.find('.item').not('.disabled').remove();

            for(var i in items)
            {
                target.append('<div class="' + items[i].class + '" data-name="' + items[i].name + '">' + items[i].text + '</div>');
            }
        });
    };

    var texts = {
        btnInactive : '{{ t('contractorContractorExportGenerateFileExcell2007') }}',
        btnWaiter   : '<span><i class="fa fa-spin fa-spinner"></i>&nbsp;&nbsp;</span>{{ t('contractorContractorExportGeneratingWorks_ddd') }}'
    };

    $(function() {
        sortColumns();

        $('.columns-selector .to-select').on('click', '.item', function() {
            if($(this).hasClass('disabled'))
            {
                return false;
            }

            var item = $(this).clone();

            item.appendTo($('.columns-selector .selected > div'));

            $(this).remove();

            $('.columns-selector .selected > div').scrollTop(0);
            sortColumns();
        });
        $('.columns-selector .selected').on('click', '.item', function() {
            if($(this).hasClass('disabled'))
            {
                return false;
            }

            var item = $(this).clone();

            item.appendTo($('.columns-selector .to-select > div'));

            $(this).remove();

            $('.columns-selector .to-select > div').scrollTop(0);
            sortColumns();
        });

        $('.btn-action-generate').click(function() {
            var btn = $(this);

            if(btn.attr('disabled'))
                return;

            btn.attr('disabled', 'disabled').html(texts.btnWaiter);

            var properties = [];

            $('.columns-selector .selected .item').each(function() {
                properties.push($(this).attr('data-name'));
            });

            APP.AJAX.call({
                url: APP.createUrl('Contractor', 'Export', 'contractorGenerate'),
                data: {
                    properties: properties
                },
                success: function(name) {
                    btn.removeAttr('disabled').html(texts.btnInactive);
                    document.location.href = APP.createUrl('Contractor', 'Export', 'downloadFile', { 'filename': name });
                }
            });
        });
    });
</script>
