<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserPurchased extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'product_id',
        'start_borrow_purchased',
        'end_borrow_purchased',
        'result_price_purchased',
        'status_purchased',
        'attemp_purchased',
        'created_at',
        'updated_at',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }
}
