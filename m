Return-Path: <cygwin-patches-return-4061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5925 invoked by alias); 10 Aug 2003 00:04:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5916 invoked from network); 10 Aug 2003 00:04:51 -0000
Date: Sun, 10 Aug 2003 00:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: Charles Wilson <cygwin@cwilson.fastmail.fm>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030810000451.GA13252@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Charles Wilson <cygwin@cwilson.fastmail.fm>,
	cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu> <20030809161211.GB9514@redhat.com> <20030809162939.GA9863@redhat.com> <3F3548E8.1040605@cwilson.fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3548E8.1040605@cwilson.fastmail.fm>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00077.txt.bz2

On Sat, Aug 09, 2003 at 03:18:00PM -0400, Charles Wilson wrote:
>Christopher Faylor wrote:
>>I'll check this in but it would be nice if (WBNI) this used a mingw gzip
>>library rather than calling gzip directly.  That's a fair amount of
>>work but I could resurrect the zlib library in winsup if necessary.
>>
>>I wonder why setup is using gzip rather than bzip2 for the package files...
>
>the setup tree contains its own copies of the zlib and bzlib trees; 
>thue, they are compiled under the same runtime that setup is.  If setup 
>is a 'mingw' app, then so are the internal, statically linked libz and 
>bz2lib.

Yes, of course, I know about setup's zlib and bz2lib (having imported
both of them <or maybe DJ imported zlib.  Don't remember exactly.>).  I
kept the bz2lib around in winsup after moving setup out of winsup for
its eventual use by files in utils.  As I mentioned, I would be willing
to resurrect zlib also.

This doesn't explain why setup is using gzip over bzip2 since both are
available and bzip2 generally (but not always) provides superior
compression.

(I see that Robert indicates that this is historical but I thought that
the compression of the package files in /etc/setup postdates the
availability of bz2 compression in setup.  Guess I was wrong.)

>I imagine that the reason Igor used popen and zcat is simply that it was 
>easier than directly interfacing to the library.  Perhaps that issue 
>could be addressed in a later patch (along the lines of the compress_gz 
>class, which also provides uncompression capabilities?)

Yes.  It would have to be a later patch since the current implementation
is already checked in.

As I said, "That's a fair amount of work but I could resurrect the zlib
library in winsup if necessary."

cgf
