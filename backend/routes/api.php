<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\UserManagementController;
use App\Http\Controllers\Api\VideoController;
use App\Http\Controllers\Api\Admin\VideoManagementController;
use App\Http\Controllers\Api\LieuController;
use App\Http\Controllers\Api\Admin\LieuManagementController;


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