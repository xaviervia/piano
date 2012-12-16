Piano
=====

Out-of-the-box Sinatra server for fast website sketching using Haml (or Slim) and Sass and CoffeeScript (and YAML!).

The magic triplet, one command away!

Installation
------------

    gem install piano

Standalone Usage
----------------

    $ piano [<port-number> <environment> [options]]

Piano will start a Sinatra server based in the same folder where you run the command, in the port and environment given. If no port or environment is given, Piano will start in the default Sinatra port `4567` and the default environment `development`. 

[Haml](http://haml-lang.com) `.haml` (or [Slim](http://slim-lang.com) `.slim`) files and [Sass](http://sass-lang.com) `.sass` and [CoffeeScript](http://github.com/josh/ruby-coffee-script) `.coffee` files in the base folder will automatically be mapped to urls.

    yoursite.com/users          => /users.haml or /users.slim
    yoursite.com/style.css      => /style.sass
    yoursite.com/app.js         => /app.coffee
    yoursite.com/folder/file    => /folder/file.haml or /folder/file.slim

Other files (images, plain text files, etc) will be loaded from the `public` subfolder as is default behavior in Sinatra.

Adding routes and stuff
-----------------------

Piano will try to load a file named `Pianofile`. There you can add functionality, like custom helpers and routes.

Any route added to the `Pianofile` will be parsed before the default routes from Piano, overriding them. 

#### Sample `Pianofile`

This file, for example, will bring back the email masking functionality that was deprecated in version 0.7.6

```ruby
get '/' do
  'Hi! Just testing'
end

get '/email' do
  "Here is my email: #{unicode_entities('xavier@example.com')}"
end

post '/' do  # The '/' route, is considered "index" for the haml and yaml files
  require "psych"

  File.open 'data/index.yaml', 'w' do |file|
    file.write params.to_yaml
  end
end

helpers do
  def unicode_entities(string)
    encodings = ''
    string.codepoints do |c|
      encodings += "&##{c};"
    end
    encodings
  end
end
```

YAML Data
---------

When receiving a request for `/users`, Piano will look up for a YAML file `data/users.yaml`. If it is there, the YAML file will be loaded and available for the correspondent template in the `@data` variable.

5 minutes site!
---------------

...all working with stylesheet, scripts and YAML data sources.

#### folder/index.haml

```haml
!!! 5
%html
  %head
    %title= @data['title']
    = style 'style.css'
    = script 'app.js'
  %body
    %h1= @data['title']
    %p= @data['description']
    %ul
      - @data['list'].each do |item|
        %li= item
```

Or if slim:

#### folder/index.slim

```slim
doctype html
html
  head
    title= @data['title']
    == style 'style.css'
    == script 'app.js'
  body
    h1= @data['title']
    p= @data['description']
    ul
      - @data['list'].each do |item|
        li= item
```

#### folder/style.sass

```sass
body
  width: 960px
  margin: 0 auto
  font:
    family: sans-serif
    size: 15px
```

#### folder/app.coffee

```coffee
alert "This is too simple to be true"
```

#### folder/data/index.yaml

```yaml
title: 5 minutes site!
description: Is amazing how simple it gets
list:
  - and I can have
  - a list
  - also.
```

Note: You can find this sample in the repository within the `sample` folder.

Going :production!
------------------

Piano goes production in command line just adding `production` to its arguments. When it goes, it goes this way:

* Now any unmatched route will give a zero-information-disclosure nice old 404 error page
* And the default behaviour for 500 errors in Sinatra.

For nicety sake, you can personalize 404 pages simply by creating a `404.haml` template. Beware when you do: out there be dragons.

Note: you can also add a `data/404.yaml` file to keep layer separation even in your error pages.

Command line options summary
----------------------------

* Port number: Any number passed as an argument to the `piano` command will be used as the port number.
* Environment: Any string that does not matches any other argument will be setted as the environment. 
* `noetags`: Adding `noetags` to the shell command will cause Piano to run without etags.
* `views:\<views_path\>` Sets the views folder
* `public:\<public_path\>` Sets the public folder

Library Usage as Sinatra Extension
----------------------------------

In version '0.12.0' using Piano as a Sinatra Extension was determined to be a bad idea, at least until the helpers are properly decoupled, tested, documented and extended.

> This section will remain empty until the helpers are completed. For information about using Piano as a Sinatra Extension, please refer to prior versions of the documentation.

Helpers that come in the bundle
-------------------------------

#### `style` and `script`

Piano features two convenience helpers to include stylesheets and javascripts: `style("style.css")` and `script("app.js")`.

You can use them in your haml templates like this:

```haml
!!! 5
%html
  %head
    %title Out-of-the-box is pretty awesome!
    = style 'style.css'
    = script 'app.js'
```

Or in slim:

```slim
doctype html
html
  head
    title Out-of-the-box is pretty awesome!
    == style 'style.css'
    == script 'app.js'
```

#### `extract`

Another helper you may find useful is `extract("source_text/html", word_count = 80)`. Returns an extract of the first `word_count` words (default is 80), html tags stripped, and closed by `"..."` . It does nothing is the text is less than `word_count` words in length.

```haml
%p= extract content, 25
```

#### `link`

No, _it does not print an anchor_: it strips all strange characters from a string and replaces all whitespace with "-". If the text is too long, it cuts it. 

Really useful when generating uri's for articles, or html id attributes.

```haml
%a(href="/articles/#{article.id}-#{link(article.title)}")= article.title
```
or

```haml
%h2(id="#{link(subtitle,4)}")= subtitle
```

In this example, the second argument (4) ensures that the link is done with no more than four of the subtitle's words.

#### `flash`

Piano now comes bundled with [Sinatra Flash](https://github.com/SFEley/sinatra-flash) so you can use the `flash` helper as in Rails. (0.10.9+) 

Please go to the [Sinatra Flash](https://github.com/SFEley/sinatra-flash) documentation for further reading. Is a nice gem and you might find it really useful.

### Etags

Since parsing YAML, Sass, Haml and CoffeeScript can be quite a burden for the processor, each response is marked with an Etag hash featuring the required file name and the timestamp of the last modification.

Etags cause client side caching. This should not be a problem since the hash changes every time a source file is modified (including the YAML data files), forcing the User-Agent to update its cache, but still is worth noting as I might not be fully aware of cache-related issues that Etag-ging may trigger.

Desired (future) features
-------------------------

* [SymbolMatrix](https://github.com/Fetcher/symbolmatrix) for YAML data.
* Features and specs covering all Piano's functionality.
* Agnosticism. Currently Piano is kind of HAML&SASS monotheistic.
* `style` and `script` helpers working with symbols.
* More helpers for semantic data handling.
* Deploy of sample with command line `--sample` argument.
* Online source files edition.
* Introduce internationalization using [g11n](//github.com/Fetcher/g11n)

* Now it would be nice to give Piano personalized templates not only to 404 but for all error pages, specially 500
* Custom error when there's no data

Known issues
------------

* Sinatra::Piano rules break when a route consisting of only a number is passed

Deprecated functions
--------------------

From version 0.11.0 on, `flash?` has been deprecated and the `flash` helpers has been replaced with the `sinatra-flash` gem.

Collaborators
=============

- [Alexey Gaziev](http://github.com/gazay)
- [Sasha Koss](http://github.com/kossnocorp)

License
=======

(The MIT License)

Copyright © 2011:

* [Xavier Via](http://xaviervia.com.ar)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
