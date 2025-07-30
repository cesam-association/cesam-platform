<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\LogoutController;
use App\Http\Controllers\profil\UserProfileController;

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