Return-Path: <cygwin-patches-return-3403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23215 invoked by alias); 15 Jan 2003 20:05:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23206 invoked from network); 15 Jan 2003 20:05:11 -0000
Date: Wed, 15 Jan 2003 20:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
Message-ID: <20030115200607.GF23351@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com> <20030115060939.GB15975@redhat.com> <3E2570BD.2582F293@ieee.org> <20030115182850.GG15975@redhat.com> <3E25B762.B7C0452E@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E25B762.B7C0452E@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00052.txt.bz2

On Wed, Jan 15, 2003 at 02:32:50PM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>> 
>> Ok.  Got it.  I checked in a patch.
>> 
>Chris,
>
>In a similar same vein, class fhandler_base has a member open_status
>that is set in a dozen places but never read, AFAICT.

Funny, I just noticed that a couple of weeks ago.  However, I am working
on some code, which implements, which I anticipate will use it.

FWIW, I can actually create a fifo, read from it, and occasionally get
another process to actually write to it.  You can also create device
files on disk with mknod and they work correctly.  Wish I had more time
to work on it.

>I was thinking that those patches would get into 1.3.20
>but making etc_changed non heritable might somehow avoid the 
>reported BSOD. Let me know if you would like to include it in 1.3.19

I think it should go into 1.3.19.  I'm swamped today but it looks like
I introduced a path parsing bug so I have to fix that before 1.3.19 is
released.  And, fixing a BSOD is a really good reason to hold up a
release, regardless.

I think the etc_changed code is mine and I feel comfortable with your
changes.  If you want to check in a variation along the lines we
discussed, feel free.  We can work out the details as we go along, if I
have questions.

cgf
