From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>, "egor duda" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Thu, 27 Sep 2001 07:14:00 -0000
Message-id: <008d01c1475e$e970db70$01000001@lifelesswks>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru> <008301c1475e$afb0c4e0$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00212.html

Oh, and I have no objection to the large patch of mine being rolled back
if need be (if this tomorrow/this weekend isn't soon enough).

Rob

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Sent: Friday, September 28, 2001 12:14 AM
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...


> Ok this is a quick-and-it-couldbe-cleaner patch.
>
> It's interim - this weekend I'll make time to roll the logic
throughout
> thread.cc. The patch doesn't introduce any new issues though, and it
is
> the correct IMO step to solving the issue(s) I was trying to address
> with my last lets-break-cygwin patch.
>
> I have _no_ idea why it worked at all after I built that .dll :}. The
> fault for those wanting the grisly details was that I changed the
> semantics of verifyableobject_isvalid without updating the tests
against
> the return code. Doh.
>
> I'm having some trouble with cvs+ssh with this patch .. though I'm not
> sure why. For a little while I though it might be chris's tuesday
> sleep(1) change, because I was getting strange results from pspec> I'm
> not sure though.
>
> Anyway, I don't have time to complete a binary search now...
>
> What I have established is that the faulty change (other than my
> thread.cc snafu) is sometime between 1am tuesday 25th and now. In
other
> words, a dll built from cvs @tuesday 1am, with the most recent
thread.cc
> and thread.h and this patch seems to run ok. The cond_wait bug seems
> particularly ticklish however, and that may be the cvs+ssh problem I
was
> seeing.
>
> So, you can ignore this blurb :].
>
> I'm not checking this patch in _yet_ as I'm still confirming that
> everything is really ok. I'll have a little time in the office
tomorrow
> to follow up, it's bedtime now though.
>
> Rob
>
> ----- Original Message -----
> From: "egor duda" <deo@logos-m.ru>
> To: "Robert Collins" <robert.collins@itdomain.com.au>
> Cc: <cygwin-patches@cygwin.com>
> Sent: Thursday, September 27, 2001 11:00 PM
> Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
>
>
> > Hi!
> >
> > Thursday, 27 September, 2001 Robert Collins
> robert.collins@itdomain.com.au wrote:
> >
> > >> rscc>         * thread.cc (pthread_cond::BroadCast): Use address
> with
> > RC> verifyable_object_isvalid().
> > >> rscc>         (pthread_cond::Signal): Ditto.
> > >>
> > >> [...]
> > >>
> > >> Robert, i have problems with your last patch. at program startup
> > >> read_etc_passwd() is called recursively and second call blocks at
> > >> pthread_mutex_lock()
>
>
>
>
