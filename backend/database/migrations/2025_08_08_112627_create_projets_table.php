<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('projets', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')
                ->constrained('users')
                ->onDelete('cascade');
            $table->string('titre');
            $table->text('description');
            $table->string('fichier')->nullable();
            $table->date('annee')->nullable();
            $table->string('type')->nullable(); // On garde en string pour ajouter le check après
            $table->float('note_obtenue')->nullable();
            $table->boolean('valide')->default(false);
            $table->timestamps();
            $table->softDeletes();
        });

        // Ajout de la contrainte CHECK pour PostgreSQL
        DB::statement("ALTER TABLE projets ADD CONSTRAINT type_check CHECK (type IN ('PFE', 'PFA'))");
    }

    public function down(): void
    {
        Schema::dropIfExists('projets');
    }
};
