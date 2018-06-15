## Day07 - CRUD와 Bootstrap



#### 간단과제. QnA 게시판 만들기 

- ask 모델과 ask_controller를 만든다.

> ask 모델의 column
>
> - ip_address
> - region
> - question

- `/ask` : 나에게 등록된 모든 질문을 출력
- `/ask/new` : 새로운 질문을 작성하는 곳

> 모델 만들기 -> route 설정 -> controller 작성 -> view 파일 만들기



`$ rails g controller ask`

`$ rails g model ask`

1. *db/migrate/2018061503.... .rb*

```ruby
class CreateAsks < ActiveRecord::Migration[5.0]
  def change
    create_table :asks do |t|
      t.text "question"
      t.string "ip_address"
      t.string "region"
      
      t.timestamps
    end
  end
end

```



2. *config/routes.rb*

```ruby
Rails.application.routes.draw do
  # 나에게 등록된 모든 질문 출력	
  get '/ask' => 'ask#index'
  # 새로운 질문 작성
  get '/ask/new' => 'ask#new'
  # db로 데이터 넘어감
  post '/ask/create' => 'ask#create'
  # 글 삭제하기
  get '/ask/:id/delete' => 'ask#delete'
  # 글 수정하기
  get '/ask/:id/edit' => 'ask#edit'
  # 글 수정한 것을 db에 업데이트
  post '/ask/:id/update' => 'ask#update'
  # my page
  get '/ask/:id' => 'ask#show'
end
```



3. controllers/ask_controller.rb

```ruby
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
```

- Ask.find(params[:id]) : Ask 테이블에서 해당하는 id의 정보를 찾아옴

  

4. 1.*views/ask/index.html.erb*

```html
<div class="container">
    <div class="text-center">
        <a  class="btn btn-success" href="/ask/new">질문하기</a>
    </div>
    <ul class="list-group">
        <% @questions.each do |question| %>
        <li class="list-group-item"><%= question.question %><small><%= question.region %></small>
        <a class="btn-primary" href="/ask/<%= question.id %>">보기</a>
        <a class="btn-warning" href="/ask/<%= question.id %>/edit">수정</a>
        <a data-confirm="이 글을 삭제하시겠습니까?" class="btn-danger" href="/ask/<%= question.id %>/delete">삭제</a>
        </li>
        
        <% end %>
    </ul>
</div>
```



4. 2.*views/ask/new.html.erb*

```html
<div class="container">
    <div class="text-center">
        <a  class="btn btn-success" href="/ask/new">질문하기</a>
    </div>
    <ul class="list-group">
        <% @questions.each do |question| %>
        <li class="list-group-item"><%= question.question %><small><%= question.region %></small>
        <a class="btn-primary" href="/ask/<%= question.id %>">보기</a>
        <a class="btn-warning" href="/ask/<%= question.id %>/edit">수정</a>
        <a data-confirm="이 글을 삭제하시겠습니까?" class="btn-danger" href="/ask/<%= question.id %>/delete">삭제</a>
        </li>
        <% end %>
    </ul>
</div>
```



4. 3.*views/ask/edit.html.erb*

```html
<form action="/ask/<%= @ask.id%>/update" method="POST">
    <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token%>">
    <input type="text" name="question" value="<%= @ask.question %>">
    <input class="btn btn-primary" type="submit" value="수정하기"><br/><br/>
</form>
```



4. 4.*views/ask/show.html.erb*

```html
<div>
    <h3><%= @ask2.question %></h3>
</div>
```





#### bootstrap 설치하기

- *Gemfile* 에서 `gem 'bootstrap', '~> 4.1.1'`추가하기

- *Gemgile*에 추가하고 `$ bundle install`
- 서버 종료했다가 다시 켜기



> 반응형 web : 기기에 따라 화면 비율을 다르게 적용해 보여줌
>
> bootstrap에 기본적으로 내장되어 있음





####  geocoder 설치하기





#### 간단과제. TWITTER 만들어보기

- Table(Model)명 : board
  - column: contents, ip_address
- Controller명 : TweetController
  - action *index, show, new, create, edit, update, destory*
- View : *index, show, new/, edit*
- Bootstrap 적용하기
- 작성한 사람의 IP 주소 저장하기
- Index에서 contents 전체의 내용이 아닌 앞에 10글자만 보여주기



`$ rails _5.0.6_ new twitter_app`



<구현 화면 생각해보기 >

첫화면으로  글쓰기(new-create) +  tweet all을 보여줘야 함(index) / 클릭시 내용을 보여주는 곳 (show)  - 여기서 '수정', '삭제' 버튼 / 수정 버튼 클릭시 (edit-update) / 삭제 버튼 클릭시 (delete) 







> - 오늘의 Error
>   - 'ubuntu/workspace' : 현재 실행하고 있는 위치 확인하기
>   - bootstrap-saas와 bootstrap이 충돌할 경우 원하는 디자인이 적용되지 않음 