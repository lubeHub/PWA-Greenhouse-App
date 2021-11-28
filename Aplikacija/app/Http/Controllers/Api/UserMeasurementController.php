<?php

namespace App\Http\Controllers\Api;

use \Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserMeasurementController extends Controller
{
    public function addMeasurementsToUser(Request $request)
    {
        $userId = $request->input('userId');
        $measurementArray = $this->arrayValidation($request->input('measurementArray'));

        $this->arrayValidation($measurementArray);


        $this->deleteMeasurementsFromUser($userId);


        foreach ($measurementArray as $measurement) {


            DB::insert('INSERT INTO `user_measurements` (`user_id`, `measurements_id`,`fieldId`) VALUES ( ?, ?,?)', [$userId, $this->convertNameToId($measurement["value"]), $measurement["field"]]);
        }
    }
    public function getMeasurementsFromUser($id)
    {
       
       
        $measurements = DB::table('user_measurements')->select('user_id', 'measurements_id', 'fieldId', 'measurements.name', 'measurements.unit', 'measurements.url')
            ->leftJoin('measurements', 'user_measurements.measurements_id', '=', 'measurements.id')
         ->where('user_measurements.user_id', '=', $id)
         ->orderBy('fieldId')->get();
            
       return $measurements;
    }

    private function  deleteMeasurementsFromUser($userId)
    {
        DB::delete('DELETE from user_measurements WHERE user_id= ?', [$userId]);
    }

    private function convertNameToId($measurement)
    {
        return   DB::table('measurements')->where('name', $measurement)->value('id');
    }

    private function arrayValidation($measurementArray)
    {

        return   array_filter($measurementArray, fn ($arr) => !is_null($arr['value']));
    }
}
