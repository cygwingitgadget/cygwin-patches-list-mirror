From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 16:54:00 -0000
Message-ID: <20011128005414.GA7118@redhat.com>
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks> <20011128002122.GA6919@redhat.com> <1006907495.2048.25.camel@lifelesswks>
X-SW-Source: 2001-q4/msg00271.html
Message-ID: <20011127165400.d_AWKRA_gE3oFN7aF2iaHiKcvjMfCCmpYLLNVat3zds@z>

On Wed, Nov 28, 2001 at 11:31:35AM +1100, Robert Collins wrote:
>What was your point? That in C++ one should write all equality
>comparisons as foo == or foo != zerovaluedvariableofthesametype for
>clarity?

My point was that is the way I do it.  I obviously do it that way
because I think it is the best way to do things.

Although I disagree with using 0 when testing a pointer, I wouldn't
venture to dictate this style in setup.exe.

And, as always, I'm sorry that I ventured into a discussion about
coding style.  I'll try not to let that happen again, unless it
is to point out a clear violation of GNU coding standards.

cgf
