Return-Path: <cygwin-patches-return-3809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22626 invoked by alias); 14 Apr 2003 14:05:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22592 invoked from network); 14 Apr 2003 14:05:37 -0000
Date: Mon, 14 Apr 2003 14:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] enable -finline-functions optimization
Message-ID: <20030414140539.GA28133@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0304091020470.272-200000@algeria.intern.net> <20030409154807.GD5879@redhat.com> <3E9A6F15.6060506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9A6F15.6060506@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00036.txt.bz2

On Mon, Apr 14, 2003 at 10:19:33AM +0200, Thomas Pfaff wrote:
>Christopher Faylor wrote:
>>On Wed, Apr 09, 2003 at 11:03:42AM +0200, Thomas Pfaff wrote:
>>
>>>This patch enables inline optimization for the c++ source files
>>>in winsup/cygwin.
>>>
>>>I tried several attributes for std_dll_init, wsock_init and
>>>unused_sig_wrapper without success, the only working solution was to
>>>change the functions from static to global to avoid its removal.
>>>
>>>And the new_muto in the pwdgrp constructors can not be inlined for more
>>>than one instance.
>>>
>>Sorry but I'm not going to change something that should be a valid static 
>>into
>>a global just to accommodate the compiler.  There should be compiler 
>>attributes
>>which allow this to behave normally.
>
>As i already mentioned i have tried several attributes.
>According to
>http://gcc.gnu.org/onlinedocs/gcc-3.2.1/gcc/Function-Attributes.html
>__attribute__((used)) should do the trick, but it doesn't seem to work.

Look at exceptions.cc: unused_sig_wrapper.

cgf
