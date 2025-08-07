<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCodeBourseTable extends Migration
{
    public function up(): void
    {
        Schema::create('code_bourse', function (Blueprint $table) {
            $table->id();

            // Clé étrangère nullable vers la table users
            $table->foreignId('user_id')
                  ->nullable()
                  ->constrained('users')
                  ->onDelete('set null');

            $table->string('pays');
            $table->double('numero_matricule');
            $table->string('nom');
            $table->string('prenom');
            $table->string('numero_passport');
            $table->double('identifiant_commun');
            $table->double('code_bourse');

            $table->timestamps(); // created_at et updated_at
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('code_bourse');
    }
}
