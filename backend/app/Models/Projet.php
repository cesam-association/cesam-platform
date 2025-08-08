<?php
// app/Models/Projet.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\User;
use Illuminate\Database\Eloquent\SoftDeletes;

class Projet extends Model 
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'titre',
        'description',
        'fichier',
        'annee',
        'type',
        'note_obtenue',
        'valide',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
