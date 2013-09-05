module Ueditor

  class AttachmentsController < ApplicationController


    #  Parameters: {"Filename"=>"scrapybot_log_snippit.log", 
    # "PHPSESSID"=>"<?php echo session_id(); ?>", 
    #"upfile"=>#<ActionDispatch::Http::UploadedFile:0x00000006cdd790 @original_filename="scrapybot_log_snippit.log", @content_type="application/octet-stream", @headers="Content-Disposition: form-data; name=\"upfile\"; filename=\"scrapybot_log_snippit.log\"\r\nContent-Type: application/octet-stream\r\n", @tempfile=#<Tempfile:/tmp/RackMultipart20130901-19591-qfwtla>>, 
    #"Upload"=>"Submit Query"}

    def create
      @attachment = Attachment.new(:data => params[:upfile])
      if @attachment.save
        render :json=> { 'url'=> @attachment.data.url, :original=> @attachment.data.original_filename,  :state => 'SUCCESS' } 
      else
        render :json=> { :state=>"FAILURE"}
      end
    end
    
  end
end
