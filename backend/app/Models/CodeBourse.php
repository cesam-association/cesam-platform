<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CodeBourse extends Model
{
    use HasFactory;

    protected $table = 'code_bourse';

    protected $fillable = [
        'user_id',
        'pays',
        'numero_matricule',
        'nom',
        'prenom',
        'numero_passport',
        'identifiant_commun',
        'code_bourse',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
