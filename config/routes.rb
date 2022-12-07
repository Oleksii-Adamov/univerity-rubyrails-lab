Rails.application.routes.draw do
  get 'baggages/all_baggage'
  get 'baggages/b_task'
  get 'baggages/c_task'
  get 'baggages/d_task'
  get 'baggages/e_task'
  get 'baggages/a_task'
  get 'baggages/index'
  root "baggages#index"
  resources :baggages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
