From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Tue, 27 Nov 2001 01:48:00 -0000
Message-ID: <00ee01c17728$b57c3d60$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00250.html
Message-ID: <20011127014800.H5RfgURkpfKkJKwnoZ-eEFzOA8HcyHGXDFtgplkVhYY@z>

Gary, I'll hold off committing this, until you and Pavel agree on the
exact fix.

Thanks for tracking this down, BTW.

Rob
===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Tuesday, November 27, 2001 4:58 PM
Subject: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream
as a header


> Ok, setup.exe seems to work much better with this patch applied (also
attached):
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
>   sscanf (l, "%*s %d", &file_size);
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
