From: Pavel Tsekov <ptsekov@syntrex.com>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Tue, 27 Nov 2001 01:14:00 -0000
Message-ID: <3C035977.BF151D0A@syntrex.com>
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00248.html
Message-ID: <20011127011400.ha5j_7c7vb8PXaBsb6frH68NZwASirTR9gyL4ow7-Is@z>

"Gary R. Van Sickle" wrote:
> 
> Ok, setup.exe seems to work much better with this patch applied (also attached):

Yep, I'm the one that screwed this up. Here is how it was before
my patch was applied.

  do {
    l = s->gets ();
    if (_strnicmp (l, "Content-Length:", 15) == 0)
      sscanf (l, "%*s %d", &file_size);
  } while (*l);


What about replacing this in your patch:
> +  while (((l = s->gets ()) != 0) && (strlen(l) != 0))
with
  +  while (((l = s->gets ()) != 0) && *l)

And add a break here:

        if (_strnicmp (l, "Content-Length:", 15) == 0)
 +        {
 +          sscanf (l, "%*s %d", &file_size);
 +          break;
 +        }


You say it works much better now - I'm curios if it worked
at all (I think not). 

> 
> 2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>
> 
>         * nio-http.cc (NetIO_HTTP::NetIO_HTTP): Stop header parsing when
>         SimpleSocket::gets() returns a zero-length string, so that we
>         don't end up eating the entire stream thinking it's all header info.
> 
> Index: nio-http.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v
> retrieving revision 2.7
> diff -p -u -b -r2.7 nio-http.cc
> --- nio-http.cc 2001/11/13 01:49:32     2.7
> +++ nio-http.cc 2001/11/27 05:31:36
> @@ -180,7 +180,9 @@ retry_get:
>        s = 0;
>        return;
>      }
> -  while ((l = s->gets ()) != 0)
> +
> +  // Eat the header, picking out the Content-Length in the process
> +  while (((l = s->gets ()) != 0) && (strlen(l) != 0))
>      {
>        if (_strnicmp (l, "Content-Length:", 15) == 0)
>         sscanf (l, "%*s %d", &file_size);
>
