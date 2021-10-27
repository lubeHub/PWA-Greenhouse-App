<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserIndexResource;
use App\Http\Resources\UserShowResource;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(){
        return  UserIndexResource::collection(User::all());
    }

    public function show($id){
        return new UserShowResource(User::findOrFail($id));
    }
}
