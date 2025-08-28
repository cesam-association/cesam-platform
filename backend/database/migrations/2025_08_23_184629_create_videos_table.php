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
        Schema::create('videos', function (Blueprint $table) {
            $table->id();
            $table->string('titre');
            $table->text('description')->nullable();
            $table->string('url'); // URL vers la vidéo (YouTube, Vimeo, ou fichier local)
            $table->string('miniature')->nullable(); // Image de couverture
            $table->string('theme')->nullable(); // orientation, témoignages, événements, etc.
            $table->boolean('is_live')->default(false); // Pour distinguer les lives
            $table->boolean('is_active')->default(true); // Pour activer/désactiver
            $table->integer('duree')->nullable(); // Durée en secondes
            $table->integer('vues')->default(0); // Nombre de vues
            $table->datetime('date_publication');
            $table->foreignId('auteur_id')->constrained('users')->onDelete('cascade'); // Admin qui a ajouté
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('videos');
    }
};