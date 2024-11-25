<?php

namespace Database\Seeders;

use DateTime;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'name' => '伊藤利典',
            'email'     => 'tito40358@gmail.com',
            'password'  => Hash::make('okuwa3358'),
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);
    }
}
