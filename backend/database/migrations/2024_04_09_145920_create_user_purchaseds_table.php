<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_purchaseds', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('product_id')->constrained('products')->cascadeOnDelete();
            $table->date('start_borrow_purchased');
            $table->date('end_borrow_purchased');
            $table->string('result_price_purchased')->nullable();
            $table->enum('status_purchased', ['belum_submit', 'sudah_submit'])->default('belum_submit');
            $table->enum('attemp_purchased', ['belum_disetujui', 'sudah_disetujui'])->default('belum_disetujui');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_purchaseds');
    }
};
