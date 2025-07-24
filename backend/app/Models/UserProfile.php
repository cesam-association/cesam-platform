<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserProfile extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'biographie',
        'photo_profil',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
