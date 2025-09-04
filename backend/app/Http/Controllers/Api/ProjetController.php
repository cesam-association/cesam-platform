<?php
// app/Http/Controllers/Api/ProjetController.php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Projet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;


class ProjetController extends Controller
{
    // Créer un projet (par un utilisateur)
    public function store(Request $request)
    {
        $request->validate([
            'titre' => 'required|string',
            'description' => 'required|string',
            'fichier' => 'nullable|file|mimes:pdf,doc,docx',
            'annee' => 'nullable|date',
            'type' => 'nullable|in:PFE,PFA',
            'note_obtenue' => 'nullable|numeric',
        ]);

        $data = $request->all();
        $data['user_id'] = Auth::id();

        if ($request->hasFile('fichier')) {
            $data['fichier'] = $request->file('fichier')->store('projets', 'public');
        }

        $projet = Projet::create($data);

        return response()->json([
            'message' => 'Projet créé avec succès. En attente de validation.',
            'projet' => $projet
        ]);
    }

    // Lister tous les projets validés
   public function index()
{
    $userId = Auth::id();

    // Projets validés de l'utilisateur, triés par date décroissante
    $userProjets = Projet::where('user_id', $userId)
                        ->where('valide', true)
                        ->orderBy('created_at', 'desc')
                        ->get();

    // Tous les projets non validés (pour l'admin)
    $nonValideProjets = Projet::where('valide', false)->get();

    return response()->json([
        'user_projets' => $userProjets,
        'non_valide_projets' => $nonValideProjets,
    ]);
}


    // Valider un projet (par admin)
    public function valider($id)
    {
        $projet = Projet::findOrFail($id);
        $projet->valide = true;
        $projet->save();

        return response()->json(['message' => 'Projet validé avec succès.']);
    }

    // Modifier un projet (uniquement par son créateur)

public function update(Request $request, $id)
{
    $projet = Projet::where('id', $id)
        ->where('user_id', Auth::id())
        ->firstOrFail();

    $request->validate([
        'titre' => 'sometimes|string',
        'description' => 'sometimes|string',
        'fichier' => 'nullable|file|mimes:pdf,doc,docx',
        'annee' => 'nullable|date',
        'type' => 'nullable|in:PFE,PFA',
        'note_obtenue' => 'nullable|numeric',
    ]);

    $data = $request->all();

    if ($request->hasFile('fichier')) {
        // Supprimer l'ancien fichier si il existe
        if ($projet->fichier && Storage::disk('public')->exists($projet->fichier)) {
            Storage::disk('public')->delete($projet->fichier);
        }
        // Stocker le nouveau fichier
        $data['fichier'] = $request->file('fichier')->store('projets', 'public');
    }

    $projet->update($data);

    return response()->json(['message' => 'Projet modifié avec succès', 'projet' => $projet]);
}


    // Supprimer un projet (Soft Delete)
    public function destroy($id)
    {
        $projet = Projet::where('id', $id)
            ->where('user_id', 2)
            ->firstOrFail();

        $projet->delete();

        return response()->json(['message' => 'Projet supprimé avec succès (soft delete)']);
    }
}
