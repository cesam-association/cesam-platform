<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;


class User extends Authenticatable
{
    use HasFactory, Notifiable, HasRoles;

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
            'is_verified' => 'boolean',
        ];
    }

        /**
     * Relation avec le profil utilisateur complémentaire.
     */
    public function profile()
    {
        return $this->hasOne(UserProfile::class);
    }

    /**
     * Get all of the user's projects.
     */
    public function projets()
    {
        return $this->hasMany(Projet::class);
    }

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

}
