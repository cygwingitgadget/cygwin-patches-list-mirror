Return-Path: <cygwin-patches-return-4067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14349 invoked by alias); 10 Aug 2003 01:11:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14340 invoked from network); 10 Aug 2003 01:11:06 -0000
Date: Sun, 10 Aug 2003 01:11:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030810011105.GA13793@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030809181426.GA11170@redhat.com> <Pine.GSO.4.44.0308091539340.7386-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308091539340.7386-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00083.txt.bz2

On Sat, Aug 09, 2003 at 03:52:55PM -0400, Igor Pechtchanski wrote:
>On Sat, 9 Aug 2003, Christopher Faylor wrote:
>>On checking this patch a little further, I see that it gives a
>>misleading "OK" when the package file is missing.  Could you detect
>>that case?
>
>Yes.  The attached patch (against the initial one applied) does just
>that.

I've checked this in, too, with some changes.  The version of this file
in CVS had my fix to convert slashes to backslashes so your patch didn't
cleanly apply.  I also allocated a static buffer and only calculated the
DOS pathname for gzip.exe once.  Finally, I changed all of the
formatting to GNU-style.

Thanks for this increased functionality.  I used this to update my own
installation.  It looks like I had somehow damaged my installation a
while ago.  Some files were missing, some package lists were missing.
Who knew?

cgf
