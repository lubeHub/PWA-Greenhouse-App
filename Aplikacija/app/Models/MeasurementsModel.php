<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class MeasurementsModel extends Model
{
    protected $table = 'measurements';
    
    use HasFactory, HasApiTokens,Notifiable;
    protected $fillable = [
        'name',
        'unit',
        'url',
    ];
}
