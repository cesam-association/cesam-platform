<?php

namespace App\Imports;

use App\Models\CodeBourse;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class CodeBourseImport implements ToModel, WithHeadingRow
{
    public function model(array $row)
    {
        return new CodeBourse([
            'user_id'            => Auth::id(),
            'pays'               => $row['pays'],
            'numero_matricule'   => $row['numero_matricule'],
            'nom'                => $row['nom'],
            'prenom'             => $row['prenom'],
            'numero_passport'    => $row['numero_passport'],
            'identifiant_commun' => $row['identifiant_commun'],
            'code_bourse'        => $row['code_bourse'],
        ]);
    }
}
