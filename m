From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Wed, 13 Jun 2001 07:24:00 -0000
Message-id: <20010613162448.M1144@cygbert.vinschen.de>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A00@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00288.html

On Wed, Jun 13, 2001 at 04:48:06PM +1000, Robert Collins wrote:
> Sorry about this - trivial addition to the last patch, to handle
> dependencies of dependencies.
> 
> ====
> This supercedes my prior patch. (laziness here - diff against cvs is
> much nicer than forking my sandbox between patches.)
> 
> 2001-06-13 16:27:00 Robert Collins <rbtcollins@hotmail.com
> 
> 	* choose.cc: Add "Category" header.
> 	(paint): Render the category.
> 	(best_trust): Don't trust non required packages. No category is
> considered required. Ignore categories when the ignore_required
> parameter is set.
> 	(create_listview): Calculate "Category" column.
> 	(do_choose): Log package category.
> 	(add_required): Ensure that all packages that are required for
> package p will be installed. Recurses into each required package.
> 	(list_click): Use add_required().
> 	(dialog_cmd): Check add_required() for all packages.
> 	* ini.h (Package): Add category field.
> 	(Dependency): New type for storing dependency data.
> 	(new_requirement): Prototype for function to add a requirement
> dependency.
> 	* inilex.l: Add "category" and "requires" keywords.
> 	* iniparse.y: Grab category.
> 	(new_requirement): Add a required package into the required
> dependency list for the current package.
> 
> Rob

I just tried your patch in a local directory and it's somewhat
wierd. I only added a

	category: shell

to the `ash' part of setup.ini.

If I have everything installed (I have a installed.db file in
/etc/setup) the chooser contains the text `Nothing to install'. 
Clicking on `full' shows the `shell' category in ash. That's
ok.

If I have no installed.db file (pretending to have no Cygwin
installation) I'm getting a list of all packages, except for
`ash'. `ash' is only visible in the `full' view again and
I have supposedly the version "2.4.PRE-STABLE" installed --
which is a squid version number -- and `ash' is marked for
being skipped.

Did I miss something?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
