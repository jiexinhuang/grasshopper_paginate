# Grasshopper Pagination

Integrates Zurb Foundation's [pagination styles](http://foundation.zurb.com/docs/navigation.php) with [will_paginate](https://github.com/mislav/will_paginate).

Based on [foundation-will_paginate](https://github.com/markmcconachie/foundation-will_paginate) with several changes:

* When gap is clicked, display an input field for exact page number, hit enter will navigate the the particular page
* Change default inner_window to 1
* When total count is no more than 1.5 times of per_page count, do not show pagination links, display all records
* Give user the option to provide per page input number

## Installation

Add this line to your application's Gemfile:

    gem 'grasshopper_paginate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grasshopper_paginate 

## Configuration

Include assets

    application.js
    //= require grasshopper_paginate/paginate

    application.css
    //= require grasshopper_paginate/paginate

## Usage

For paginated query, with will_paginate, you woul usually use
``` ruby
@users = User.paginate page: params[:page]

```

Now use
``` ruby
@users = User.smart_paginate page: params[:page]

```

In your view where you would usually use

```
<%= will_paginate @posts %>
```

Now use

```
<%= grasshopper_paginate @posts %>
```

The default per page options provided to User are 10,20. To override these options add a file in config/initializers/grasshopper_paginate.rb with content.

``` ruby
# Per page options 2,5,10
Grasshopper::Paginate.per_page_options = [2,5,10]
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
