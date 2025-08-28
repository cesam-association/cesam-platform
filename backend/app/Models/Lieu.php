<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

// Modèle Lieu
class Lieu extends Model
{
    use HasFactory;

    protected $table = 'lieux';

    protected $fillable = [
        'nom',
        'description',
        'adresse',
        'ville_id',
        'categorie_id',
        'carte_url',
        'horaires',
        'latitude',
        'longitude',
        'telephone',
        'email',
        'site_web',
        'prix_moyen',
        'is_active',
        'vues',
        'date_publication',
        'auteur_id',
    ];

    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
            'date_publication' => 'datetime',
            'vues' => 'integer',
            'latitude' => 'decimal:8',
            'longitude' => 'decimal:8',
            'prix_moyen' => 'decimal:2',
        ];
    }

    /**
     * Get the city of this place.
     */
    public function ville()
    {
        return $this->belongsTo(Ville::class);
    }

    /**
     * Get the category of this place.
     */
    public function categorie()
    {
        return $this->belongsTo(CategorieLieu::class, 'categorie_id');
    }

    /**
     * Get the user who created this place.
     */
    public function auteur()
    {
        return $this->belongsTo(User::class, 'auteur_id');
    }

    /**
     * Get all photos of this place.
     */
    public function photos()
    {
        return $this->hasMany(PhotoLieu::class)->orderBy('ordre');
    }

    /**
     * Get the main photo of this place.
     */
    public function photoprincipale()
    {
        return $this->hasOne(PhotoLieu::class)->where('is_principale', true);
    }

    /**
     * Scope pour les lieux actifs
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope pour filtrer par ville
     */
    public function scopeByVille($query, $villeNom)
    {
        return $query->whereHas('ville', function($q) use ($villeNom) {
            $q->where('nom', 'LIKE', "%{$villeNom}%");
        });
    }

    /**
     * Scope pour filtrer par catégorie
     */
    public function scopeByCategorie($query, $categorieNom)
    {
        return $query->whereHas('categorie', function($q) use ($categorieNom) {
            $q->where('nom', 'LIKE', "%{$categorieNom}%");
        });
    }

    /**
     * Scope pour recherche textuelle
     */
    public function scopeSearch($query, $search)
    {
        return $query->where(function($q) use ($search) {
            $q->where('nom', 'LIKE', "%{$search}%")
              ->orWhere('description', 'LIKE', "%{$search}%")
              ->orWhere('adresse', 'LIKE', "%{$search}%")
              ->orWhereHas('ville', function($ville) use ($search) {
                  $ville->where('nom', 'LIKE', "%{$search}%");
              })
              ->orWhereHas('categorie', function($cat) use ($search) {
                  $cat->where('nom', 'LIKE', "%{$search}%");
              });
        });
    }

    /**
     * Incrémenter le nombre de vues
     */
    public function incrementViews()
    {
        $this->increment('vues');
    }
}