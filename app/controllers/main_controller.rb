class MainController < ApplicationController
  def index
    @message.image.attach(io: File.open('/path/to/file'), filename: 'file.pdf')

  end
end
