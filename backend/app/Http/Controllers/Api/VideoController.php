<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Video;
use Illuminate\Http\Request;

class VideoController extends Controller
{
    /**
     * Voir toutes les vidéos (Public - Étudiant)
     * GET /videos
     */
    public function index(Request $request)
    {
        try {
            $query = Video::active()->with('auteur:id,nom_complet');

            // Filtrer par thème si spécifié
            if ($request->has('theme') && $request->theme) {
                $query->byTheme($request->theme);
            }

            // Exclure les lives des vidéos normales (sauf si spécifiquement demandé)
            if (!$request->has('include_live')) {
                $query->where('is_live', false);
            }

            // Trier par date de publication (plus récent en premier)
            $videos = $query->orderBy('date_publication', 'desc')->get();

            return response()->json([
                'success' => true,
                'message' => 'Liste des vidéos récupérée avec succès',
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

    /**
     * Voir une vidéo spécifique (Public - Étudiant)
     * GET /videos/:id
     */
    public function show($id)
    {
        try {
            $video = Video::active()->with('auteur:id,nom_complet')->find($id);

            if (!$video) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vidéo non trouvée'
                ], 404);
            }

            // Incrémenter le nombre de vues
            $video->incrementViews();

            return response()->json([
                'success' => true,
                'message' => 'Vidéo récupérée avec succès',
                'data' => $video
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération de la vidéo',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Voir un live en cours (Public - Étudiant)
     * GET /videos/live
     */
    public function live()
    {
        try {
            $liveVideo = Video::active()->live()->first();

            if (!$liveVideo) {
                return response()->json([
                    'success' => false,
                    'message' => 'Aucun live en cours actuellement'
                ], 404);
            }

            // Incrémenter les vues pour le live
            $liveVideo->incrementViews();

            return response()->json([
                'success' => true,
                'message' => 'Live en cours récupéré avec succès',
                'data' => $liveVideo
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération du live',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Filtrer les vidéos par thème (Public - Étudiant)
     * GET /videos?theme=orientation
     */
    public function filterByTheme(Request $request)
    {
        // Cette fonctionnalité est déjà intégrée dans la méthode index()
        return $this->index($request);
    }

    /**
     * Obtenir la liste des thèmes disponibles
     * GET /videos/themes
     */
    public function getThemes()
    {
        try {
            $themes = Video::active()
                ->whereNotNull('theme')
                ->distinct()
                ->pluck('theme');

            return response()->json([
                'success' => true,
                'message' => 'Liste des thèmes récupérée avec succès',
                'data' => $themes
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la récupération des thèmes',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}