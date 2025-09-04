<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\Admin\UserManagementController;
use App\Http\Controllers\Api\VideoController;
use App\Http\Controllers\Api\Admin\VideoManagementController;
use App\Http\Controllers\Api\LieuController;
use App\Http\Controllers\Api\Admin\LieuManagementController;
=======
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\LogoutController;
use App\Http\Controllers\profil\UserProfileController;
use App\Http\Controllers\Api\Admin\UserManagementController;
use App\Http\Controllers\Admin\CodeBourseImportController;
use App\Http\Controllers\Code\CodeBourseController;
use App\Http\Controllers\Api\ProjetController;

// Routes API pour la gestion des projets  cote client a remettre apres dans le middleware
Route::post('/projets', [ProjetController::class, 'store']);
Route::get('/projets', [ProjetController::class, 'index']);
Route::put('/projets/{id}', [ProjetController::class, 'update']); // Modification
Route::delete('/projets/{id}', [ProjetController::class, 'destroy']); // Suppression soft delete
//Routes API pour la gestion des projets  cote admin pour valider le projet a remettre apres dans le middleware
 Route::patch('/projets/{id}/valider', [ProjetController::class, 'valider']);


//Api pour permettre aux utilisateurs de récupérer leur code bourse a remettre apres dans le middleware
Route::get('/code-bourse', [CodeBourseController::class, 'getCodeBourseByMatricule']);

// Routes pour l'importation de code bourse a remettre apres dans le middleware
Route::post('/admin/import-code-bourse', [CodeBourseImportController::class, 'import']);
// Routes d'authentification
Route::post('/logout', [LogoutController::class, 'logout']);
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/profile', [UserProfileController::class, 'show']);
    Route::put('/profile', [UserProfileController::class, 'update']);
    Route::delete('/profile', [UserProfileController::class, 'destroy']);
});



// Inscription en 5 étapes
Route::post('/register/step1', [RegisterController::class, 'step1']);
Route::post('/register/step2', [RegisterController::class, 'step2']);
Route::post('/register/step3', [RegisterController::class, 'step3']);
Route::post('/register/step4', [RegisterController::class, 'step4']);
Route::post('/register/step5', [RegisterController::class, 'step5']);

// Connexion
Route::post('/login', [LoginController::class, 'login']);



/*
 Routes API pour la gestion des utilisateurs (Admin)
*/

Route::middleware(['auth:sanctum'])->group(function () {
    
    // Routes réservées aux administrateurs
    Route::middleware(['admin'])->group(function () {
        
        // CRUD des utilisateurs
        Route::get('/utilisateurs', [UserManagementController::class, 'index']);
        Route::get('/utilisateurs/{id}', [UserManagementController::class, 'show']);
        Route::put('/utilisateurs/{id}', [UserManagementController::class, 'update']);
        Route::delete('/utilisateurs/{id}', [UserManagementController::class, 'destroy']);
        
    });
});

// Routes d'administration (protégées)
Route::middleware(['auth:sanctum', 'admin'])->prefix('admin/videos')->group(function () {
    
    // Lister toutes les vidéos (incluant inactives) pour l'admin
    Route::get('/', [VideoManagementController::class, 'index']);
    
    // Ajouter une nouvelle vidéo
    Route::post('/', [VideoManagementController::class, 'store']);
    
    // Modifier une vidéo existante
    Route::put('/{id}', [VideoManagementController::class, 'update']);
    
    // Supprimer une vidéo
    Route::delete('/{id}', [VideoManagementController::class, 'destroy']);
    
});
/*

| Routes API pour la Chaîne TV Étudiante
*/

// Routes publiques pour les étudiants
Route::prefix('videos')->group(function () {
    
    // Voir toutes les vidéos avec filtrage par thème optionnel
    Route::get('/', [VideoController::class, 'index']);
    
    // Voir un live en cours
    Route::get('/live', [VideoController::class, 'live']);
    
    // Obtenir la liste des thèmes disponibles
    Route::get('/themes', [VideoController::class, 'getThemes']);
    
    // Voir une vidéo spécifique (incrémente les vues)
    Route::get('/{id}', [VideoController::class, 'show']);
    
});

/*
| Routes API pour le module Loisir & Tourisme
*/

// Routes publiques pour les étudiants
Route::prefix('lieux')->group(function () {
    
    // Obtenir les données de référence
    Route::get('/villes', [LieuController::class, 'getVilles']);
    Route::get('/categories', [LieuController::class, 'getCategories']);
    Route::get('/populaires', [LieuController::class, 'getPopulaires']);
    
    // Lister et rechercher les lieux
    Route::get('/', [LieuController::class, 'index']);
    
    // Voir les détails d'un lieu spécifique (incrémente les vues)
    Route::get('/{id}', [LieuController::class, 'show']);
    
});

// Routes d'administration (protégées)
Route::middleware(['auth:sanctum', 'admin'])->prefix('admin/lieux')->group(function () {
    
    // CRUD des lieux
    Route::get('/', [LieuManagementController::class, 'index']);
    Route::post('/', [LieuManagementController::class, 'store']);
    Route::put('/{id}', [LieuManagementController::class, 'update']);
    Route::delete('/{id}', [LieuManagementController::class, 'destroy']);
    
});