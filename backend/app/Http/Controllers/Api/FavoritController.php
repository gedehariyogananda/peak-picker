<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\FavoritProduct;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FavoritController extends Controller
{
    public function setFavoritProductUser(Request $request)
    {
        $initUser = auth()->user()->id;
        $validates = Validator::make($request->all(), [
            'product_id' => 'required',
        ]);

        if ($validates->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validates->errors(),
            ], 400);
        }

        try {
            if (FavoritProduct::where('user_id', $initUser)->where('product_id', $request->product_id)->exists()) {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Product sudah ada di favorit',
                ], 400);
            }

            $favoritData = FavoritProduct::create([
                'user_id' => $initUser,
                'product_id' => $request->product_id,
            ]);

            if ($favoritData) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) user Berhasil menambahkan product ke favorit',
                    'data' => $favoritData,
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Product gagal ditambahkan ke favorit',
                ], 500);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getFavoritProductUser()
    {
        $initUser = auth()->user()->id;

        $initUserFavoritData = FavoritProduct::with('product')->where('user_id', $initUser)->get();

        $mappedData = $initUserFavoritData->map(function ($item) {
            return [
                'id' => $item->product->id,
                'name_product' => $item->product->name_product,
                'price/day_product' => $item->product->priceday_product,
                'image_product' => $item->product->image_product,
                'category_product' => $item->product->category_product,
                'description_product' => $item->product->description_product,
            ];
        });

        try {
            if ($initUserFavoritData->count() > 0) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) get all data favorit product by user id ',
                    'data' => $mappedData,
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) user tidak punya favorit product',
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server error',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function deleteFavoritProductUser($id)
    {
        $initUser = auth()->user()->id;

        $favoritUserData = FavoritProduct::with('product')->where('user_id', $initUser)->get();

        try {
            if ($favoritUserData->count() > 0) {
                $deleteFavoritData = $favoritUserData->where('product_id', $id)->first()->delete();

                if ($deleteFavoritData) {
                    return response()->json([
                        'success' => true,
                        'message' => '(SUCCESS) delete data favorit product by user id ',
                    ]);
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => '(FAILED) product tidak ditemukan',
                    ], 404);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) user tidak punya favorit product',
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server error',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
