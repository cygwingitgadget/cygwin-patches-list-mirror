Return-Path: <cygwin-patches-return-4051-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28409 invoked by alias); 9 Aug 2003 16:12:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28400 invoked from network); 9 Aug 2003 16:12:12 -0000
Date: Sat, 09 Aug 2003 16:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030809161211.GB9514@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00067.txt.bz2

On Thu, Aug 07, 2003 at 06:50:10PM -0400, Igor Pechtchanski wrote:
>Hi,
>
>This patch adds most of the capability of the script from
><http://cygwin.com/ml/cygwin-apps/2003-08/msg00106.html> to cygcheck.
>It is triggered by the "-c" flag to cygcheck.  "Integrity" is a rather
>strong word, actually, as all this checks for is the existence of files
>and directories, but this could be further built upon (for example, tar
>has a diff option that could be useful).  The patch is against cvs HEAD
>with my previous micropatch
>(<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00058.html>) applied.
>Comments and suggestions welcome.

I'm getting some odd errors when I apply this patch:

"4NT: Unknown command f:"

(as you can see I use 4NT).

I haven't had time to debug where these are coming from but I get one
for every file displayed.

Btw, have you considered some kind of rpm -f functionality?  That would
allow a user to do a:

cygcheck -f /usr/bin/ls.exe
fileutils-4.1-2

Also some kind of functionality which would allow cygcheck to query
the same files as the web search would be really cool.  Something like
a:

cygcheck --whatprovides /usr/bin/ls.exe

would be really useful.

Another interesting thing would be to do some ntsec/mkpasswd/mkgroup
type sanity checks or even to fix up common ntsec problems.

cgf
