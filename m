Return-Path: <cygwin-patches-return-3205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22858 invoked by alias); 19 Nov 2002 01:24:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22844 invoked from network); 19 Nov 2002 01:24:18 -0000
Date: Mon, 18 Nov 2002 17:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Implementation of functions in netdb.h
Message-ID: <20021119012449.GC17408@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDA11BD.5862.1E11B85E@localhost> <3DDA4796.3417.1EE40D05@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDA4796.3417.1EE40D05@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00156.txt.bz2

On Tue, Nov 19, 2002 at 02:15:50PM +1300, Craig McGeachie wrote:
>On 18 Nov 2002 at 17:57, Christopher Faylor wrote:
>> Why?
>
>I am looking for house and job, and staying with a friend, who runs a 
>small LAN, shares the dialup connection, and is sufficiently paranoid 
>to run a firewall setup with mail and HTTP relaying (amongst others) - 
>no exceptions.

I'm not sure how you are going to be able to maintain this if you can't
build from CVS.  If a fix is needed, you'll need to be able to make it
to the CVS sources.  I appreciate the work you've put into this but I
do see a problem here.

>> but I will note that putting a "Cygwin internal" comment in front of
>> static functions isn't adding any useful information. 
>
>I need more comments anyway.  Just testing the water before I go all 
>out adding them.  I put "Cygwin internal" in because that is what I saw 
>in net.cc, and I thought it might be some sort of standard.

I never noticed those comments before.  They're gone now.

>> Otherwise, from a cursory glance, it looks fine.  You will definitely
>> need to send in an assignment.
>
>Will do.  It'll take maybe a week to arrive from New Zealand.  In the 
>meantime I have to tidy up the submission a bit.
>
>I've tried to compile the source for Cygwin 1.3.15-2 prior to putting 
>netdb.cc in, but I am having problems with fhandler_serial.cc.  With 
>the rewrite of fhandler_serial::ioctl, and the inclusion of 
>ddk/ntddser.h, I can no longer compile.  I have copy of the W2K DDK, 
>and tried pointing the compiler at the include directory there, but 
>unsurprisingly this doesn't work.  Is there a Cygwin version of the DDK 
>headers that I should use, in the same way that w32api provides a 
>Cygwin version of the Win32 SDK headers?

The sources in the release need the *CVS* version of w32api.  See?  Problems
already.

cgf
