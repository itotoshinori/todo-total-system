<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\Task;
use App\Models\User;

class TaskTest extends TestCase
{
    use RefreshDatabase;
    private $chars;

    public function setUp(): void
    {
        parent::setUp();
        $user = User::factory()->create();
        $this->actingAs($user);
    }

    // コンストラクタ
    public function __construct(?string $name = null, array $data = [], string $dataName = '')
    {
        parent::__construct($name, $data, $dataName);
        $this->chars = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_/*+.,!#$%&()~|';
    }

    /**
     * @test
     */
    public function 一覧表示()
    {
        $tasks = Task::factory()->count(10)->create();
        $response = $this->getJson('api/tasks');
        $response->assertOk()
            ->assertJsonCount($tasks->count());
    }

    /**
     * @test
     */
    public function 登録できる()
    {
        $data = ['title' => 'テストデータ', 'user_id' => 1];
        $response = $this->postJson('api/tasks', $data);
        $response
            ->assertOk()
            ->assertJsonFragment($data);
    }
    /**
     * @test
     */
    public function 更新できる()
    {
        $task = Task::factory()->create();
        $task->title = "更新";
        $data = $task->toArray();
        $response = $this->put("api/tasks/{$task->id}", $data);
        $response
            ->assertOk()
            ->assertJsonFragment($data);
    }
    /**
     * @test
     */
    public function タイトルがブランク時の更新に失敗することを確認する()
    {
        $data = ['title' => '', 'user_id' => 1];
        $response = $this->put('api/tasks', $data);
        $response->assertStatus(405);
    }
    /**
     * @test
     */
    public function タイトルが10文字以上の時、更新に失敗することを確認する()
    {
        $random_num = substr(str_shuffle(str_repeat($this->chars, 11)), 0, 11);
        $data = ['title' => $random_num, 'user_id' => 1];
        $response = $this->postJson('api/tasks', $data);
        $response->assertStatus(422);
    }
    /**
     *  @test
     */
    public function 削除を確認できる()
    {
        // タスクを10個作成
        $tasks = Task::factory()->count(10)->create();

        // 削除対象のタスクを選択
        $taskToDelete = $tasks->first();

        // 対象のタスクを削除
        $response = $this->deleteJson("api/tasks/{$taskToDelete->id}");
        $response->assertOk();
        // 削除されたタスクが含まれていないことを確認
        $this->assertDatabaseMissing('tasks', ['id' => $taskToDelete->id]);
    }
}
