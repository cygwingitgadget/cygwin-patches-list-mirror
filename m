Return-Path: <cygwin-patches-return-2234-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5402 invoked by alias); 27 May 2002 13:15:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5384 invoked from network); 27 May 2002 13:15:20 -0000
Message-ID: <FE045D4D9F7AED4CBFF1B3B813C85337676298@mail.sandvine.com>
From: Don Bowman <don@sandvine.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR
	 ) 
Date: Mon, 27 May 2002 06:15:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q2/txt/msg00218.txt.bz2

Conrad Scott wrote:

>A (possibly related) note, it occurred to me the other day (as I looked at
>some strace output) that opening the file during stat() --- so that you can
>call GetFileInformationByHandle() --- will be slow if you've got an
>anti-virus program running since they tend to intercept file opens. Then
>again, I don't understand enough about cygwin *or* win32 to understand
>whether you can get the same information without opening the file. Thus it
>might be a win to avoid opening the file if possible on ntsf too (w/
ntsec).

That's probably what's happening to me. I was trying to figure out why
the open read the file in a seemingly random fashion. I'm running 
Norton anti-virus.

I think Corinna's idea is pretty good, to skip the check entirely if
the results are obvious for the given filesystem.
Its also conceivable a user may not care to check for hard links
(do I use them? Not that I'm aware of).
