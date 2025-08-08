<?php

namespace App\Http\Controllers\Code;

use App\Models\CodeBourse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class CodeBourseController extends Controller
{
    public function getCodeBourseByMatricule(Request $request)
    {
        $request->validate([
            'matricule' => 'required|integer',
        ]);

        $matricule = $request->input('matricule');

        // Recherche du code_bourse le plus récent pour ce matricule
        $codeBourse = CodeBourse::where('numero_matricule', $matricule)
            ->orderBy('created_at', 'desc')
            ->first();

        if (!$codeBourse) {
            return response()->json([
                'message' => 'Aucun code bourse trouvé pour ce matricule.'
            ], 404);
        }

        return response()->json([
            'matricule' => $matricule,
            'code_bourse' => $codeBourse->code_bourse,
            'pays' => $codeBourse->pays,
            'nom' => $codeBourse->nom,
            'prenom' => $codeBourse->prenom,
            'identifiant_commun' => $codeBourse->identifiant_commun,
            'date_creation' => $codeBourse->created_at,
        ]);
    }
}
