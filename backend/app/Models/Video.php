<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Video extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'titre',
        'description',
        'url',
        'miniature',
        'theme',
        'is_live',
        'is_active',
        'duree',
        'vues',
        'date_publication',
        'auteur_id',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'is_live' => 'boolean',
            'is_active' => 'boolean',
            'date_publication' => 'datetime',
            'vues' => 'integer',
            'duree' => 'integer',
        ];
    }

    /**
     * Get the user who created this video.
     */
    public function auteur()
    {
        return $this->belongsTo(User::class, 'auteur_id');
    }

    /**
     * Scope pour les vidéos actives
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope pour les vidéos live
     */
    public function scopeLive($query)
    {
        return $query->where('is_live', true);
    }

    /**
     * Scope pour filtrer par thème
     */
    public function scopeByTheme($query, $theme)
    {
        return $query->where('theme', $theme);
    }

    /**
     * Incrémenter le nombre de vues
     */
    public function incrementViews()
    {
        $this->increment('vues');
    }
}