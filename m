From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 22:56:00 -0000
Message-id: <20010417015647.A30342@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EEF5@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00091.html

On Tue, Apr 17, 2001 at 03:41:46PM +1000, Robert Collins wrote:
>> -----Original Message-----
>> From: Christopher Faylor [ mailto:cgf@redhat.com ]
>> Sent: Tuesday, April 17, 2001 3:46 PM
>> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
>> Subject: Re: [PATCH] Re: pthread -- Corinna?
>> 
>> 
>> >
>> >My suggest re: manual parsing was broken. I'm not truely 
>> awake myself...
>> >(We'd re-enter fopen). Further thinking suggests that:
>> >
>> >we have two options and one bugfix.
>> >Bugfix: (We should set a notification on changes to /etc/password and
>> >reparse it if needed).
>> 
>> Yes.  We should add this as a todo item.  It's been a 
>> longstanding goal.
>> 
>> Cygwin could notice when it closes /etc/passwd after writing 
>> and reparse
>> it.  That wouldn't handle the case of people modifying /etc/passwd
>> via notepad but, nyah! nyah!
>> 
>> We also need to protect /etc/passwd parsing with a global lock.
>
>Isn't that what the mutex does? Or do you mean across process's. If you
>mean across process's - why? Doesn't each process hold the parsed table
>separately?

Yeah, you're right.  I must be tired (It's 2AM here).

I was thinking that /etc/passwd was stored in shared memory but that has
been another goal for a future cygwin.

cgf
