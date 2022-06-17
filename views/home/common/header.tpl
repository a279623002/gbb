<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>懒得去想名</title>
    <link rel="stylesheet" href="/static/home/css/public.css">
    {{if eq .system.Logo 2}}
        <link rel="stylesheet" href="/static/home/css/logo.css">
    {{end}}
    {{if eq .system.Theme 2}}
        <link rel="stylesheet" href="/static/home/css/theme1.css">
    {{else if eq .system.Theme 3}}
        <link rel="stylesheet" href="/static/home/css/theme2.css">
    {{else if eq .system.Theme 4}}
        <link rel="stylesheet" href="/static/home/css/theme3.css">
    {{end}}
    <style>
        header {
            background: url(/{{.system.Banner}}) no-repeat center center;
            background-size: cover;
        }

        /*
        @media screen and (max-width: 1200px) {
            header {
                background: url(/{{.system.Banner}}) no-repeat fixed;
                background-size: 100% auto;
            }
        }
        */
        

    </style>
    <script src="/static/home/js/font.js"></script>
    <script src="/static/home/js/jquery.js"></script>
</head>

<body>
    <header>
        <img src="/{{.system.Headimg}}" alt="">
        <a href="/" class="top">{{.system.Name}}</a>
        <p>{{.system.Tip}}</p>
        <div class="link">
            <a href="{{.system.Git}}" target="_blank"></a>
            <a href="{{.system.Sina}}" target="_blank"></a>
            <a href="mailto:{{.system.QQ}}"></a>
        </div>
    </header>