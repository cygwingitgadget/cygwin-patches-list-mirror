From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 22:45:00 -0000
Message-id: <20010417014600.A29876@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C1@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00089.html

On Tue, Apr 17, 2001 at 03:32:24PM +1000, Robert Collins wrote:
>> -----Original Message-----
>> From: Christopher Faylor [ mailto:cgf@redhat.com ]
>> Sent: Tuesday, April 17, 2001 3:27 PM
>> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
>> Subject: Re: [PATCH] Re: pthread -- Corinna?
>> 
>> 
>> On Tue, Apr 17, 2001 at 02:57:58PM +1000, Robert Collins wrote:
>> >> I won't disagree with the thought of getting rid of 
>> passwd_sem since
>> >> that is what I've been saying from the start.  I don't like the
>> >> idea of allowing a one-off parse of /etc/passwd, though.
>> >
>> >Why not? I'm suggesting that we actually get to check security on
>> >/etc/passwd in calls to getpwnam. Or is that a bad thing?
>> 
>> Not in general, but I know from experience that adding /etc/passwd
>> parsing slows down things badly and people complain.  I still have a
>> nagging feeling that we should be able to do this without resorting to
>> double parsing, too...  It's too late for me to do creative thinking,
>> though.
>
>Sure I agree with that. 
>
>My suggest re: manual parsing was broken. I'm not truely awake myself...
>(We'd re-enter fopen). Further thinking suggests that:
>
>we have two options and one bugfix.
>Bugfix: (We should set a notification on changes to /etc/password and
>reparse it if needed).

Yes.  We should add this as a todo item.  It's been a longstanding goal.

Cygwin could notice when it closes /etc/passwd after writing and reparse
it.  That wouldn't handle the case of people modifying /etc/passwd
via notepad but, nyah! nyah!

We also need to protect /etc/passwd parsing with a global lock.

>1) fail (return -1 or 0).
>2) inform the fopen function that we are bootstrapping our user list,
>don't check security (but user access to /etc/password must still get
>checked).
>
>I don't know the best way to do 2). Telling get_id_from_sid is the wrong
>way IMO. (The point being that on unix, the kernel _always_ has read
>access to files, and thus should always manage to read /etc/passwd.

So, that should be satisfied by my change.  /etc/passwd will be read
correctly when cygwin wants to access it but "user" attempts will fail.

cgf
