<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Laravel\Sanctum\HasApiTokens;
use App\Models\UserProfile;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Projet;


class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles,SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'nom_complet',
        'email',
        'password',
        'telephone',
        'nationalite',
        'role',
        'verification_token',
        'is_verified',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'verification_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'competences' => 'array',
            'projets_realises' => 'array',
            'is_verified' => 'boolean',
            'affilie_amci' => 'boolean',
        ];
    }

        /**
     * Relation avec le profil utilisateur complémentaire.
     */
    public function profile()
    {
        return $this->hasOne(UserProfile::class);
    }
<<<<<<< HEAD
    /**
     * Relation avec les projets de l'utilisateur.
=======

    /**
     * Get all of the user's projects.
>>>>>>> 7d5dfb484107a24e3be892fe937e4ad308030066
     */
    public function projets()
    {
        return $this->hasMany(Projet::class);
    }
<<<<<<< HEAD
=======

    /**
     * Get all of the user's competences.
     */
    public function competences()
    {
        return $this->hasMany(Competence::class);
    }

        /**
     * Get all videos created by this user.
     */
    public function videos()
    {
        return $this->hasMany(Video::class, 'auteur_id');
    }


    /**
     * Get all places created by this user.
     */
    public function lieux()
    {
        return $this->hasMany(Lieu::class, 'auteur_id');
    }


>>>>>>> 7d5dfb484107a24e3be892fe937e4ad308030066
}
