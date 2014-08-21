class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :validate_blog_id, only: [:show, :edit, :update, :destroy]

  # GET /blog/1/entries/1
  # GET /blog/1/entries/1.json
  def show
  end

  # GET /blog/1/entries/new
  def new
    @entry = Entry.new(blog_id: params[:blog_id])
  end

  # GET /blog/1/entries/1/edit
  def edit
  end

  # POST /blog/1/entries
  # POST /blog/1/entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to blog_entry_path(@entry.blog_id, @entry), notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: blog_entry_path(@entry.blog_id, @entry) }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/1/entries/1
  # PATCH/PUT /blog/1/entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to blog_entry_path(@entry.blog_id, @entry), notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: blog_entry_path(@entry.blog_id, @entry) }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/1/entries/1
  # DELETE /blog/1/entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to blog_url(@entry.blog_id), notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def validate_blog_id
      redirect_to blogs_url, alert: 'Wrong url.' if @entry.blog_id.to_s != params[:blog_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:blog_id, :title, :body)
    end
end
