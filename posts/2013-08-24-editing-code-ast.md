---
layout: post
title: Editing code as manipulating ASTs
---

A completely unoriginal idea of mine is storing and editing code as abstract syntax trees instead of text files. The idea is that since we invented computers to automate menial tasks, it seams less than ideal that we treat code as a stream of lines instead of manipulating it on a higher level.

I recently watched a fake talk from the 70's called [The Future of Programming](http://vimeo.com/71278954) and got reminded of some of the great things that were achieved on such low powered computers (like [Sketchpad](https://www.youtube.com/watch?v=USyoT_Ha_bA) and [The Mother of All Demos](http://www.youtube.com/watch?v=yJDv-zdhzMY)). The point of the talk is that coding hasn't changed that much since then. This got me thinking how I would like things to change.

Coding by editing the AST wouldn't be a gorilla-hand-waiving-thing or mousing around. It would be mostly typing text, but with stricter enforcement of your preferences and smarter editing options. I think it would be a good fit for languages with static typing. These are some of possible benefits.

*   **No more fights over styling.** It doesn't matter if you use K&amp;R or Allman, tabs or spaces. It's all the same thing.
*   **Customizable syntax.** Whether you consider brackets and semicolons visual noise or visual reinforcement you should have the choice. This includes fancy stuff like [elastic tabstops](http://en.wikipedia.org/wiki/Elastic_tabstop).
*   **Your own syntactic sugar.** Why `File f = new File(".");` and not `f new= File(".")`? If you change your mind you can always remove the rule.
*   **Better version control.** The editor keeps track of the AST changes and submits those. It knows that you haven't changed the logic of the code when you moved a function below another and renamed it. You can also have better code comparisons.

### The counterpoint

One of the reasons for not doing this is that what we have is good enough (similar to QWERTY vs Dvorak). Text files are easy to understand by humans and mostly compatible between editors.

The problems with customization is that people understand each other less and syntactic sugar can be a slippery slope and lead to something like CoffeeScript. I don't consider it to be &ldquo;just JavaScript&rdquo; since you can't convert from JS to CS and get the same code. The (sad?) truth is that people who spend less time fretting over the warts of a language get more done.
