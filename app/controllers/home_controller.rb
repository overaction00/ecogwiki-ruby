class HomeController < ApplicationController
  def index

  end

  def show
    # [] = generalize_url

    # page = last index []
    if params[:view] == 'edit'
      @wikipage = Wikipage.find_by_title(params[:wikipage])
      render 'home/update'
    end
    # view=edit render view
    # render edit page if page exist

    # show
    # else render empty page
  end
end
