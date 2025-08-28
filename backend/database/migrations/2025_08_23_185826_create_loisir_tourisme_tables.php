<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Table des villes
        Schema::create('villes', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('region')->nullable();
            $table->timestamps();
        });

        // Table des catégories de lieux
        Schema::create('categories_lieux', function (Blueprint $table) {
            $table->id();
            $table->string('nom'); // musée, parc, plage, restaurant, etc.
            $table->text('description')->nullable();
            $table->string('icon')->nullable(); // pour l'interface
            $table->timestamps();
        });

        // Table principale des lieux
        Schema::create('lieux', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->text('description');
            $table->text('adresse')->nullable();
            $table->foreignId('ville_id')->constrained('villes')->onDelete('cascade');
            $table->foreignId('categorie_id')->constrained('categories_lieux')->onDelete('cascade');
            $table->string('carte_url')->nullable(); // Lien Google Maps
            $table->text('horaires')->nullable(); // Horaires d'ouverture
            $table->decimal('latitude', 10, 8)->nullable(); // Coordonnées GPS
            $table->decimal('longitude', 11, 8)->nullable();
            $table->string('telephone')->nullable();
            $table->string('email')->nullable();
            $table->string('site_web')->nullable();
            $table->decimal('prix_moyen', 8, 2)->nullable(); // Prix moyen d'entrée
            $table->boolean('is_active')->default(true);
            $table->integer('vues')->default(0); // Nombre de consultations
            $table->datetime('date_publication');
            $table->foreignId('auteur_id')->constrained('users')->onDelete('cascade');
            $table->timestamps();
        });

        // Table des photos des lieux
        Schema::create('photos_lieux', function (Blueprint $table) {
            $table->id();
            $table->foreignId('lieu_id')->constrained('lieux')->onDelete('cascade');
            $table->string('url'); // Chemin vers la photo
            $table->string('legende')->nullable();
            $table->boolean('is_principale')->default(false); // Photo principale
            $table->integer('ordre')->default(0); // Ordre d'affichage
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('photos_lieux');
        Schema::dropIfExists('lieux');
        Schema::dropIfExists('categories_lieux');
        Schema::dropIfExists('villes');
    }
};