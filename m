Return-Path: <cygwin-patches-return-1520-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 3939 invoked by alias); 27 Nov 2001 09:14:40 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 3925 invoked from network); 27 Nov 2001 09:14:36 -0000
Message-ID: <3C035977.BF151D0A@syntrex.com>
Date: Mon, 15 Oct 2001 19:41:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
CC: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a 
 header
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00052.txt.bz2

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
