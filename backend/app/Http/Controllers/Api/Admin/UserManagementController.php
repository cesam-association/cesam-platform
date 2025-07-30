<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserManagementController extends Controller
{
    /**
     * Lister tous les utilisateurs (Admin seulement)
     * GET /utilisateurs
     */
    public function index()
    {
        try {
            $users = User::with(['profile', 'roles'])->get();

            return response()->json([
                'success' => true,
                'message' => 'Liste des utilisateurs récupérée avec succès',
                'data' => $users
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération des utilisateurs',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Voir le profil d'un utilisateur spécifique (Admin seulement)
     * GET /utilisateurs/:id
     */
    public function show($id)
    {
        try {
            $user = User::with(['profile', 'competences.type', 'projets', 'roles'])->find($id);

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Utilisateur non trouvé'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'message' => 'Profil utilisateur récupéré avec succès',
                'data' => $user
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération du profil',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Modifier le rôle d'un utilisateur (Admin seulement)
     * PUT /utilisateurs/:id
     */
    public function update(Request $request, $id)
    {
        try {
            $user = User::find($id);

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Utilisateur non trouvé'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'role' => 'sometimes|string|in:etudiant,admin,responsable_cesam',
                'is_verified' => 'sometimes|boolean'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Données de validation échouées',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Mise à jour du rôle avec Spatie
            if ($request->has('role')) {
                // Supprimer tous les rôles existants
                $user->syncRoles([]);
                // Assigner le nouveau rôle
                $user->assignRole($request->role);
            }

            // Mise à jour du statut de vérification
            if ($request->has('is_verified')) {
                $user->is_verified = $request->is_verified;
            }

            $user->save();

            // Recharger l'utilisateur avec ses rôles
            $user->load('roles');

            return response()->json([
                'success' => true,
                'message' => 'Utilisateur mis à jour avec succès',
                'data' => $user
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la mise à jour de l\'utilisateur',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Supprimer un utilisateur (Admin seulement)
     * DELETE /utilisateurs/:id
     */
    public function destroy($id)
    {
        try {
            $user = User::find($id);

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Utilisateur non trouvé'
                ], 404);
            }

            // Empêcher la suppression de son propre compte
            if ($user->id === auth()->id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vous ne pouvez pas supprimer votre propre compte'
                ], 403);
            }

            $user->delete();

            return response()->json([
                'success' => true,
                'message' => 'Utilisateur supprimé avec succès'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la suppression de l\'utilisateur',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}