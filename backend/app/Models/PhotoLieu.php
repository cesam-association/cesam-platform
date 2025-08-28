<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

// Modèle PhotoLieu
class PhotoLieu extends Model
{
    use HasFactory;

    protected $table = 'photos_lieux';

    protected $fillable = [
        'lieu_id',
        'url',
        'legende',
        'is_principale',
        'ordre',
    ];

    protected function casts(): array
    {
        return [
            'is_principale' => 'boolean',
            'ordre' => 'integer',
        ];
    }

    /**
     * Get the place this photo belongs to.
     */
    public function lieu()
    {
        return $this->belongsTo(Lieu::class);
    }
}
