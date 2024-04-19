<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Campain;
use App\Models\HistoryCampain;
use App\Models\Product;
use App\Models\ReqCamp;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'name_user' => 'Gede Hari Yoga Nanda',
            'roles' => 'admin',
            'email_user' => 'gede@gmail.com',
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name_user' => 'Handaru Dwiking',
            'roles' => 'user',
            'email_user' => 'handaru@gmail.com',
            'password' => Hash::make('password'),
        ]);

        // tenda kapasitas 2
        Product::create([
            'name_product' => 'Tenda Kapasitas 2',
            'priceday_product' => '50000',
            'image_product' => 'https://example.com/tenda-kapasitas-2.jpg',
            'category_product' => 'Tenda',
            'description_product' => 'Tenda ini sangat cocok dengan kapasitas 2 orang',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // tenda kapasitas 4
        Product::create([
            'name_product' => 'Tenda Kapasitas 4',
            'priceday_product' => '75000',
            'image_product' => 'https://example.com/tenda-kapasitas-4.jpg',
            'category_product' => 'Tenda',
            'description_product' => 'Tenda ini sangat cocok dengan kapasitas 4 orang',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // tenda kapasitas 8
        Product::create([
            'name_product' => 'Tenda Kapasitas 8',
            'priceday_product' => '100000',
            'image_product' => 'https://example.com/tenda-kapasitas-8.jpg',
            'category_product' => 'Tenda',
            'description_product' => 'Tenda ini sangat cocok dengan kapasitas 8 orang',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // tas carrier
        Product::create([
            'name_product' => 'Tas Carrier',
            'priceday_product' => '40000',
            'image_product' => 'https://example.com/tas-carrier.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Tas ini sangat cocok untuk membawa barang saat hiking',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // tas daypack
        Product::create([
            'name_product' => 'Tas Daypack',
            'priceday_product' => '30000',
            'image_product' => 'https://example.com/tas-daypack.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Tas ini sangat cocok untuk kegiatan sehari-hari',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // rain cover
        Product::create([
            'name_product' => 'Rain Cover',
            'priceday_product' => '10000',
            'image_product' => 'https://example.com/rain-cover.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Rain cover ini melindungi tas dari hujan',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // sleeping bag
        Product::create([
            'name_product' => 'Sleeping Bag',
            'priceday_product' => '20000',
            'image_product' => 'https://example.com/sleeping-bag.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Sleeping bag ini nyaman digunakan saat tidur di alam bebas',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // matras
        Product::create([
            'name_product' => 'Matras',
            'priceday_product' => '15000',
            'image_product' => 'https://example.com/matras.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Matras ini memberikan kenyamanan saat tidur di alam bebas',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // kompor
        Product::create([
            'name_product' => 'Kompor',
            'priceday_product' => '25000',
            'image_product' => 'https://example.com/kompor.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Kompor ini digunakan untuk memasak di alam bebas',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // gas portable
        Product::create([
            'name_product' => 'Gas Portable',
            'priceday_product' => '20000',
            'image_product' => 'https://example.com/gas-portable.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Gas portable ini digunakan sebagai bahan bakar kompor',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // flysheet
        Product::create([
            'name_product' => 'Flysheet',
            'priceday_product' => '10000',
            'image_product' => 'https://example.com/flysheet.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Flysheet ini melindungi tenda dari hujan dan angin',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // hammock
        Product::create([
            'name_product' => 'Hammock',
            'priceday_product' => '30000',
            'image_product' => 'https://example.com/hammock.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Hammock ini nyaman digunakan saat beristirahat di alam bebas',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // nesting
        Product::create([
            'name_product' => 'Nesting',
            'priceday_product' => '15000',
            'image_product' => 'https://example.com/nesting.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Nesting ini digunakan untuk menyimpan peralatan makan',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // tracking pole
        Product::create([
            'name_product' => 'Tracking Pole',
            'priceday_product' => '20000',
            'image_product' => 'https://example.com/tracking-pole.jpg',
            'category_product' => 'Perlengkapan Hiking',
            'description_product' => 'Tracking pole ini membantu saat hiking di medan sulit',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // lampu tenda
        Product::create([
            'name_product' => 'Lampu Tenda',
            'priceday_product' => '10000',
            'image_product' => 'https://example.com/lampu-tenda.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Lampu tenda ini memberikan penerangan saat di dalam tenda',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // head lamp
        Product::create([
            'name_product' => 'Head Lamp',
            'priceday_product' => '15000',
            'image_product' => 'https://example.com/head-lamp.jpg',
            'category_product' => 'Alat camping',
            'description_product' => 'Head lamp ini memberikan penerangan saat hiking di malam hari',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // sepatu hiking
        Product::create([
            'name_product' => 'Sepatu Hiking',
            'priceday_product' => '50000',
            'image_product' => 'https://example.com/sepatu-hiking.jpg',
            'category_product' => 'Lainnya',
            'description_product' => 'Sepatu hiking ini nyaman digunakan saat hiking',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // topi
        Product::create([
            'name_product' => 'Topi',
            'priceday_product' => '10000',
            'image_product' => 'https://example.com/topi.jpg',
            'category_product' => 'Lainnya',
            'description_product' => 'Topi ini melindungi kepala dari sinar matahari',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // bendera
        Product::create([
            'name_product' => 'Bendera',
            'priceday_product' => '5000',
            'image_product' => 'https://example.com/bendera.jpg',
            'category_product' => 'Lainnya',
            'description_product' => 'Bendera ini digunakan untuk menandai lokasi',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // kamera
        Product::create([
            'name_product' => 'Kamera',
            'priceday_product' => '100000',
            'image_product' => 'https://example.com/kamera.jpg',
            'category_product' => 'Lainnya',
            'description_product' => 'Kamera ini digunakan untuk mengabadikan momen saat hiking',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);

        // Sound
        Product::create([
            'name_product' => 'Sound',
            'priceday_product' => '50000',
            'image_product' => 'https://example.com/sound.jpg',
            'category_product' => 'Lainnya',
            'description_product' => 'Sound ini digunakan untuk mendengarkan musik saat hiking',
            'condition_product' => 'Baru tidak pernah dipakai',
        ]);
    }
}
