Return-Path: <cygwin-patches-return-2181-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18303 invoked by alias); 13 May 2002 08:25:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18268 invoked from network); 13 May 2002 08:25:35 -0000
Message-ID: <3CDF7879.9A8839BB@cistron.nl>
Date: Mon, 13 May 2002 01:25:00 -0000
From: Ton van Overbeek <tvoverbe@cistron.nl>
X-Accept-Language: en, en-US, en-GB, nl, sv
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Get recursive grep to work on Win9x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00165.txt.bz2

Chris Faylor wrote:
> I've checked in a slightly different version which should have the same
> effect.
> 
> I appreciate the time you spent tracking this down and researching the
> correct method for fixing this.  I used roughly the same technique as
> you but moved it to only affect the opening of disk files.  Hopefully,
> it will fix your problem.
> 

Attacking the problem in fhandler_disk_file::open before fhandler_base::open
is called is a better place and more efficient.
Checked grep -R execution with the snapshot (cygwin-20020513.dll) and it
works on W98SE.

> Btw, for future reference, your patch was reversed.  It should have been
> diff -u foo.orig foo, i.e. the original file goes first.

I hope I remember it next time around ...
Maybe you could mention this on http://cygwin.com/contrib.html.
Now it mentions only using 'cvs diff -up' to generate the patch.

Anyway I hope this has brought cygwin.dll 1.3.11 a bit closer.

Ton van Overbeek
