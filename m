Return-Path: <cygwin-patches-return-4353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3507 invoked by alias); 10 Nov 2003 15:30:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3498 invoked from network); 10 Nov 2003 15:30:19 -0000
Date: Mon, 10 Nov 2003 15:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdio initialization
Message-ID: <20031110153018.GA12119@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0311101211450.1520-200000@algeria.intern.net> <20031110135740.GA12455@redhat.com> <3FAF9A9A.3070509@gmx.net> <20031110150952.GA10851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110150952.GA10851@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00072.txt.bz2

On Mon, Nov 10, 2003 at 10:09:52AM -0500, Christopher Faylor wrote:
>On Mon, Nov 10, 2003 at 03:03:06PM +0100, Thomas Pfaff wrote:
>>Christopher Faylor wrote:
>>>On Mon, Nov 10, 2003 at 12:23:35PM +0100, Thomas Pfaff wrote:
>>>
>>>>Attached patch fixes the memory leak reported by Arash Partow by
>>>>initializing stdio during startup and setting __sdidinit from thread
>>>>local clib appropriately.
>>>>
>>>>Thomas
>>>>
>>>>2003-11-10  Thomas Pfaff  <tpfaff@gmx.net>
>>>>
>>>>	* dcrt0.cc: Add prototype for __sinit.
>>>>	(dll_crt0_1): Initialize stdio.
>>>
>>>
>>>The above two things are already done in dcrt0.cc.  Why are you adding
>>>additional prototypes and going to additional work?
>>>
>>
>>Ouch. I should have stayed in bed today.
>
>But the rest of your patch looks ok, I think, doesn't it?

Actually, on poking around a little, I wonder if we should be calling
_reclaim_reent to get back all of the stuff allocated in the REENT
structure?

cgf
