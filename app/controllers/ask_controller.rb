class AskController < ApplicationController
    def index
        @questions = Ask.all
    end
    
    def create
       # qes =  params[:question]
        a1 = Ask.new
        a1.question = params[:question]
        a1.ip_address = request.ip
        a1.region = request.location.region
        a1.save
        redirect_to "/ask"
    end
    
    def new
        # 서버 로그에 사용자 요청 정보가 찍힘
        # p request.location.region
        
    end
    
    def delete
        ask = Ask.find(params[:id])
        ask.destroy
        redirect_to "/ask"
    end
    
    # show하고 비슷함
    def edit
        @ask = Ask.find(params[:id])
    end
    
    def update
        ask = Ask.find(params[:id])
        ask.question = params[:question]
        ask.save
        redirect_to '/ask'
    end
    
    def show
        @ask2 = Ask.find(params[:id])
    end
    
end
