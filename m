Return-Path: <cygwin-patches-return-2303-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14269 invoked by alias); 4 Jun 2002 15:35:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14218 invoked from network); 4 Jun 2002 15:35:31 -0000
Date: Tue, 04 Jun 2002 08:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] _unlink() & rmdir() on /proc/*
Message-ID: <20020604153535.GA11056@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <11415277457.20020604143720@syntrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11415277457.20020604143720@syntrex.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00286.txt.bz2

On Tue, Jun 04, 2002 at 02:37:20PM +0200, Pavel Tsekov wrote:
>Hello,
>
>Currently "rm -rf" on a file or directory under /proc returns
>ENOENT. This is not correct and is caused by the fact that
>the posix filename for, say, /proc/uptime is translated to
>the following win32 name: c:\cygwin\proc\uptime (if c:\cygwin
>is mounted on /).
>
>The attached patches fix this problem by returning EROFS
>from _unlink() and rmdir() if path_conv::get_devn() returns
>any of the following device numbers: FH_PROC, FH_PROCESS, FH_REGISTRY.
>
>P.S. I don't expect this patches to be applied because they may look
>like ugly hacks or something like that... I didn't find any more
>appropriate way to fix this though without greater modifications to
>the code. I see several ways of fixing this in a much better way:

I haven't actually read your patch since, AFAIK, you don't have an
assignment with Red Hat, right?  If this is the case, would you mind
sending one in?

If you do have an assignment, please let me know (here in
cygwin-patches) and I'll take a look at this further.

cgf
