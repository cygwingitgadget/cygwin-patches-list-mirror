Return-Path: <cygwin-patches-return-2288-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27387 invoked by alias); 2 Jun 2002 17:48:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27373 invoked from network); 2 Jun 2002 17:48:52 -0000
Date: Sun, 02 Jun 2002 10:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: strace -f fix
Message-ID: <20020602174851.GA16779@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06eb01c209b9$11c491d0$6132bc3e@BABEL> <20020601223846.GB8326@redhat.com> <07ee01c209be$f395c430$6132bc3e@BABEL> <20020601225943.GA2561@redhat.com> <07f601c209c3$4b212010$6132bc3e@BABEL> <20020602020326.GA7937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020602020326.GA7937@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00271.txt.bz2

On Sat, Jun 01, 2002 at 10:03:26PM -0400, Christopher Faylor wrote:
>On Sun, Jun 02, 2002 at 12:23:09AM +0100, Conrad Scott wrote:
>>I'm well confused and it's obviously more complex than I realised.
>>Maybe we'll be lucky and there'll be one set of flags that does work on
>>all platforms?
>>
>>Fingers crossed.
>
>Well, we don't have to worry about CE.  That's not an issue.
>
>I did reboot in W2K and noticed the behavior that you reported.  I
>suppose this means that gdb isn't going to work right on some platform.
>I'll try making your change to strace and trying it on the platforms
>that are available to me.  If I do enough rebooting, that's basically
>every platform that cygwin is supposed to be report, give or take some
>service packs.

I checked in a similar fix but I didn't check this everywhere.  Perhaps
other people might want to do that.

I did make '-f' the default.  I normally want to see everything.

cgf
