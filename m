Return-Path: <cygwin-patches-return-1550-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 31269 invoked by alias); 28 Nov 2001 12:06:27 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 31255 invoked from network); 28 Nov 2001 12:06:26 -0000
Message-ID: <00c001c17804$e7c479e0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKOEJNCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Sat, 27 Oct 2001 08:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Nov 2001 12:06:25.0484 (UTC) FILETIME=[1A5210C0:01C17805]
X-SW-Source: 2001-q4/txt/msg00082.txt.bz2

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
