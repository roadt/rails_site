class Mercury::ImagesController < MercuryController

  respond_to :json

  def index
    @images = Mercury::Image.all

    respond_with @images
  end

  def new
  end

  # POST /images.json
  def create
    image = params[:image]
    logger.info image
    @image = Mercury::Image.new(:image=>image)
    @image.save
    respond_with @image
  end

  # DELETE /images/1.json
  def destroy
    @image = Mercury::Image.find(params[:id])
    @image.destroy
    respond_with @image
  end

end
