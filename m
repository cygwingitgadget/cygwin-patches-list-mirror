From: Corinna Vinschen <vinschen@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH]: Changes in process startup code
Date: Wed, 28 Jun 2000 10:53:00 -0000
Message-id: <395A3B8C.51C28D47@cygnus.com>
References: <394E5E78.FC4D70F@vinschen.de> <3954F3AC.FA935179@cygnus.com>
X-SW-Source: 2000-q2/msg00114.html

I had to patch that patch another times.

For some reason you can't rely on the process token returning
the correct user information after ImpersonateLoggedOnUser()
is called. Strange thing: It worked for me if the impersonated
user is a simple user without administrator privileges. Not so,
if the impersonated user is member of the admins group.

Yeah, I know what you want to say, but: There's a difference
between the UserToken and the OwnerToken of a process. My user
`corinna' is member of admins and the user SID of my processes
is `corinna' while the owner SID is `administrators'. For some
reason this isn't valid anymore after an impersonation.

internal_getlogin() now uses the impersonation token if
impersonation took place and the process token otherwise.

Corinna

Corinna Vinschen wrote:
> 
> I have just checked in a patch related to that patch:
> 
> - On fork() and spawn() I have copied pointers(!) to SID's from
>   parent to child process. This is corrected now.
> - Before calling LookupAccountName() I try to get the SID from
>   the access token of the current process. This should work for
>   99.999% of all processes and should therefore speed up process
>   startup with ntsec ON quite more. Nevertheless _if_ that fails,
>   it would try the LookupAccountName, though.

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
