<?php

namespace Database\Seeders;

use App\Models\Task;
use DateTime;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TaskSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Task::create([
            'id' => 1,
            'user_id' => 1,
            'title' => '飯食う',
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);

        Task::create([
            'id' => 2,
            'user_id' => 1,
            'title' => '寝る',
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);

        Task::create([
            'id' => 3,
            'user_id' => 1,
            'title' => '走る',
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);

        Task::create([
            'id' => 4,
            'user_id' => 1,
            'title' => '歩く',
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);

        Task::create([
            'id' => 5,
            'user_id' => 1,
            'title' => '風呂に入る',
            'created_at' => new DateTime(),
            'updated_at' => new DateTime()
        ]);
    }
}
