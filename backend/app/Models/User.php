<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Laravel\Sanctum\HasApiTokens;


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
        'ecole',
        'filiere',
        'niveau_etude',
        'ville',
        'cv_url',
        'competences',
        'projets_realises',
        'affilie_amci',
        'code_amci',
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

}
