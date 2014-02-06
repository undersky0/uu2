class PicturesController < ApplicationController
  def index
    
    @album = Album.find(params[:album_id])
    @pictures = Picture.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
    
  end

  def show
    @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  def new
    @album = Album.find(params[:gallery_id])
    @picture = @album.pictures.build
    #@picture = Picture.new(:album_id => params[:album_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  def create
    #@picture = Picture.create(params[:picture])
    p_attr = params[:picture]
    p_attr[:image] = params[:picture][:image].first if params[:picture][:image].class == Array

    if params[:album_id]
      @album = Album.find(params[:album_id])
      @picture = @album.pictures.build(p_attr)
    else
      @picture = Picture.new(p_attr)
    end

    if @picture.save
      respond_to do |format|
        format.html {
          render :json => [@picture.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
    
  end

  def edit
    @album = Album.find(params[:gallery_id])

    @picture = @album.pictures.find(params[:id])
    # @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      redirect_to @picture, :notice  => "Successfully updated picture."
    else
      render :action => 'edit'
    end
  end

  def destroy
    
    @album = Album.find(params[:album_id])
    @picture = @album.pictures.find(params[:id])
    #@picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_url, :notice => "Successfully destroyed picture."
  end
  
  def make_default
    @picture = Picture.find(params[:id])
    @album = Album.find(params[:album_id])

    @album.cover = @picture.id
    @album.save

    respond_to do |format|
      format.js
    end
  end
end
