From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Categories for setup
Date: Wed, 13 Jun 2001 09:12:00 -0000
Message-id: <20010613121306.E7001@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F05E@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00289.html

I have a number of changes that I've made to setup that I would like to
get in before I look at this.  I've added some new keywords and
performed what I hope are some cleanups on the code.

I've just checked my changes in.  Things seem to work ok for me, but I
assume that I probably must have broken something.

I'm sorry to do this to you Robert, but could you resubmit your patches
against the current sources?

cgf

On Wed, Jun 13, 2001 at 12:48:26PM +1000, Robert Collins wrote:
>I hope my mailer hasn't broken the changelog formatting... let me know
>if it has and I'll resend it
>
>
>2001-06-13  Robert Collins <rbtcollins@hotmail.com
>
>	* choose.cc: Add "Category" header.
>	(paint): Render the category.
>	(best_trust): Don't trust non required packages. No category is
>considered required.
>	(create_listview): Calculate "Category" column.
>	(do_choose): Log package category.
>	* ini.h (Package): Add category field.
>	* inilex.l: Grab category.
>	* iniparse.y: Grab category.
>
>Rob



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
