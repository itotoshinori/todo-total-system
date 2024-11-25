<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreTaskRequest;
use App\Http\Requests\UpdateTaskRequest;
use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $tasks = Task::where('user_id', Auth::user()->id)->get();
        return response()->json($tasks);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreTaskRequest $request)
    {
        $request->merge(['user_id' => 1]);
        $request->merge(['user_id' => Auth::user()->id]);
        $task = Task::create($request->all());
        return $task ? response()->json($task) : response()->json([], 500);
    }

    /**
     * Display the specified resource.
     */
    public function show(Task $task)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateTaskRequest $request, Task $task)
    {
        $request->merge(['user_id' => 1]);
        return $task->update($request->all())
            ? response()->json($task)
            : response()->json([], 500);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Task $task)
    {
        return $task->delete()
            ? response()->json($task)
            : response()->json([], 500);
    }
    /**
     * Update the specified resource in storage.
     */
    public function updateDone(Task $task, Request $request)
    {
        $task->is_done = $request['is_done'];
        return $task->update() ? response()->json($task) : response()->json([], 500);
    }
}
