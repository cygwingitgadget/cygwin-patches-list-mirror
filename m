Return-Path: <cygwin-patches-return-2128-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7064 invoked by alias); 30 Apr 2002 15:49:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7050 invoked from network); 30 Apr 2002 15:49:05 -0000
Date: Tue, 30 Apr 2002 08:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] dtors run twice on dll detach (update)
Message-ID: <20020430154905.GA27049@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <F0E13277A26BD311944600500454CCD050807A-101000@antarctica.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0E13277A26BD311944600500454CCD050807A-101000@antarctica.intern.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00112.txt.bz2

I finally had some time to review this today and I am still not
completely convinced that this patch is correct.

If we just avoid setting up the destructor calls using atexit then the
destructors will only run once.  So, in the normal case, the destructor
will run after much cleanup has occurred in the cygwin DLL (specifically
in the do_exit function).  This means that the destructor may not be
able to use all of the facilities of cygwin when it is finally executed.

This won't be an issue for the problem below, but I wonder if it is a
problem for other destructors.  I'm not sure what kind of environment
a global destructor is guaranteed to have but I suspect that it should
be a completely normal environment.

Anyone know for sure?  Is there an online reference for this kind of thing?

cgf

On Wed, Apr 17, 2002 at 09:07:32AM +0200, Thomas Pfaff wrote:
>I am sorry for the previous patch, it was incomplete. This is hopefully a
>better one:
>
>On Tue, 16 Apr 2002, Thomas Pfaff wrote:
>
>> I ran into a problem when is was trying to build STLPort-4.5.3 as dll
>> (if
>> somebody is interested i can send him my patches). A program build with
>> this dll crashed in _free_r on termination. After testing a while i
>> discovered that the dtors were run twice, the first time from
>> dll_global_dtors, the second time from dll_list::detach which resulted
>> in
>> a duplicated free for the same pointer.
>> Since i can not judge which function is obsolete (i guess
>> dll_global_dtors
>> is) i have attached a small patch that will make sure that the dtors run
>> only once.
>>
>> Regards
>> Thomas
>>
>> 2002-04-16  Thomas Pfaff  <tpfaff@gmx.net>
>>
>> 	* dll_init.h (per_process::dtors_run): New member.
>> 	* dll_init.cc (per_module::run_dtors): Run dtors only once.
>> 	(dll::init): Initialize dtors_run flag.
>>
>>
>>
>
>

