From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Wed, 28 Nov 2001 04:06:00 -0000
Message-ID: <00c001c17804$e7c479e0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKOEJNCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00277.html
Message-ID: <20011128040600.pCoVQJqmxicBDB4ixyIgnD6kPLfy1M1EJeFrUfhR6vc@z>

GULP. I just checked in my entire sandbox by mistake. HEAD is now broken
until I fix that up. ugh.

Rob
===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, November 28, 2001 6:36 PM
Subject: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating
entire stream as a header


> Ok, with a bit of help from Mr. Tsekov et al, this ought to do it:
>
>
> 2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>
>
> * nio-http.cc (NetIO_HTTP::NetIO_HTTP): Stop header parsing when
> SimpleSocket::gets() returns a zero-length string, so that we
> don't end up eating the entire stream thinking it's all header info.
>
>
> Index: nio-http.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v
> retrieving revision 2.7
> diff -p -u -b -r2.7 nio-http.cc
> --- nio-http.cc 2001/11/13 01:49:32 2.7
> +++ nio-http.cc 2001/11/28 07:24:49
> @@ -180,7 +180,9 @@ retry_get:
>        s = 0;
>        return;
>      }
> -  while ((l = s->gets ()) != 0)
> +
> +  // Eat the header, picking out the Content-Length in the process
> +  while (((l = s->gets ()) != NULL) && (*l != '\0'))
>      {
>        if (_strnicmp (l, "Content-Length:", 15) == 0)
>   sscanf (l, "%*s %d", &file_size);
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
