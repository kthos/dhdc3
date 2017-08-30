<?php

namespace modules\sync\controllers;

use yii\web\Controller;
use yii\helpers\Html;

/**
 * Default controller for the `sync` module
 */
class DefaultController extends Controller {

    /**
     * Renders the index view for the module
     * @return string
     */
    public function actionIndex() {
        $json = file_get_contents('http://61.19.22.108:3001/api/sql');
        return $this->render('index', [
                    'data' => json_decode($json, TRUE)
        ]);
    }

    protected function sendPost($table, $data) {
        $url_api = "http://61.19.22.108:3001/api/send/$table";
        $options = [
            'http' => [
                'header' => "Content-type: application/x-www-form-urlencoded",
                'method' => 'POST',
                'content' => http_build_query($data)
            ]
        ];
        $context = stream_context_create($options);
        $result = file_get_contents($url_api, false, $context);
        if ($result === FALSE) {
            return $result;
        }
        return $result;
    }

    public function actionPost($table, $sql) {
        $this->layout = 'hdc';
        $raw = \Yii::$app->db->createCommand($sql)->queryAll();
        $keys = array_keys($raw[0]);

        foreach ($raw as $val) {
            $data = [];
            foreach ($keys as $k) {
                $data[$k] = $val[$k];
            }
            $this->sendPost($table, $data);
        }

        
        return $this->render('post',[
            'raw'=>$raw
        ]);
    }

}