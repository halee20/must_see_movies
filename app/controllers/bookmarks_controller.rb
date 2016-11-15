class BookmarksController < ApplicationController
  before_action :signed_in_user_must_be_owner, :only => [:edit, :update, :destroy]

  def signed_in_user_must_be_owner
    @bookmark = Bookmark.find(params[:id])

    if bookmark.user_id != current_user.id
      redirect_to "/", :notice => "You are not authorized for that."
    end
  end


  def index
    @bookmarks = Bookmark.where(:user_id => current_user_id)

    render("bookmarks/index.html.erb")
  end

  def show
    @bookmark = Bookmark.find(params[:id])

    render("bookmarks/show.html.erb")
  end

  def new
    @bookmark = Bookmark.new

    render("bookmarks/new.html.erb")
  end

  def create
    @bookmark = Bookmark.new

    @bookmark.movie_id = params[:movie_id]
    @bookmark.user_id = params[:user_id]
    @bookmark.watched = params[:watched]

    save_status = @bookmark.save

    if save_status == true
      redirect_to(:back, :notice => "Bookmark created successfully.")
    else
      render("bookmarks/new.html.erb")
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])

    if current_user.id !=@bookmark.user_id
      redirect_to("/", :notice => "Nice try, sucker")
    else
      render("bookmarks/edit.html.erb")
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    @bookmark.movie_id = params[:movie_id]
    @bookmark.user_id = params[:user_id]
    @bookmark.watched = params[:watched]

    save_status = @bookmark.save

    if save_status == true
      redirect_to(:back, :notice => "Bookmark updated successfully.")
    else
      render("bookmarks/edit.html.erb")
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    @bookmark.destroy

    if URI(request.referer).path == "/bookmarks/#{@bookmark.id}"
      redirect_to("/", :notice => "Bookmark deleted.")
    else
      redirect_to(:back, :notice => "Bookmark deleted.")
    end
  end
end
