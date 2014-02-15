# must be run with 'web' from karlinator

require 'sinatra/base'
require 'sinatra/assetpack'
require 'haml'

class MyApp < Sinatra::Base
  set :root, File.expand_path('../..', __FILE__)
  enable :inline_templates
  get '/' do
    @sentences = $markov.generate_n_sentences rand(1..5)
    haml :index
  end
  register Sinatra::AssetPack
  assets {
    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/lib/**/*.js'
    ]
  }

  run!
end

__END__

@@ layout
%html
  %head
    %title Karlinator
    != js  :app
    :css
      body {
        background: #9CAA75;
      }
      body > * {
        margin-left: auto;
        margin-right: auto;
      }
      h1 {
        color: #3d5f15;
        text-align: center;
        font-size: 120px;
        text-shadow: white 0px 0px 46px;
        margin-bottom: 0;
      }
      #message {
        margin-top: 5em;
        width: 60%;
        font-size: 200%;
        background: #ddca7e;
        color: #42774F;
        border-radius: 1em;
        padding: 1em;
        overflow: hidden;
        text-shadow: #9caa75 0px 0px 2px;
        border: 3px solid #3d5f15;
        box-shadow: 0px 0px 63px white;
      }
      .button {
        display: block;
        width: 8em;
        outline: none;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        font: 14px/100% Arial, Helvetica, sans-serif;
        padding: .5em 2em .55em;
        text-shadow: 0 1px 1px rgba(0,0,0,.3);
        -webkit-border-radius: .5em;
        -moz-border-radius: .5em;
        border-radius: .5em;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
        -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
        box-shadow: 0 1px 2px rgba(0,0,0,.2);
      }
      .button:hover {
        text-decoration: none;
      }
      .button:active {
        position: relative;
        top: 1px;
      }
      .orange {
        color: #fef4e9;
        border: solid 1px #da7c0c;
        background: #f78d1d;
          background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
        background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
      }
      .orange:hover {
        background: #f47c20;
        background: -webkit-gradient(linear, left top, left bottom, from(#f88e11), to(#f06015));
        background: -moz-linear-gradient(top,  #f88e11,  #f06015);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f88e11', endColorstr='#f06015');
      }
      .orange:active {
        color: #fcd3a5;
        background: -webkit-gradient(linear, left top, left bottom, from(#f47a20), to(#faa51a));
        background: -moz-linear-gradient(top,  #f47a20,  #faa51a);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f47a20', endColorstr='#faa51a');
      }
      p {
        text-align: center;
      }
  %body
    %h1 Karl-inator
    = yield

@@ index
%a.orange.button{href: '/'} neues Zitat
#message= @sentences
:javascript
  jQuery( function() {
    var loadNext = function() {
      document.location = '/?t=' + Math.round( (new Date()) / 1000 );
    }

    var duration = 4000 + $('#message').text().length * 66;
    var timeout = setTimeout(loadNext, duration);
    $warn = $('<p></p>').html('<span class="seconds">' + (duration / 1000) + '</span> Sekunden. Klick irgendwo f&uuml;r Pause.').appendTo('body');

    var countdown = setInterval(function() {
      duration = duration - 100;
      if (duration < 0) { duration = 0; }
      $('span.seconds').text( duration / 1000 );
    }, 100);

    $('body').click(function() {
      $warn.remove();
      clearInterval(countdown);
      clearTimeout(timeout);
    });
  });
