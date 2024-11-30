<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>タスク管理システム</title>
    @viteReactRefresh
    @vite('resources/ts/index.tsx')
    @vite('resources/css/app.css')
    @vite('resources/sass/app.scss')
</head>

<body>
    <div id="root"></div>
</body>

</html>