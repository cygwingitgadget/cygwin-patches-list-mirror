From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 19:25:00 -0000
Message-id: <20010416222529.A24351@redhat.com>
References: <7F2B9185F0196F44B59990759B91B1C23C35BA@ins-exch.inspirepharm.com> <00b701c0c665$49c99c80$0200a8c0@lifelesswks> <20010416112045.D15438@redhat.com> <005201c0c6be$f8dea2c0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00078.html

On Tue, Apr 17, 2001 at 07:48:00AM +1000, Robert Collins wrote:
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-xfree@cygwin.com>; <cygwin-patches@cygwin.com>
>Sent: Tuesday, April 17, 2001 1:20 AM
>Subject: Re: [PATCH] Re: pthread
>
>
>> On Mon, Apr 16, 2001 at 09:06:27PM +1000, Robert Collins wrote:
>> >Hi Suhaib,
>>>here are the two missing functions.  If you aren't setup to compile
>>>cygwin1.dll let me know and I'll mail you mine.
>>
>>You seem to be adding a mutex that is supplanting the passwd_sem
>>variable.  Shouldn't passwd_sem be eliminated if you are adding this?
>
>No.  passwd_sem is not even a real semaphore.  It's simply used to stop
>security.cc looking calling getpwuid when fopen is called.  Passwd_sem
>as a static variable has almost no overhead on access, a real semaphore
>or a trylock() on the mutex in security.cc will have a performance hit.

I'm not convinced that there aren't two diverse mechanisms trying to
accomplish the same thing here.  Since read_etc_passwd should only be
called when "passwd_state == uninitialized" I assume that the intent of
this code is to avoid calling read_etc_passwd more than once.  This
is already handled by the "passwd_state == uninitialized" test except
if there is an executed race (don't know if this is the correct term).

I don't really understand what the passwd_sem code in security.cc is
trying to do.  It seems to short circuit get_id_from_sid in the case
where this function is called "simultaneously" from two different threads?
Or is this function somehow called recursively from getpwent?

If that is the case, then the "passwd_sem" variable could be local to
security.cc, couldn't it?  As it is implemented now, it seems like
one thread calling getpwent could impact another thread that was
calling get_id_from_sid.

Corinna?

cgf
