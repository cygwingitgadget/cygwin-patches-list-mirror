Return-Path: <cygwin-patches-return-1844-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27858 invoked by alias); 6 Feb 2002 18:10:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27834 invoked from network); 6 Feb 2002 18:10:17 -0000
Date: Wed, 06 Feb 2002 11:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: connect patch
Message-ID: <20020206181040.GD11730@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020206180727.GA504@dothill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020206180727.GA504@dothill.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00201.txt.bz2

On Wed, Feb 06, 2002 at 01:07:28PM -0500, Jason Tishler wrote:
>The attached patch fixes a SEGV when getsockname () is called.  This
>problem can be tickled by the PostgreSQL 7.2 version of psql:
>
>    http://archives.postgresql.org/pgsql-cygwin/2002-02/msg00012.php
>
>Note that I essentially plagiarized the following commit:
>
>    http://cygwin.com/ml/cygwin-cvs/2002-q1/msg00028.html
>
>Was this the right thing to do?

I think so.  It begs the question, though: do we need to apply this
patch elsewhere, too?

cgf

>Index: net.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
>retrieving revision 1.99
>diff -u -p -r1.99 net.cc
>--- net.cc	2002/01/29 13:39:41	1.99
>+++ net.cc	2002/02/06 17:52:16
>@@ -557,6 +557,8 @@ cygwin_socket (int af, int type, int pro
> 	name = (type == SOCK_STREAM ? "/dev/streamsocket" : "/dev/dgsocket");
> 
>       fdsock (fd, name, soc)->set_addr_family (af);
>+      if (af == AF_LOCAL)
>+	fdsock (fd, name, soc)->set_sun_path (name);
>       res = fd;
>     }
> 

>2002-02-06  Jason Tishler  <jason@tishler.net>
>
>	* net.cc (cygwin_socket): Set sun_path for newly connected socket.
