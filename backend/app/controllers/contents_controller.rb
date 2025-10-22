class ContentsController < ApplicationController

  def index
    @content = Content.all
    render(json: @content)
  end

  def create
    body = params[:body]
    title = params[:title]
    content_type = params[:content_type]
    url = params[:url]

    if !body || !title || !content_type
      render(
        json: {
          message: "Mandatory fields were not sent"
        },
        status: :bad_request
      )
      return
    end

    content = Content.create(body: body, title: title, content_type: content_type, url: url)
    if content.persisted?
      render(
        json: {
          message: "Data created successfully"
        }
      )
      return
    else
      render json: {
          message: "Data could not be saved",
          error: content.errors.full_messages
        }
      return
    end
  end

end
