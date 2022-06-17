{{template "home/common/header.tpl" .}}
<main>
    <ul>
        <li class="box">
            <div class="li-top">
                <h2>{{.detail.Title}}</h2>
                <h3>{{convertTime .detail.Addtime}}</h3>
            </div>
            <div class="li-bottom">
                <div class="li-bottom-col">
                    <i></i>{{.detail.TagName}}
                </div>
                <div class="li-bottom-col">
                    <i></i>{{.detail.Click}}
                </div>
            </div>
        </li>
    </ul>
    <div class="content" id="editormd-view">
        {{str2html .detail.Content}}
    </div>

    <div class="footer">
        <h2>发表评论</h2>
        <form action="" id="remark">
            {{ .xsrfdata }}
            <input type="hidden" name="logId" value="{{.detail.LogId}}">
            <div class="row">
                <div class="col">
                    <label for="name">姓名</label>
                    <input type="text" name="name" id="name" placeholder="" />
                </div>
                <div class="col">
                    <label for="email">邮箱</label>
                    <input type="text" name="email" id="email" />
                </div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <textarea class="input" id="saytext" name="content"></textarea>
                <p>
                    <button id="toRemark">评论</button>
                    <span class="emotion">表情</span>
                </p>
                <div id="show">Please comment if you have any question or guide<img src="/static/home/js/images/1.gif" border="0"></div>
            </div>
        </form>

    </div>

    {{template "home/common/footer.tpl" .}}
</main>
<script src="/static/home/js/font.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>
<script src="/static/home/js/jquery.qqFace.js"></script>
<script type="text/javascript">

    $(function () {

        $('.emotion').qqFace({

            id: 'facebox',

            assign: 'saytext',

            path: '/static/home/js/images/'	//表情存放的路径

        });

        $('#saytext').on('change keydown keyup input', function (event) {

            update_show();

        });


    });

    // 评论显示同步

    function update_show() {
        var str = $("#saytext").val();

        $("#show").html(replace_em(str));
    }

    //查看结果

    function replace_em(str) {

        str = str.replace(/\</g, '&lt;');

        str = str.replace(/\>/g, '&gt;');

        str = str.replace(/\n/g, '<br/>');

        str = str.replace(/\[em_([0-9]*)\]/g, '<img src="/static/home/js/images/$1.gif" border="0" />');

        return str;

    }

</script>
<script>

    $(function () {
        $('#toRemark').on('click', function () {
            var check = true;
            var name = $('#name'), email = $('#email'), saytext = $('#saytext');
            if (name.val() == '') {
                check = false;
                name.css('border-color', 'red');
                name.attr('placeholder', '请填写姓名');
            }
            if (email.val() == '') {
                check = false;
                email.css('border-color', 'red');
                email.attr('placeholder', '请填写邮箱');
            }
            var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
            if (!reg.test(email.val())) {
                check = false;
                email.css('border-color', 'red');
                email.val('');
                email.attr('placeholder', '邮箱格式错误');
            }
            if (saytext.val() == '') {
                check = false;
                saytext.css('border-color', 'red');
                saytext.attr('placeholder', '请输入评论');
            }
            if (check) {
                $.ajax({
                    url: {{urlfor "IndexController.Remark"}},
                    type: 'post',
                    dataType: 'json',
                    data: $('#remark').serialize(),
                    success: function (result) {
                        alert(result.msg);
                        if (result.state) {
                            name.val('');
                            email.val('');
                            saytext.val('');
                            email.attr('placeholder', '');
                        }
                    }
                });
            }
            return false;
        })
    })
</script>
</body>

</html>