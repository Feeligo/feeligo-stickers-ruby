# Feeligo Stickers

This gem makes it easy to add Feeligo's Stickers module to any Ruby-based
website.

It provides a convenient helper that you can call from your views to add
the module's Javascript loader.


## Installation

Add this line to your application's Gemfile:

    gem 'feeligo-stickers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feeligo-stickers


## Usage

Add the following code to all the views where you would like the Feeligo
module to be loaded, right after the opening `<body>` tag:

```erb
<body>
  <%= Feeligo::Stickers::loader_script_tag(user_id: current_user.id) %>
```

Where `user_id` is the id of the authenticated user.

The `user_id` should be a non-blank String or a non-zero integer. When no
user is authenticated, it should be set to `nil`.

Use `replace_sticker_tags` to replace a string message that contains sticker tags (`[s:PATH]`) into HTML `<img>` tags

```rb
Feeligo::Stickers.replace_sticker_tags(string, opts)
```

> By default images are hosted over `HTTP` at `stkr.es`
> if available, you can override either the scheme or host domain or both settings using the opts parameter

```rb
# src: https://flg.stkr.fr/PATH
opts = {scheme: 'https', host: 'flg.stkr.fr'}
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
