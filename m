From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-xfree@cygwin.com>
Subject: RE: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 22:49:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EEF5@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00090.html

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Tuesday, April 17, 2001 3:46 PM
> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
> Subject: Re: [PATCH] Re: pthread -- Corinna?
> 
> 
> >
> >My suggest re: manual parsing was broken. I'm not truely 
> awake myself...
> >(We'd re-enter fopen). Further thinking suggests that:
> >
> >we have two options and one bugfix.
> >Bugfix: (We should set a notification on changes to /etc/password and
> >reparse it if needed).
> 
> Yes.  We should add this as a todo item.  It's been a 
> longstanding goal.
> 
> Cygwin could notice when it closes /etc/passwd after writing 
> and reparse
> it.  That wouldn't handle the case of people modifying /etc/passwd
> via notepad but, nyah! nyah!
> 
> We also need to protect /etc/passwd parsing with a global lock.

Isn't that what the mutex does? Or do you mean across process's. If you
mean across process's - why? Doesn't each process hold the parsed table
separately?
 
> >1) fail (return -1 or 0).
> >2) inform the fopen function that we are bootstrapping our user list,
> >don't check security (but user access to /etc/password must still get
> >checked).
> >
> >I don't know the best way to do 2). Telling get_id_from_sid 
> is the wrong
> >way IMO. (The point being that on unix, the kernel _always_ has read
> >access to files, and thus should always manage to read /etc/passwd.
> 
> So, that should be satisfied by my change.  /etc/passwd will be read
> correctly when cygwin wants to access it but "user" attempts 
> will fail.

I thought your change will cause fails if cygwin is reading it, even if
the request came from a user?
 
> cgf
> 
