From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH]: New method for implementing daemons which setuid
Date: Fri, 16 Jun 2000 12:37:00 -0000
Message-id: <394A81E6.7093F438@vinschen.de>
References: <3948DECA.D55BD113@vinschen.de>
X-SW-Source: 2000-q2/msg00104.html

Hi!

I have checked in that patch with some changes and enhancements.

The names of the functions are

cygwin_logon_user() and
cygwin_set_impersonation_token() now.

and above all the new patch now takes care for the difference
between effective and real uid/gid.

seteuid, setegid set the effective id's,
setuid, setgid set effective and real id's.

So the behaviour is now very similar to Linux. The difference
is, that it's nevertheless possible to change the effective
and real uid's again after using setuid to change to a non-
privileged user context. This is Windows. I could add some
code to disallow that but it's nevertheless possible. The
application could call RevertToSelf by itself and all would be
invalidated.

I have a patch to unistd.h which provides prototypes for
seteuid/setegid but they are in the loop yet.

At home I have patched sshd, ftpd and login to use that new
interface and they work as expected with much less special
cygwin code.

My below given description isn't that correct:

Corinna Vinschen wrote:
> my new patch implements two new functions in cygwin:
> 
> - HANDLE logon_user(const struct passwd *pw, const char *password)
> 
>   Uses the given inforamtion to call LogonUser. The function
>   takes all additional fields in pw->pw_gecos into account,
>   the SID (S-...) as well as the U-domain\user info.
>   The function returns the access token for the new user
>   or INVALID_HANDLE_VALUE if it fails.
> 
> - void set_impersonation_token(const HANDLE token)
> 
>   This function sets the internal new token field to the
>   value of the argument. The function itself doesn't
>   impersonate the process, but that is now done by a
>   later call to
> 
>         setuid(uid);

Should be: seteuid(uid);

>   Another call to
> 
>         setuid(previous_uid)

Should be: seteuid(getuid ());

The same for the rest of the description.

>   resets the impersonation. This minimizes the porting effort
>   for applications which care for different users, in my case
>   ftpd, login, sshd.
> 
>   If it's absolute sure, that the impersonation isn't used
>   anymore, the application should call
> 
>         set_impersonation_token(INVALID_HANDLE_VALUE);
> 
> Further benefits of that patch is that fork() and exec()
> calls now care for a given impersonation by themselves:
> A ported application doesn't need to call `sexec' anymore
> to change the user context for a child process so this
> additionally simplifies porting.
> 
> Without that patch:
> 
>    logon:
>         ~40 lines of logon code!!!
> 
>    preparations in new users context:
> 
>         if (winnt)
>                 ImpersonateLoggodOnUser(user_token);
>         setuid(new_uid);
>         ...
>         setuid(prev_uid);
>         if (winnt)
>                 RevertToSelf();
> 
>    calls to exec:
> 
>         if (winnt)
>                 RevertToSelf();
>                 sexec(user_token, ...);
>         else
>                 exec(...);
> 
>    parent cleanup:
> 
>         if (user_token != INVALID_HANDLE_VALUE)
>                 CloseHandle(user_token);
> 
> With that patch:
> 
>   logon:
>         user_token = logon_user(pw, password);
>         set_impersonation_token(user_token);
> 
>    preparations in new users context:
> 
>         setuid(new_uid);
>         ...
>         setuid(prev_uid);
> 
>    calls to exec:
> 
>         exec(...);
> 
>    parent cleanup:
> 
>         set_impersonation_token(INVALID_HANDLE_VALUE);
> 
> I haven't yet checked in that patch because I want to get
> a bit of opinions from you and (hopefully) somebody is
> somewhat gutsy to try that patch!
> 
> Another problem is, that I don't know in which header file
> the two new functions should be prototyped. Help!!!

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
