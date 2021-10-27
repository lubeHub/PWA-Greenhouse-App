<?php

namespace App\Http\Controllers\Api;
use \Bluerhinos\phpMQTT;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \PhpMqtt\Client\ConnectionSettings;
use \PhpMqtt\Client\MqttClient;

class MttqController extends Controller
{
	public function KreirajMqtt()
	{
		$server = 'mqtt3.thingspeak.com';
		$port = 1883;
		$username = 'IiEkOxwSFBgSDSsgOjwwGRM';
		$clientId = 'IiEkOxwSFBgSDSsgOjwwGRM';
		$password = '8h/rK9iAn4M34bauwilICLp+';

		$mttq = new MqttClient($server, $port, $clientId);
		$connectionSettings  = new ConnectionSettings();
		$connectionSettings
		->setUsername($username)
		->setPassword($password)
		->setKeepAliveInterval(15)
		->setLastWillTopic('channels/1500203/subscribe')
		->setLastWillMessage('client disconnect')
		->setLastWillQualityOfService(0);
		$mttq->connect($connectionSettings, true);
		$mttq->subscribe(
			'channels/1500203/subscribe',
			function ($topic, $message) {
			dd($message);
		},
			0
		);
	}

	// public function KreirajMqtt1()
	// {
	// 	$server = 'mqtt3.thingspeak.com';
	// 	$port = 1883;
	// 	$username = 'IiEkOxwSFBgSDSsgOjwwGRM';
	// 	$clientId = 'IiEkOxwSFBgSDSsgOjwwGRM';
	// 	$password = '8h/rK9iAn4M34bauwilICLp+';

	// 	$mqtt = new phpMQTT($server,$port,$clientId);

	// 	if (!$mqtt->connect(false, NULL, $username, $password)) {
	// 		exit(1);
	// 	}
	// 	dd($mqtt->subscribeAndWaitForMessage('channels/1500203/subscribe',0));	
	// }
			
	
}
