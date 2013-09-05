
module Ueditor

  class ImagesController < ApplicationController
    respond_to :json
    
    #
    # return array of images 
    # (json form is a json array)
    #
    def index
      @images = Image.all
      respond_with @images
    end

    #
    #  manage is similar to index action, but following ueditor's default response fomra.t
    #  thus weired:  "ue_separate_ue" separated  image urls..
    #
    def manage
      @images = Image.all
      render :text=> @images.map{|image|image.data.url}.join("ue_separate_ue")
    end


    #
    # a page let user to upload file outside ueditor dialog
    #
    def new 
      @image = Image.new
    end


    #
    #  create image.  this follows RESTful form rails engage.
    #
    #
    def create
      image_params  = params[:ueditor_image] || {}
      self._create(image_params[:data], image_params[:title])
      #  input:    { fileName:'', Filename:'', pictitle: '',  dir:'', 'file_file_name':'', upfile:'', Upload:submit_button_value, otherparam123:xx}
      #  output:  { url:'', title:'', original:'', state:'SUCCESS'}
    end

    # 
    # this action similar to create, but accept ueditor 's default parameters.
    #
    def upload
      self._create params[:upfile], params[:pictitle]
    end

    
    def _create upfile, title
      @image = Image.new(:data => upfile, :title=> title)
      if @image.save
        render :json  => { 
          url: @image.data.url,
          title: @image.title,
          original: @image.data.original_filename,
          state: 'SUCCESS'}
      else
        render :json => {
          state: 'FAILURE'
        }
      end    
    end


    def destroy
      @image = Image.find(params[:id])
      @image.destroy! if @image
    end

  end

end

=begin
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="fileName"

       qq0081.jpg
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="param2"

       value2
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="pictitle"

       qq0081.jpg
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="Filename"

       qq0081.jpg
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="dir"

       1
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="param1"

       value1
       --txooinnhftradvxdnwaivhbiqbulsodh
       Content-Disposition: form-data; name="image"; filename="qq0081.jpg"
       Content-Type: application/octet-stream
       --txooinnhftradvxdnwaivhbiqbulsodh


       Content-Disposition: form-data; name="Upload"

       Submit Query
       --txooinnhftradvxdnwaivhbiqbulsodh--
         =end



       {"dir":"1","fileName":"qq0056.jpg","param2":"value2","pictitle":"qq0056.jpg","Filename":"qq0056.jpg","param1":"value1","image":{"original_filename":"qq0056.jpg","content_type":"application/octet-stream","headers":"Content-Disposition: form-data; name=\"image\"; filename=\"qq0056.jpg\"\r\nContent-Type: application/octet-stream\r\n","tempfile":[xxx
                                                                                                                                                                                                                                                                                                                                                               ]},"Upload":"Submit Query","action":"create","controller":"ueditor/images","format":"json"}

=end


