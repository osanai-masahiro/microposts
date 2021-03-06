class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) # この行を追加
            render "static_pages/home"
        end
    end
    
    def retweet
        @micropost = Micropost.find_by(id: params[:id])
        @retweet = current_user.microposts.build(content: @micropost.content)
        if @retweet.save
            flash[:success] = "Micropost was retweeted!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) # この行を追加
            render "static_pages/home"
        end
    end
    
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost was deleted "
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
    
    
end

