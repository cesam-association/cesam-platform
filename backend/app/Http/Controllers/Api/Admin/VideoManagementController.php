<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Video;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class VideoManagementController extends Controller
{
    /**
     * Ajouter une nouvelle vidéo (Admin seulement)
     * POST /videos
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'titre' => 'required|string|max:255',
                'description' => 'nullable|string',
                'url' => 'required|string|url',
                'miniature' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'theme' => 'nullable|string|in:orientation,témoignages,événements,cours,divers',
                'is_live' => 'boolean',
                'duree' => 'nullable|integer|min:1',
                'date_publication' => 'nullable|date',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Données de validation échouées',
                    'errors' => $validator->errors()
                ], 422);
            }

            $videoData = $request->only([
                'titre', 'description', 'url', 'theme', 'is_live', 'duree'
            ]);

            // Gestion de l'upload de la miniature
            if ($request->hasFile('miniature')) {
                $miniaturePath = $request->file('miniature')->store('videos/miniatures', 'public');
                $videoData['miniature'] = $miniaturePath;
            }

            // Définir la date de publication
            $videoData['date_publication'] = $request->date_publication 
                ? $request->date_publication 
                : now();

            // Auteur = utilisateur connecté
            $videoData['auteur_id'] = auth()->id();

            $video = Video::create($videoData);

            return response()->json([
                'success' => true,
                'message' => 'Vidéo ajoutée avec succès',
                'data' => $video->load('auteur:id,nom_complet')
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de l\'ajout de la vidéo',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Modifier une vidéo existante (Admin seulement)
     * PUT /videos/:id
     */
    public function update(Request $request, $id)
    {
        try {
            $video = Video::find($id);

            if (!$video) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vidéo non trouvée'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'titre' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'url' => 'sometimes|string|url',
                'miniature' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'theme' => 'nullable|string|in:orientation,témoignages,événements,cours,divers',
                'is_live' => 'boolean',
                'is_active' => 'boolean',
                'duree' => 'nullable|integer|min:1',
                'date_publication' => 'nullable|date',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Données de validation échouées',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Mise à jour des champs
            $updateData = $request->only([
                'titre', 'description', 'url', 'theme', 'is_live', 'is_active', 'duree', 'date_publication'
            ]);

            // Gestion de la nouvelle miniature
            if ($request->hasFile('miniature')) {
                // Supprimer l'ancienne miniature si elle existe
                if ($video->miniature) {
                    Storage::disk('public')->delete($video->miniature);
                }
                
                $miniaturePath = $request->file('miniature')->store('videos/miniatures', 'public');
                $updateData['miniature'] = $miniaturePath;
            }

            $video->update($updateData);

            return response()->json([
                'success' => true,
                'message' => 'Vidéo mise à jour avec succès',
                'data' => $video->load('auteur:id,nom_complet')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la mise à jour de la vidéo',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Supprimer une vidéo (Admin seulement)
     * DELETE /videos/:id
     */
    public function destroy($id)
    {
        try {
            $video = Video::find($id);

            if (!$video) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vidéo non trouvée'
                ], 404);
            }

            // Supprimer la miniature du stockage
            if ($video->miniature) {
                Storage::disk('public')->delete($video->miniature);
            }

            $video->delete();

            return response()->json([
                'success' => true,
                'message' => 'Vidéo supprimée avec succès'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la suppression de la vidéo',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lister toutes les vidéos pour l'admin (incluant inactives)
     * GET /admin/videos
     */
    public function index(Request $request)
    {
        try {
            $query = Video::with('auteur:id,nom_complet');

            // Filtres optionnels
            if ($request->has('theme') && $request->theme) {
                $query->byTheme($request->theme);
            }

            if ($request->has('is_active')) {
                $query->where('is_active', $request->boolean('is_active'));
            }

            if ($request->has('is_live')) {
                $query->where('is_live', $request->boolean('is_live'));
            }

            $videos = $query->orderBy('created_at', 'desc')->get();

            return response()->json([
                'success' => true,
                'message' => 'Liste des vidéos (admin) récupérée avec succès',
                'data' => $videos
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération des vidéos',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}