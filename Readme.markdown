Most of the time, I don't set out to write a gem. 
=================================================

Perhaps I'm not audacious enough to consider every piece of code I write to be worthy of use by other developers. Perhaps.

But, more likely than that, it's just that I don't think that far ahead. I'm more interested in playing with the idea at the start, rather than thinking about how other people are going to remember - nay, worship my name, years in the future.

Anyway, sometimes - after a bit of tinkering and pondering - I do end up with a library that I consider gem-worthy and fit for consumption. But every time I look at the existing tools to build gems, I'm paralysed by the comprehensive nature of their function. 

Often, they'll try to generate a particular directory structure, with test stubs and a website, which is fine in principle, but I've already got my code the way I want it; I'm not generating a new project.

Even worse, sometimes they'll add themselves as dependencies for your gem! Yuck.

I am not interested in that. I just want the simplest thing that could possibly work, to build my gem and make it available to the world. I will add any bells and whistles that I want later.

And so:

Gem This
========

The `gem-this` command expects to be run in the directory of your existing code:

    $ cd my-project
    $ mate lib/sweet_code.rb
     ... hacking ...
    $ gem-this
    
New in 0.2.0: we also register a gem command, so you can just type:

    $ gem this
  
When you run `gem-this`, it will create a new `Rakefile` in your project directory. If you already had a `Rakefile`, it will append to the end of it, so your existing tasks are safe.

    $ rake -T
    rake clean                   # Clear out RDoc and generated packages
    rake clobber_package         # Remove package products
    rake clobber_rdoc            # Remove rdoc products
    rake gem                     # Build the gem file gem-this-0.1.0.gem
    rake package                 # Build all the packages
    rake rdoc                    # Build the rdoc HTML Files
    rake repackage               # Force a rebuild of the package files
    rake rerdoc                  # Force a rebuild of the RDOC files
    rake rubyforge:release       # Release gem and RDoc documentation to RubyForge
    rake rubyforge:release:docs  # Publish RDoc to RubyForge.


The simplest thing to do next is simply run `rake package`:

    mkdir -p pkg
      Successfully built RubyGem
      Name: my-project
      Version: 0.1.0
      File: my-project-0.1.0.gem
    mv my-project-0.1.0.gem pkg/my-project-0.1.0.gem
    
As you can tell, it's used the current directory name as the name of the gem. But, you can change any of that. Just open your `Rakefile` and edit the details.

It tries to be a little bit clever, detecting the presence of a few directories (like `bin`, `test` and `spec`) and behave accordingly. If you're already using git, it will ignore the `rdoc` and `pkg` directories for you.

What next?
----------

For the most part, `gem-this` simply sets up a good base for you to customise yourself, with as little fuss or overhead as possible. It's up to you if you want make it more sophisticated, but I trust you. 

Don't worry; you'll be fine.


Thanks
======

Inspiration, and sometimes code chunks, were taking from lots of the existing gem tools, but particularly 'gemify' (wish I could've used that name!) and 'simple-gem'.


MIT License
===========

(c) James Adam 2009, or whatever

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.