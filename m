Return-Path: <cygwin-patches-return-3891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22067 invoked by alias); 24 May 2003 20:35:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22054 invoked from network); 24 May 2003 20:35:27 -0000
Message-ID: <029701c32233$fd011950$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com> <20030524202421.GE19367@cygbert.vinschen.de>
Subject: Re: Proposed change for Win9x file permissions...
Date: Sat, 24 May 2003 20:35:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Cam-ScannerAdmin: mail-scanner-support@ucs.cam.ac.uk
X-Cam-AntiVirus: Not scanned
X-Cam-SpamDetails: 
X-SW-Source: 2003-q2/txt/msg00118.txt.bz2

Corinna Vinschen wrote:
> On Sat, May 24, 2003 at 01:55:30PM -0400, Christopher Faylor wrote:
>> I like the idea but I'm wondering if it is too general.  Corinna, what do
>> you think?
>
> I like the idea as well but wouldn't that eventually cause problems if
> the umask disables the user bits?  I'm a bit concerned about the new
> arriving questions on the cygwin ML due to applications checking these
> bits in combination with clueless users.  It would be better, IMHO, if
> the umask couldn't mask the user bits at all, just the group and other
> bits.

Will anything or anyone ever set a umask masking user bits?

It seems like a very unlikely corner case.
I suppose someone might *want* to set such a umask, though, if they really
needed to test permissions behaviour on Win9x.

I can't see a clueless user figuring out how to change the umask at all, so
since the default doesn't mask user access, we should be safe from
unnecessary questions, shouldn't we?


Max.
