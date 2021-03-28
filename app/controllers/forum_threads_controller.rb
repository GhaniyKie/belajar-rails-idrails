class ForumThreadsController < ApplicationController
    # Untuk memproteksi URL ForumThread dari User yang belum Login
    before_action :authenticate_user!, only: [:new, :create] # Method bawaan Devise

    def index
        # Menjadikan yang paling baru diatas menggunakan :asc
        # paginate menggunakan 2 paramater: jumlah per halaman, nomor halaman
        if params[:search]
            @threads = ForumThread.where('title ilike ?', "%#{params[:search]}%").paginate(per_page: 5, page: params[:page])
        else
            @threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
        end
    end

    def show
        # @thread = ForumThread.find(params[:id])
        @thread = ForumThread.friendly.find(params[:id]) # Karena menggunakan FriendlyID
        @post = ForumPost.new # Agar tidak terjadi error pada Show di Forum Thread
    end

    def new
        @thread = ForumThread.new
    end

    def create
        @thread = ForumThread.new(resource_params)
        @thread.user = current_user

        if @thread.save
            redirect_to root_path #Definisi Root Path di file routes.rb
        else
            render 'new'

        end
    end

    def edit
        @thread = ForumThread.friendly.find(params[:id])
        authorize @thread
    end

    def update
        @thread = ForumThread.friendly.find(params[:id])
        authorize @thread

        if @thread.update(resource_params)
            redirect_to forum_thread_path(@thread)
        else
            render 'new'

        end
    end

    def destroy
        @thread = ForumThread.friendly.find(params[:id])
        authorize @thread

        @thread.destroy
        redirect_to root_path, notice: 'Thread Sudah Dihapus!'
    end

    def pin_it
        @thread = ForumThread.friendly.find(params[:id])
        @thread.pin_it!
        redirect_to root_path
    end

    private
    
    # Nilai whitelist yang diperoleh dari Form
    def resource_params
        params.require(:forum_thread).permit(:title, :content)
    end
end