Return-Path: <cygwin-patches-return-3484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5781 invoked by alias); 3 Feb 2003 15:50:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5758 invoked from network); 3 Feb 2003 15:50:43 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Mon, 03 Feb 2003 15:50:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Vaclav Haisman <V.Haisman@sh.cvut.cz>
cc: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030203141333.Y68413-100000@logout.sh.cvut.cz>
Message-ID: <Pine.GSO.4.44.0302031047200.24195-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00133.txt.bz2

On Mon, 3 Feb 2003, Vaclav Haisman wrote:

> This is a little bit improved version of my previous post.
> By default creation of sparse files is disabled. It can be enabled by CYGWIN
> option sparse_files.
>
> Vaclav Haisman
>
> 2003-02-03  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
> [snip]
> 	* environ.cc (parse_thing): Add new CYGWIN option.
>
> Index: cygwin/environ.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
> retrieving revision 1.90
> diff -p -u -r1.90 environ.cc
> --- cygwin/environ.cc	30 Sep 2002 03:05:13 -0000	1.90
> +++ cygwin/environ.cc	3 Feb 2003 12:54:40 -0000
> @@ -522,6 +522,7 @@ static struct parse_thing
>    {"title", {&display_title}, justset, NULL, {{FALSE}, {TRUE}}},
>    {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
>    {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{FALSE}, {TRUE}}},
> +  {"sparse_files", {&allow_sparse}, justset, NULL, {{FALSE}, {TRUE}}},
>    {NULL, {0}, justset, 0, {{0}, {0}}}
>  };
> [snip]

Vaclav,

I don't know if it matters, but the rest of the entries in the parse_thing
table are alphabetically ordered...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
