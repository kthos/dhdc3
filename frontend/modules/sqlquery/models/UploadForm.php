<?php
namespace frontend\modules\sqlquery\models;
use yii\base\Model;
class UploadForm extends Model
{
    /**
     * @var UploadedFile|Null file attribute
     */
    public $file;

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            [['file'], 'file', 'maxFiles' => 10,'extensions' => 'txt,sql'], // <--- here!
        ];
    }
}