<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        if (!Auth::attempt($credentials)) {
            return response()->json(['message' => 'Identifiants invalides'], 401);
        }

        $user = Auth::user();

        if (!$user->is_verified) {
            return response()->json(['message' => 'Veuillez vérifier votre email'], 403);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Connecté avec succès',
            'access_token' => $token,
            'token_type' => 'Bearer',
        ]);
    }
}
