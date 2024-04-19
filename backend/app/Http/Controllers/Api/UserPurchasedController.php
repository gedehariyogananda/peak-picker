<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Checkout;
use App\Models\Product;
use App\Models\UserPurchased;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserPurchasedController extends Controller
{
    private $initUser;

    public function __construct()
    {
        $this->initUser = auth()->user()->id;
    }

    private static function formatPrice($price)
    {
        return 'Rp ' . number_format($price, 0, ',', '.');
    }

    public function insertKeranjang(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'product_id' => 'required',
            'start_borrow_purchased' => 'required|date_format:Y-m-d',
            'end_borrow_purchased' => 'required|date_format:Y-m-d',
        ]);

        try {
            if ($validate->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => $validate->errors(),
                ], 400);
            }

            // init product price/day
            $initProduct = Product::find($request->product_id);
            $priceProductDayInit = $initProduct->priceday_product;

            // selisih day peminjamanm 
            $startBorrowInit = DateTime::createFromFormat('Y-m-d', $request->start_borrow_purchased);
            $endBorrowInit = DateTime::createFromFormat('Y-m-d', $request->end_borrow_purchased);
            $interval = $startBorrowInit->diff($endBorrowInit);
            $resultDdayBorrows = $interval->days;

            // result harga sesuai interfal
            $resultPrice = $priceProductDayInit * $resultDdayBorrows;

            $dataPurchased = UserPurchased::create([
                'user_id' => $this->initUser,
                'product_id' => $request->product_id,
                'start_borrow_purchased' => $request->start_borrow_purchased,
                'end_borrow_purchased' => $request->end_borrow_purchased,
                'result_price_purchased' => self::formatPrice($resultPrice),
            ]);

            if ($dataPurchased) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) Berhasil menambahkan product ke keranjang',
                    'data' => $dataPurchased,
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Gagal menambahkan product ke keranjang',
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getKeranjang()
    {
        $dataset = UserPurchased::with('product')->where('user_id', $this->initUser)
            ->where('status_purchased', 'belum_submit')->get();

        $mappedData = collect([]);

        foreach ($dataset as $item) {
            $orderanSama = false;

            foreach ($mappedData as $existingOrder) {
                if ($existingOrder['product_id'] == $item->product_id && $existingOrder['start_borrow_purchased'] == $item->start_borrow_purchased && $existingOrder['end_borrow_purchased'] == $item->end_borrow_purchased) {
                    $orderanSama = true;
                    break;
                }
            }

            if (!$orderanSama) {
                $totalBarangBeli = UserPurchased::where('user_id', $this->initUser)
                    ->where('product_id', $item->product_id)
                    ->where('start_borrow_purchased', $item->start_borrow_purchased)
                    ->where('end_borrow_purchased', $item->end_borrow_purchased)
                    ->where('status_purchased', 'belum_submit')
                    ->count();

                $mappedData->push([
                    'id' => $item->id,
                    'product_id' => $item->product_id,
                    'name_product' => $item->product->name_product,
                    'image_product' => $item->product->image_product,
                    'start_borrow_purchased' => $item->start_borrow_purchased,
                    'end_borrow_purchased' => $item->end_borrow_purchased,
                    'result_price_purchased' => str_replace(['Rp ', '.'], '', $item->result_price_purchased) * $totalBarangBeli,
                    'status_purchased' => $item->status_purchased,
                    'attemp_purchased' => $item->attemp_purchased,
                    'Total barang beli' => $totalBarangBeli,
                ]);
            }
        }

        try {
            if ($dataset->count() > 0) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) get all data keranjang',
                    'data' => $mappedData,
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) tidak ada data keranjang',
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function tambahSatuBarang($id)
    {
        try {
            $keranjang = UserPurchased::where('id', $id)->first();

            $dataTambahBarang = [
                'user_id' => $keranjang->user_id,
                'product_id' => $keranjang->product_id,
                'start_borrow_purchased' => $keranjang->start_borrow_purchased,
                'end_borrow_purchased' => $keranjang->end_borrow_purchased,
                'result_price_purchased' => $keranjang->result_price_purchased,
                'status_purchased' => $keranjang->status_purchased,
                'attemp_purchased' => $keranjang->attemp_purchased,
            ];

            $dataTambahBarang = UserPurchased::create($dataTambahBarang);

            if ($dataTambahBarang) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) Berhasil menambahkan barang',
                    'data' => $dataTambahBarang,
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Gagal menambahkan barang',
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function hapusSatuBarang($id)
    {
        try {
            $keranjang = UserPurchased::where('id', $id)->first();

            $deleteData = $keranjang->delete();

            if ($deleteData) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) Berhasil menghapus barang',
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Gagal menghapus barang',
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function checkoutKeranjang()
    {
        // Ambil semua data keranjang untuk pengguna tertentu
        $keranjang = UserPurchased::where('user_id', $this->initUser)->get();

        // Inisialisasi variabel untuk menyimpan nilai checkout terbesar
        $maxCheckout = 0;

        // Temukan nilai checkout terbesar
        foreach ($keranjang as $item) {
            if ($item->checkout > $maxCheckout) {
                $maxCheckout = $item->checkout;
            }
        }

        // Tentukan nilai baru untuk checkout
        $newCheckoutValue = $maxCheckout + 1;

        // Update nilai checkout untuk semua item keranjang
        foreach ($keranjang as $item) {
            $item->where('status_purchased', 'belum_submit')->update(['status_purchased' => 'sudah_submit', 'checkout' => $newCheckoutValue]);
        }

        try {
            // Cek apakah terdapat item keranjang
            if ($keranjang->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) keranjang kosong',
                ], 404);
            } else {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) berhasil checkout product',
                ]);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function getRiwayatPembelian()
    {
        $initUser = auth()->user()->id;

        $dataset = UserPurchased::with('product')->where('user_id', $initUser)
            ->where('status_purchased', 'sudah_submit')
            ->orderBy('checkout')
            ->get();


        $riwayatPembelian = [];

        foreach ($dataset as $item) {
            $checkout = $item->checkout;

            $dataPembelian = [
                'id' => $item->id,
                'product_id' => $item->product_id,
                'name_product' => $item->product->name_product,
                'image_product' => $item->product->image_product,
                'start_borrow_purchased' => $item->start_borrow_purchased,
                'end_borrow_purchased' => $item->end_borrow_purchased,
                'result_price_purchased' => $item->result_price_purchased,
                'status_purchased' => $item->status_purchased,
                'attemp_purchased' => $item->attemp_purchased,
            ];

            if (!isset($riwayatPembelian[$checkout])) {
                $riwayatPembelian[$checkout] = [];
            }
            $riwayatPembelian[$checkout][] = $dataPembelian;
        }

        try {
            if ($dataset->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) tidak ada data riwayat pembelian',
                ], 404);
            } else {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) get all data riwayat pembelian',
                    'data' => $riwayatPembelian,
                ], 200);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    public function hapusSemuaBarang($id)
    {
        try {
            $keranjang = UserPurchased::where('user_id', $this->initUser)
                ->where('status_purchased', 'belum_submit')
                ->where('product_id', $id)
                ->delete();

            if ($keranjang) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) Berhasil menghapus semua barang',
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Gagal menghapus semua barang',
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function editAttempPurchased($valueCheckout, $idUser)
    {
        $keranjang = UserPurchased::where('user_id', $idUser)
            ->where('status_purchased', 'sudah_submit')
            ->where('checkout', $valueCheckout)
            ->update(['attemp_purchased' => 'sudah_disetujui']);

        try {
            if ($keranjang) {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) Berhasil mengubah status attemp_purchased',
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) Gagal mengubah status attemp_purchased',
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function getCheckoutTotal()
    {
        $initUser = auth()->user()->id;

        $userPurchased = UserPurchased::where('user_id', $initUser)
            ->where('status_purchased', 'belum_submit')
            ->get();

        $totalCheckout = 0;

        foreach ($userPurchased as $purchase) {
            $price = (int) preg_replace('/[^0-9]/', '', $purchase->result_price_purchased);
            $totalCheckout += $price;
        }

        try {
            return response()->json([
                'success' => true,
                'message' => '(SUCCESS) get total checkout',
                'data' => self::formatPrice($totalCheckout),
            ]);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function getRiwayatPembelianUser()
    {
        $initUser = auth()->user()->id;

        $dataset = UserPurchased::with('product')->where('user_id', $initUser)
            ->where('status_purchased', 'sudah_submit')
            ->orderBy('checkout')
            ->get();

        $mappedData = $dataset->map(function ($item) {
            return [
                'id' => $item->id,
                'product_id' => $item->product_id,
                'name_product' => $item->product->name_product,
                'image_product' => $item->product->image_product,
                'start_borrow_purchased' => $item->start_borrow_purchased,
                'end_borrow_purchased' => $item->end_borrow_purchased,
                'result_price_purchased' => $item->result_price_purchased,
                'status_purchased' => $item->status_purchased,
                'attemp_purchased' => $item->attemp_purchased,
            ];
        });

        try {
            if ($dataset->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => '(FAILED) tidak ada data riwayat pembelian',
                ], 404);
            } else {
                return response()->json([
                    'success' => true,
                    'message' => '(SUCCESS) get all data riwayat pembelian',
                    'data' => $mappedData,
                ], 200);
            }
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => '(ERROR) internal server',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
