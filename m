Return-Path: <cygwin-patches-return-4793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29473 invoked by alias); 30 May 2004 06:34:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29464 invoked from network); 30 May 2004 06:34:59 -0000
Message-ID: <cb51e2e040529233432772dc2@mail.gmail.com>
Date: Sun, 30 May 2004 06:34:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
To: John Paul Wallington <jpw@gnu.org>, cygwin-patches@cygwin.com
Subject: Re: ssp.c (usage): Add missing linefeed.
In-Reply-To: <E1BS6oZ-00009G-00@sol.shootybangbang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1BS6oZ-00009G-00@sol.shootybangbang.com>
X-SW-Source: 2004-q2/txt/msg00145.txt.bz2

I went ahead and applied this. It doesn't appear to break anything. :)

On Mon, 24 May 2004 05:11:51 +0100, John Paul Wallington <jpw@gnu.org> wrote:
> 
> 2004-05-24  John Paul Wallington  <jpw@gnu.org>
> 
>         * ssp.c (usage): Add missing linefeed.
> 
> --- ssp.c       14 Feb 2004 19:43:07 +0000      1.8
> +++ ssp.c       24 May 2004 05:09:52 +0100
> @@ -801,7 +801,7 @@ usage (FILE * stream)
>      "  ssp -v -s -l -d 0x61001000 0x61080000 hello.exe\n"
>      "\n");
>    if (stream == stderr)
> -    fprintf (stream, "Try '%s --help' for more information.", prog_name);
> +    fprintf (stream, "Try '%s --help' for more information.\n", prog_name);
>    exit (stream == stderr ? 1 : 0);
>  }
>
