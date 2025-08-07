<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Imports\CodeBourseImport;
use Maatwebsite\Excel\Facades\Excel;

class CodeBourseImportController extends Controller
{
    /**
     * Importer un fichier Excel et insérer les données dans la table code_bourse.
     */
    public function import(Request $request)
    {
        // Validation du fichier reçu
        $request->validate([
            'file' => 'required|file|mimes:xlsx,xls,csv',
        ]);

        try {
            // Importation via Laravel Excel
            Excel::import(new CodeBourseImport, $request->file('file'));

            return response()->json([
                'message' => 'Importation réussie.',
            ], 200);

        } catch (\Exception $e) {
            // Gestion des erreurs
            return response()->json([
                'message' => 'Erreur lors de l\'importation.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
