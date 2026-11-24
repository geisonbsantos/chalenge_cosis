<?php

namespace App\Http\Controllers;

use App\Http\Requests\UserFormRequest;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(Request $request)
    {
        return User::all();
    }

    public function store(UserFormRequest $request)
    {
        $request->validated();

        $user = User::create($request->only('name', 'email', 'password'));

        return response()->json($user, 201);
    }
}
