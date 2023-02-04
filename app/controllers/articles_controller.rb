class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new #投稿フォームをviewに返すアクション
    @article = Article.new
  end

  def create #投稿を新規作成するアクション
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  #newアクションで作成フォームをviewに表示し、フォームに入力された情報がcreateアクションに送られてDBに加えられる


  def edit #DBから投稿を取得して@articleに保存し、フォームを作成するときに使えるようにする = 以前投稿した内容そのままフォーム内に再現し、edit(編集)できる状態にする
    @article = Article.find(params[:id])
  end

  def update #DBから記事を再取得し、article_paramsでフィルタリングされた送信済みのフォームデータでupdate(更新)する
    #更新に失敗したらeditをレンダリングする
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  #editアクションでフォームを再現し編集画面(フォームとその内容)をviewに表示させ、updateアクションで再取得しパラメーターの内容をupdate(更新)する

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
