Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/' => 'home#index'
  root 'home#index'
  # get '/lotto' => 'home#lotto'
  get '/lunch' => 'home#lunch'
  
  # 전체 회원 보기
  get '/users' => 'user#index'
  # my page
  get '/user/:id' => 'user#show'
  # 회원가입
  get '/users/new' => "user#new"
  # db에 저장하기
  post '/user/create' => 'user#create'

  
  # 샘플링한 로또 보여주기
  get '/lotto' => 'lotto#index'
  get '/lotto/new' => 'lotto#new'
  

  # 나에게 등록된 모든 질문 출력
  get '/ask' => 'ask#index'
  # 새로운 질문 작성
  get '/ask/new' => 'ask#new'
  post '/ask/create' => 'ask#create'
  get '/ask/:id/delete' => 'ask#delete'
  get '/ask/:id/edit' => 'ask#edit'
  post '/ask/:id/update' => 'ask#update'
  get '/ask/:id' => 'ask#show'
end

