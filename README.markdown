Mnemosine
=========

Mnemosine is a key/value store written in Ruby. It was created for the CodeBrawl competition located here: [http://codebrawl.com/contests/key-value-stores](http://codebrawl.com/contests/key-value-stores)

You can run the Mnemosine server by running "rake run" from the root directory. There is also a client you can use. The API covers a small amount of what Redis can do.

Obviously Ruby is probably not a great choice for creating a database, as one typically wants very high performance. Instead, consider this to be a fun toy. It uses EventMachine on the server and passes JSON via persistent raw TCP connections. It also was also developed BDD style, so it could be good to look at if you're new to testing or Test::Unit.

I'll probably hack more features onto this as time permits. I'd like to get replication and sharding working, possibly a map/reduce system, and if I'm feeling really ambitious, perhaps some kind of indexed search.

There's currently no security on the database, and it only runs on localhost. As I said, this is just a fun little project, not a serious DB engine.

I'm putting this under the MIT license, so feel free to do whatever you want with it. My only request is that you don't use this as the basis for an entry into the upcoming CodeBrawl competition. While that would be hilarious, it would make me a sad panda.
