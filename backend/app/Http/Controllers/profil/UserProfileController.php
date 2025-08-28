<?php

namespace App\Http\Controllers\profil;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserProfileController extends Controller
{
    //Methode pour recuperer le profil de l'utilisateur
    public function show(Request $request)
    {
        return response()->json([
            'success'=>true,
            'user' => $request->user(),
        ], 200);
    
    }
    public function update(Request $request)
    {
        // Récupération de l'utilisateur connecté
        $user = Auth::user();

        // Vérification de l'authentification
        if (!$user || !($user instanceof \App\Models\User)) {
            return response()->json(['message' => 'Utilisateur non authentifié ou introuvable'], 401);
        }

        // Validation des données
        $validatedData = $request->validate([
            'nom_complet'   => 'sometimes|string|max:255',
            'email'         => 'sometimes|email|unique:users,email,' . $user->id,
            'telephone'     => 'sometimes|string|nullable',
            'nationalite'   => 'sometimes|string|nullable',
            'niveau_etude'  => 'sometimes|string|nullable',
            'domaine_etude' => 'sometimes|string|nullable',
            'password'      => 'sometimes|string|min:6|confirmed',
        ]);

        // Mise à jour des champs classiques
        collect([
            'nom_complet',
            'email',
            'telephone',
            'nationalite',
            'niveau_etude',
            'domaine_etude'
        ])->each(function ($field) use ($validatedData, $user) {
            if (array_key_exists($field, $validatedData)) {
                $user->$field = $validatedData[$field];
            }
        });

        // Mise à jour du mot de passe s’il est fourni
        if (!empty($validatedData['password'])) {
            $user->password = Hash::make($validatedData['password']);
        }

        // Sauvegarde
        $user->save();

        return response()->json([
            'message' => 'Profil mis à jour avec succès.',
            'user'    => $user,
        ]);
    }
    //pour qu'un user puisse supprimer son compte en utilisant le softdelete
    public function destroy(Request $request)
{
    $user = $request->user(); // Récupère l'utilisateur connecté

    // Soft delete de l'utilisateur
    $user->delete();

    return response()->json([
        'message' => 'Votre compte a été supprimé avec succès.',
        'deleted_at' => $user->deleted_at, // cela sera null tant que pas rechargé depuis la DB
    ], 200);
}

}
