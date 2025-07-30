<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class RegisterController extends Controller
{
    public function step1(Request $request)
    {
        $validated = $request->validate([
            'nom_complet' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'nom_complet' => $validated['nom_complet'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'role' => 'etudiant',
            'verification_token' => Str::random(64),
        ]);

        return response()->json(['message' => 'Étape 1 complétée', 'user_id' => $user->id], 201);
    }

    public function step2(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'telephone' => 'nullable|string|max:20',
            'nationalite' => 'nullable|string|max:100',
        ]);

        $user = User::findOrFail($validated['user_id']);
        $user->update([
            'telephone' => $validated['telephone'] ?? $user->telephone,
            'nationalite' => $validated['nationalite'] ?? $user->nationalite,
        ]);

        return response()->json(['message' => 'Étape 2 complétée']);
    }

    public function step3(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'niveau_etude' => 'nullable|string|max:255',
            'domaine_etude' => 'nullable|string|max:255',
        ]);

        $user = User::findOrFail($validated['user_id']);
        $user->update([
            'niveau_etude' => $validated['niveau_etude'] ?? $user->niveau_etude,
            'domaine_etude' => $validated['domaine_etude'] ?? $user->domaine_etude,
        ]);

        return response()->json(['message' => 'Étape 3 complétée']);
    }

    public function step4(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'role' => 'required|in:admin,etudiant',
        ]);

        $user = User::findOrFail($validated['user_id']);
        $user->update(['role' => $validated['role']]);

        return response()->json(['message' => 'Étape 4 complétée']);
    }

    public function step5(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'verification_token' => 'required|string',
            'is_verified' => 'required|boolean',
        ]);

        $user = User::findOrFail($validated['user_id']);

        if ($user->verification_token !== $validated['verification_token']) {
            return response()->json(['message' => 'Token de vérification invalide'], 403);
        }

        $user->update([
            'is_verified' => $validated['is_verified'],
            'verification_token' => null,
        ]);

        return response()->json(['message' => 'Étape 5 complétée - utilisateur vérifié']);
    }
}
