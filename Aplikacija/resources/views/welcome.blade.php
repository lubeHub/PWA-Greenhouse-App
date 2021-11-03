<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="apple-mobile-web-app-title" content="DC-Covers">
<meta name="msapplication-TileImage" content="link to the image in static folder">
<meta name="msapplication-TileColor" content="#000">
<meta name="theme-color" content="#4285f4">
<link rel="apple-touch-icon" href="link to the smaller icon">   
 <link rel="manifest" href="{{ asset('manifest.json') }}">
        <title>Diplomski rad Ognjen Lubarda</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <script src="{{asset('js/app.js')}}" defer></script>
        <link rel="stylesheet" href="{{asset('css/app.css')}}">                                                                                                  
    </head>
    <body >
      <div id="app">
          <navigation></navigation>
      </div>
    </body>
</html>
