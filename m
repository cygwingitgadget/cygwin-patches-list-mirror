Return-Path: <cygwin-patches-return-4632-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6028 invoked by alias); 26 Mar 2004 21:07:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5986 invoked from network); 26 Mar 2004 21:07:18 -0000
X-Authenticated: #623905
Message-ID: <40649B80.4090104@gmx.net>
Date: Fri, 26 Mar 2004 21:07:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [RFA]: Thread safe stdio again
References: <4054B242.9080606@gmx.net> <20040326065008.GA18127@redhat.com> <20040326200326.GA1864@redhat.com>
In-Reply-To: <20040326200326.GA1864@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00122.txt.bz2

Christopher Faylor wrote:
> On Fri, Mar 26, 2004 at 01:50:08AM -0500, Christopher Faylor wrote:
> 
>>On Sun, Mar 14, 2004 at 08:28:02PM +0100, Thomas Pfaff wrote:
>>
>>>This time i am using the non portable mutex initializers, therefore
>>>moving __sinit is no longer needed. And i added calls to newlibs
>>>__fp_lock_all and __fp_unlock_all at fork.
>>>
>>>2004-03-14 Thomas Pfaff <tpfaff@gmx.net>
>>>
>>>	* include/cygwin/_types.h: New file.
>>>	* include/sys/lock.h: Ditto.
>>>	* include/sys/stdio.h: Ditto.
>>>	* thread.cc: Include sys/lock.h
>>>	(__cygwin_lock_init): New function.
>>>	(__cygwin_lock_init_recursive): Ditto.
>>>	(__cygwin_lock_fini): Ditto.
>>>	(__cygwin_lock_lock): Ditto.
>>>	(__cygwin_lock_trylock): Ditto.
>>>	(__cygwin_lock_unlock): Ditto.
>>>	(pthread::atforkprepare): Lock file pointer before fork.
>>>	(pthread::atforkparent): Unlock file pointer after fork.
>>>	(pthread::atforkchild): Ditto.
>>
>>This is ok to check in.  If you hurry, it will show up in 1.5.10.
> 
> 
> I've taken the liberty of checking this patch in myself.
> 

I can't see the new include files in CVS yet.

Greetings,
Thomas
