Return-Path: <cygwin-patches-return-1473-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 30366 invoked by alias); 12 Nov 2001 03:13:25 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 30351 invoked from network); 12 Nov 2001 03:13:23 -0000
Message-ID: <002501c16b28$38f79ca0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <20011112014116.B2618@cygbert.vinschen.de> <20011112024721.GB28017@redhat.com>
Subject: Re: [RFD, PATCH]: Set "hidden" attribute when creating files/dirs/symlinks with trailing dot
Date: Tue, 02 Oct 2001 20:56:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Nov 2001 03:20:52.0901 (UTC) FILETIME=[08D3BD50:01C16B29]
X-SW-Source: 2001-q4/txt/msg00005.txt.bz2


> On Mon, Nov 12, 2001 at 01:41:16AM +0100, Corinna Vinschen wrote:
> >Hi,
> >
> >I thought it would be a good idea to ask for your opinion on that
> >patch first.
> >
> >As you all know, files with a trailing dot are hidden in the output
> >of e.g. `ls' unless you give explicitely the -a option.  That's a
> >good thing IMO (even if some people alias `ls' to `ls -a') since
> >it doesn't show the whole lot of option files when listing the
> >home dir.

Right... ls hides them, but opendir and readdir don't hide them.

> >The Windows explorer since 98/W2K has a global setting called
> >"[Do not] show hidden files and folders" which hides files with
> >FILE_ATTRIBUTE_HIDDEN attribute set, if set.  It's set to
> >"Do not ..." by default as it's for the `ls' command with dot files.

Because MS have this crazy idea that us users actually trust everyone
else in the world to always set the right flags on files. No thanks.
MS's extension hiding, and file hiding defaults are a direct cause for
many of the social engineering security attacks available to virus
writers and the like.

...
> >The below patch adds the appropriate setting of
FILE_ATTRIBUTE_HIDDEN.
> >
> >What's your opinion on such a change?

I don't like it. If I'm browsing the cygwin directory tree via explorer,
I should see everything by default - otherwise _why_ am I browsing that
tree?

Rob
