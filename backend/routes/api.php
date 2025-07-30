<?php
ibrahima-diallo
use App\Http\Controllers\profil\UserProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\UserManagementController;


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/profile', [UserProfileController::class, 'show']);
    Route::put('/profile', [UserProfileController::class, 'update']);
    Route::delete('/profile', [UserProfileController::class, 'destroy']);
});



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
main
