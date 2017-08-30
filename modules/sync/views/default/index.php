<div class="sync-default-index">
    <h3>รายการคำสั่ง</h3>

    <?php

    use yii\helpers\Html;
    use kartik\grid\GridView;
    use yii\data\ArrayDataProvider;

$dataProvider = new ArrayDataProvider([
        'allModels' => $data
    ]);

    echo GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            'id',
            'title',
            'sql',
            [
                'attribute' => 'active',
                'format' => 'raw',
                'width'=>'30px',
                'value' => function($model) {
                    $table = $model['table'];
                    $sql = $model['sql'];
                    if ($model['active'] == 1) {
                        return Html::a("ส่งข้อมูล", ['post','table' => $table,'sql'=>$sql],['target' => '_blank','class'=>'btn btn-default']);
                    } else {
                        return 'close';
                    }
                }
                    ]
                ]
            ]);
            ?>
</div>
