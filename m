From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [RFD]: uinfo.cc or "all commands start soooooow slow"
Date: Sat, 17 Jun 2000 05:48:00 -0000
Message-id: <394B737C.E597B7BE@vinschen.de>
X-SW-Source: 2000-q2/msg00106.html

In the same context I have a question to you:

> To get full informations about the user, ntsec needs the name of
> the logon domain and the logon server. To get that information,
> the function `internal_getlogin' calls NetWkstaUserGetInfo() and
> NetGetDCName(). If for some reason the machine has no connection
> to it's PDC, this may take a while.

But why are that functions called? Isn't that information
already found in the users environment?

Yes and no.

Yes, if the user is working in a console window or if s/he is
logged in via a service which runs under a regular users account.

No, if s/he is logged in via a service running under LocalSystem
account.

It would be possible to patch internal_getlogin() to do the
following:

  First try to read the environment variables
  LOGONSERVER and USERDOMAIN.

  If they exist:

    Call GetUserName().

  If they don't exist:

    If nontsec: Call GetUserName().

    If ntsec: Call NetWkstaUserGetInfo() and NetGetDCName().

      If they succeed and the username is not SYSTEM:

        Set environment variables LOGONSERVER and USERDOMAIN.

   Go ahead.

I'm sure that this algorithm would speed up also ntsec most
of the time. Above all the last part (setting the variables)
would additionally speed up further sub processes.

But the DISADVANTAGE is: If for some reason an application
or a user decides to set those environment variables to some
illegal values, ntsec would suffer a sort of nerveous breakdown.

The question: Should we try the patch, nevertheless?

Corinna
