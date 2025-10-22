class ContentsController < ApplicationController

  def index
    @content = Content.all
    render(json: @content)
  end

end
