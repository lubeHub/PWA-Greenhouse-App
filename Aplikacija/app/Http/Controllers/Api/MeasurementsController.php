<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MeasurementsModel;
use Illuminate\Http\Request;

class MeasurementsController extends Controller
{
 
    public function index()
    {
        return  MeasurementsModel::all();
    }

    public function show($id)
    {
        return  MeasurementsModel::findOrFail($id);
    }
}
