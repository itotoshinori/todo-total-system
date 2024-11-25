<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    use HasFactory;
    protected $dates = ['created_at', 'updated_at'];
    protected $fillable = [
        'user_id',
        'title',
        'body',
        'term',
        'finishday',
        'link',
        'link_name',
        'is_done'
    ];
    protected $casts = [
        'is_done' => 'boolean'
    ];
}
