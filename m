Return-Path: <cygwin-patches-return-1522-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 14311 invoked by alias); 27 Nov 2001 09:48:43 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 14296 invoked from network); 27 Nov 2001 09:48:42 -0000
Message-ID: <00ee01c17728$b57c3d60$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Mon, 15 Oct 2001 20:01:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 27 Nov 2001 09:48:41.0233 (UTC) FILETIME=[B207B010:01C17728]
X-SW-Source: 2001-q4/txt/msg00054.txt.bz2

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
