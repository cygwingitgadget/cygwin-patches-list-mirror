Return-Path: <cygwin-patches-return-5204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2702 invoked by alias); 14 Dec 2004 15:42:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1731 invoked from network); 14 Dec 2004 15:41:14 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 14 Dec 2004 15:41:14 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id CDA3D1B401; Tue, 14 Dec 2004 10:42:14 -0500 (EST)
Date: Tue, 14 Dec 2004 15:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041214154214.GE498@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BEFBA5.97CA687B@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00205.txt.bz2

On Tue, Dec 14, 2004 at 09:41:41AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>>With the current CVS, I am seeing the same (suboptimal) behavior on
>>Windows Me that I do in 1.5.12.
>>
>>If I type a bunch of "sleep 60&" at the command line, then "bash" won't
>>exit until the last sleep 60 has terminated.  I can't explain why this
>>is.  It doesn't work that way on XP, of course.
>>
>>While "bash" is waiting, I see no sign of it in the process table so
>>it's odd behavior.
>
>1.5.12, the current official release?  I have never observed it there.
>Also my recollection is that the delay was not necessarily equal to the
>sleep duration.

It's 1.5.12, the official release.  Testing anything else wouldn't really
be useful.

If I type

c:\>bash
bash-2.05b$ sleep 20&
bash-2.05b$ exit

There will be a ~20 second wait before bash exits.

I think I vaguely recall this from when I was mucking up the signal code
a year ago.


>>The current CVS should work better with exim now, though.
>
>Are you done with the changes?  I will try a snapshot and look at the
>code in the coming days.  Not much free time currently.

I got sidetracked somewhere along the way so, I guess the answer is
"yes, I'm done for now".  I don't have much free time myself, currently
but I thought it would be profitable to check in what I had since it
seems to be working ok in day to day activities with the one odd
non-regression exception above.

cgf
