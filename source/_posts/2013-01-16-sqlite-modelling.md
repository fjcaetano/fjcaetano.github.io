---
layout: post
title: SQLite Modelling
date: 2013-01-16 20:42:01.000000000 -02:00
categories:
- Database
tags:
- db
- mysql
- objc
- sqlite
status: publish
type: post
published: true
share: true
comments: true
---

SQLite sucks. I think everybody knows, but I had to say it. But, sometimes, we
have no choice other than using it. Even though it's horrible and we know we`ll
be frustrated, once in a lifetime, SQLite may be the best choice. Wether developing
a program with a tiny or fast persistence. Sure there are other alternatives that
may suit you best, but the platform we're using may not support it.

For instance, I'm currently working on an iPad app that will have a fairly big
amount of data which must be available offline and it will have to be updated
sometimes. The best solution we came with is a background server task wich will
build an SQLite database populated with the most recent data and, when the user
requests, the iPad will download the whole database, overwriting any existing ones.

I'm no DBA, but I don't think anyone writes database creation scripts anymore.
At least not for the usual `CREATE TABLE`, etc. I'm mostly a MySQL guy and, for
a long time, I've been using [MySQL Workbench](http://dev.mysql.com/downloads/workbench/)
to create my DB models and syncing with my existing database. It automatically
creates everything that needs to be created and alter all tables that must be
altered without losing any data (most of the time). It's pretty good and I never
had any problems with it.

Now, back to listing reasons why SQLite sucks (dude, you can't add a constraint
when altering a table!). As any platform/framework with no "official" team, SQLite
depends on the community to increase it's awesomeness. Therefore, as everybody
knows SQLite *is not awesome*, no one really waste time developing a *good*
administration tool for it. What may happen, is a company own a DB management
program (such as [Navicat](http://www.navicat.com/)) and something like this goes by:

    - Hey, we're supporting MySQL, SQL Server, MongoDB, Cassandra, NoSQL and Postgree,
    don't you think people will notice we're ignoring SQLite?
    
    - God dammit *gasps*, add support to it too... but don't lose too much time with it!

Unfortunately, there are no really good tools to work with SQLite available.
"Hey, what about [Navicat](http://www.navicat.com/)?" It's okay, but I found tons
of bugs in the Mac version. If that's not enough, are you really willing to pay
to use a management tool for a free, open source database? But if you search deep
enough - like the 3rd page of Google - there are also some weird stuff that
appears such as [SQLiteStudio](http://sqlitestudio.one.pl/) (for Mac). When I see
things I like that I think "why the hell would people lose time developing
something for SQLite?" But hey, there are weirdos for everything, so I'd like to
thank for the [SQLiteStudio](http://sqlitestudio.one.pl/) team for being strange
enough to create it.

Even though it's not the best tool ever, [SQLiteStudio](http://sqlitestudio.one.pl/)
sure comes in handy and helps a lot, but it doesn't solve the mentioned problem
of modelling your SQLite database and not dealing with SQL scripts. So, searching
for something that would fill this void I found [this excellent script](http://www.henlich.de/software/sqlite-export-plugin-for-mysql-workbench/)
in Lua for [MySQL Workbench](http://dev.mysql.com/downloads/workbench/) that
*automagically* generates the SQLite CREATE script from a model. It's super easy
to install and use. Just follow this steps:

- Download the .lua script (duh!)
- Click in the "Scripting" menu in [MySQL Workbench](http://dev.mysql.com/downloads/workbench/).
- Click "Install Plugin/Module".
- Choose the downloaded .lua script.
- ???
- Profit.

That's it. Now, if you want to try, open a model, click the "Plugins" menu and
under "Utilities" there must be an option named "Export SQLite CREATE Script"
which may be the first one. Just click it and choose where to save the .sql script
and execute it. *Voilà*! If you have any problems executing the generated script,
you may need to comment the `BEGIN;` at the top and the `COMMIT;` at the bottom
of the .sql script.

Super easy, isn't it? Give it a try. Even if, like me, you hate SQLite. The plugin
solves the modelling problem, but creates a new one, because you can't `ALTER` an
existing table since it only generates the `CREATE` script. But if that's not a
problem go for it and be happy. When I found it, life suddenly became joyful again.
