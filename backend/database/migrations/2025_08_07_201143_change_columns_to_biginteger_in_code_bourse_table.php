<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangeColumnsToBigIntegerInCodeBourseTable extends Migration
{
    public function up(): void
    {
        Schema::table('code_bourse', function (Blueprint $table) {
            $table->bigInteger('numero_matricule')->change();
            $table->bigInteger('identifiant_commun')->change();
            $table->bigInteger('code_bourse')->change();
        });
    }

    public function down(): void
    {
        Schema::table('code_bourse', function (Blueprint $table) {
            $table->double('numero_matricule')->change();
            $table->double('identifiant_commun')->change();
            $table->double('code_bourse')->change();
        });
    }
}
