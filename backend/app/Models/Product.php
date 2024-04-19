<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'price',
        'stock',
        'category',
        'description',
        'image',
        'created_at',
        'updated_at',
    ];

    public function userPurchased()
    {
        return $this->hasMany(UserPurchased::class, 'product_id', 'id');
    }
}
