{{template "home/common/header.tpl" .}}
<main>
    <ul>
     
        {{range $index, $elem := .List}}
        <li class="box" onclick="window.location.href={{urlfor "IndexController.Log" "logId" $elem.LogId}}">
            <div class="li-top">
                <h2>{{$elem.Title}}</h2>
                <h3>{{convertTime $elem.Addtime}}</h3>
            </div>
            <div class="li-content">
              {{str2html $elem.Content}}
            </div>
            <div class="li-bottom">
                <div class="li-bottom-col">
                    <i></i>{{$elem.TagName}}
                </div>
                <div class="li-bottom-col">
                    <i></i>{{$elem.Click}}
                </div>
            </div>
        </li>
        {{end}}
   
        <div class="page">
             {{.pagerhtml}}
        </div>
    </ul>
   {{template "home/common/footer.tpl" .}}
</main>

</body>

</html>