Return-Path: <cygwin-patches-return-2238-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16841 invoked by alias); 28 May 2002 02:18:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16813 invoked from network); 28 May 2002 02:18:21 -0000
Date: Mon, 27 May 2002 19:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: cygwin-developers@cygwin.com
Subject: New stat stuff (was [PATCH] improve performance of stat() operations (e.g. ls -lR ))
Message-ID: <20020528021816.GA2066@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	cygwin-developers@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com> <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de> <20020527174354.GB21314@redhat.com> <20020527203832.A27852@cygbert.vinschen.de> <20020527184452.GA21106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020527184452.GA21106@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00222.txt.bz2

On Mon, May 27, 2002 at 02:44:52PM -0400, Christopher Faylor wrote:
>On Mon, May 27, 2002 at 08:38:32PM +0200, Corinna Vinschen wrote:
>>On Mon, May 27, 2002 at 01:43:54PM -0400, Chris Faylor wrote:
>>> In the process of researching this, I discovered that NT has a mechanism
>>> for determining a filename from an open handle so I'm trying to work
>>> that into dtable.cc. 
>>
>>Interesting.  Could you provide some link? MSDN or so?
>
>It's in the Native API reference.  NtQueryObject or NtQueryInformationFile.
>I had something working nicely with NtQueryInformationFile but then found out
>that it wasn't actually returning drive info.  So, the common google wisdom
>was that NtQueryObject should be used instead.  I assume that will probably
>return something like \device\whatever\dir\foo, though.
>
>The Windows 9x stuff mentions the use of VXDs although there is a hint that
>maybe that's not necessary.

I've just checked in a cleanup of fhandler_disk_file::fstat which
attempts to avoid opening the file, where possible.  Instead, it uses
the already existing FindFirstFile logic.

When it is necessary for the file to be opened, in theory, it attempts
to do so in query_open mode if it already knows the file's executable
state.  So, given the original reason for the patch that started this
thread, the -X and -E options should have a much greater impact on
performance.

I also added an NT-specific routine to determine the file name from it's
handle.  That means the binmode/textmode mounts should work correctly
when redirecting files on the console in Windows NT.  My quest to find
functions for doing this on Windows 9x continues.

A snapshot is building now.

FYI,
cgf
