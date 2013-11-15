LadyPartsApp::Application.routes.draw do
  root 'films#index'
  get '/films/barchart' => 'films#barchart'
  get '/films/director' => 'films#director'
  
end
