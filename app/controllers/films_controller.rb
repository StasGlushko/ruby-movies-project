class FilmsController < ApplicationController
  before_action :set_film, only: %i[ show edit update destroy ]

  # GET /films or /films.json
  def index
    @films = Film.all
  end

  # GET /films/1 or /films/1.json
  def show
    @omdb = OmdbService.new
    @omdb_film = @omdb.find_by_title(@film.name)
  end

  # GET /films/new
  def new
    @film = Film.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films or /films.json
  def create
    @film = Film.new(film_params)

    respond_to do |format|
      if @film.save
        format.html { redirect_to film_url(@film), notice: "Film was successfully created." }
        format.json { render :show, status: :created, location: @film }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /films/1 or /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to film_url(@film), notice: "Film was successfully updated." }
        format.json { render :show, status: :ok, location: @film }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1 or /films/1.json
  def destroy
    @film.destroy!

    respond_to do |format|
      format.html { redirect_to films_url, notice: "Film was successfully destroyed." }
      format.json { head :no_content }
    end
  end

# omdb
  def omdb_search
    if params[:search_query].present?
      @omdb = OmdbService.new

      # @search_results = @omdb.search(params[:search_query])['Search']
      res = @omdb.search(params[:search_query])
      @search_results = res['Search']
    end
  end

  def omdb_import
    @omdb = OmdbService.new

    @omdb_film = @omdb.find_by_id(params[:omdb_id])

    @film = Film.new(
      name: @omdb_film['Title'],
      cover_image_url: @omdb_film['Poster'],
      year_of_creation: @omdb_film['Year'],
      description: @omdb_film['Plot'],
      length: @omdb_film['Runtime'],
      director: @omdb_film['Director'],
      genres: @omdb_film['Genre'].split(', ')
    )
    if @film.save
      redirect_to @film
    else
      flash[:error] = @film.errors.full_messages.join(", ")
      render :omdb_search
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def film_params
      params.require(:film)
      .permit(:name, :description, :year_of_creation, :director, :length, :cover_image_url, genres: [])
    end


end
