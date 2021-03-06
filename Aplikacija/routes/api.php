<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::apiResource('users', 'Api\UserController')->only(['index', 'show']);
Route::apiResource('measurements', 'Api\MeasurementsController')->only(['index', 'show']);
Route::get('mqtt', 'Api\MttqController@kreirajMqtt');
Route::post('usermeasurements', 'Api\UserMeasurementController@addMeasurementsToUser');
Route::post('getusermeasurements/{id}', 'Api\UserMeasurementController@getMeasurementsFromUser');
