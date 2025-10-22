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
      render(
        json: {
          message: "Data could not be saved",
          error: content.errors.full_messages
        }
      )
      return
    end
  end

  def update
    temp_body = params[:body]
    temp_title = params[:title]
    temp_url = params[:url]
    id = params[:id]

    request_body = {}
    request_body[:body] = temp_body if temp_body
    request_body[:title] = temp_title if temp_title
    request_body[:url] = temp_url if temp_url

    if !id
      render(
        json: {
          message: "Empty id or body"
        },
        status: :bad_request
      )
      return
    end

    updated_record = Content.find(id)
    #.compact is used to skip nil values from hash
    updated_record.update(request_body.compact)
    if updated_record.persisted?
      render(
        json: {
          message: "Data updated successfully",
          data: updated_record
        }
      )
      return
    else
      render(
        json: {
          message: "Data could not be updated"
        },
        status: :unprocessed_entity
      )
    end
  end

  def destroy
    id = params[:id]
    if !id
      render(
        json: {
          message: "Id is empty"
        },
        status: :bad_request
      )
    end

    record = Content.delete(id)
    if record > 0
      render(
        json: {
          message: "Record deleted successfully",
          records: Content.all
        }
      )
      return
    end
  end

end
