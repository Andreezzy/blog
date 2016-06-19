class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]
	#GET /articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /article/new
	def new
		@article = Article.new
		@categories = Category.all
	end

	def edit
	end

	#POST /articles
	def create
		#@article = Article.new(title: params[:article][:title], body: params[:article][:body])
		#@article = Article.new(article_params)
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	#DELETE /articles/:id
	def destroy
		#DELETE FROM articles
		@article.destroy # Destroy eliminar el objeto de la DB
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edir
		end
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body)
	end
end
