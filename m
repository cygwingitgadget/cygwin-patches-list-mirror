Return-Path: <cygwin-patches-return-1704-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 312 invoked by alias); 15 Jan 2002 13:15:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32731 invoked from network); 15 Jan 2002 13:15:49 -0000
Date: Tue, 15 Jan 2002 05:15:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Message-ID: <20020115141546.B2015@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <C2D7D58DBFE9D111B0480060086E96350689B7D0@mail_server.gft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7D58DBFE9D111B0480060086E96350689B7D0@mail_server.gft.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00061.txt.bz2

On Tue, Jan 15, 2002 at 01:59:03PM +0100, Schaible, Jorg wrote:
> >Your attached patch look like a reverse patch.  And it's using
> >the wrong format.  Please send patches using diff -u format.
> 
> Uuups. Right. Sorry. Here it comes again.

That is a reversed patch either.  That should help:

  diff -up cygpath.cc-orig cygpath.cc

And please send the ChangeLog entry again.

Thanks,
Corinna

> 
> ============================
> --- cygpath.cc  Mon Jan 14 08:28:04 2002
> +++ cygpath.cc-orig     Mon Jan 14 08:16:22 2002
> @@ -161,13 +161,8 @@
>        len = strlen (filename) + 100;
>        if (len == 100)
>          {
> -          if (!ignore_flag)
> -          {
> -            fprintf(stderr, "%s: can't convert empty path\n", prog_name);
> -            exit (1);
> -          }
> -          else
> -            exit (0);
> +          fprintf(stderr, "%s: can't convert empty path\n", prog_name);
> +          exit (1);
>          }
>      }
>    else
> ============================
> 
> Regards,
> Jorg

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
