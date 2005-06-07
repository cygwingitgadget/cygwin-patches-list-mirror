Return-Path: <cygwin-patches-return-5532-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8478 invoked by alias); 7 Jun 2005 14:15:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8464 invoked by uid 22791); 7 Jun 2005 14:15:31 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 07 Jun 2005 14:15:31 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3D84213C28E; Tue,  7 Jun 2005 10:14:16 -0400 (EDT)
Date: Tue, 07 Jun 2005 14:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Message-ID: <20050607141416.GG16960@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118084587.5031.128.camel@fulgurite> <20050606200639.GC13442@trixie.casa.cgf.cx> <1118091704.5031.144.camel@fulgurite> <20050606213339.GC16960@trixie.casa.cgf.cx> <1118105808.5031.172.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118105808.5031.172.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00128.txt.bz2

On Mon, Jun 06, 2005 at 05:56:48PM -0700, Max Kaehn wrote:
>On Mon, 2005-06-06 at 14:33, Christopher Faylor wrote:
>> So, I checked in the above and, after changing cygload.exp so that it
>> compiles cygload.cc rather than cygload.cpp, I found a more serious
>> error.  I've attached the cygload.log file.  It doesn't look pretty,
>> unfortunately.  You might notice the same thing if you configure your
>> Cygwin DLL with --enable-debugging, like I do.
>
>I'm having trouble replicating the problem.  Here's what I did:
>
>    cd src/build
>    rm -rf etc i686-pc-cygwin libiberty
>    ../configure --enable-debugging=yes
>    make
>    cd i686-pc-cygwin/winsup
>    make check
>    cd testsuite
>    runtest --tool cygload
>
>The first time I ran "runtest --tool cygload", I got an error about
>mismatched heap addresses, so I copied new-cygwin1.dll to
>/bin/cygwin1.dll and reran the test.  That time, it passed.
>
>What am I doing wrong?  I've attached the output of "runtest --tool
>cygload -v".  (The mingw-cygwin.log referenced in there is empty.)
>I notice that I'm getting warnings about "couldn't find the global
>config file" and "couldn't find tool init file", so there may be
>something wrong with my test setup.

Hmm.  Maybe it was cockpit error on my part.  I can't duplicate the
problem today.  That's odd.

cgf
