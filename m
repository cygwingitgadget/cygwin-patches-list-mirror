Return-Path: <cygwin-patches-return-2798-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15396 invoked by alias); 7 Aug 2002 21:29:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15381 invoked from network); 7 Aug 2002 21:29:07 -0000
Date: Wed, 07 Aug 2002 14:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: IsBad*Ptr patch
Message-ID: <20020807212905.GC12225@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <040201c23e37$256b0810$6132bc3e@BABEL> <20020807200131.GA9098@redhat.com> <056501c23e54$031f67c0$6132bc3e@BABEL> <20020807210442.GB10258@redhat.com> <05d101c23e57$b9237220$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05d101c23e57$b9237220$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00246.txt.bz2

On Wed, Aug 07, 2002 at 10:16:40PM +0100, Conrad Scott wrote:
>What I meant to say was that the recvmsg(2) and sendmsg(2)
>functions, which are just slightly generalised versions of the
>sendto(2) and recvfrom(2) functions I was discussing, take a
>msghdr struct that contains a `socklen_t *' and a `sockaddr *',
>and in some of the code examples in the Stevens book, he simply
>puts a NULL in the `sockaddr *' and leaves the `socklen_t *' to
>fend for itself.

Wow.  So he treats it as a varargs function.  Interesting.
>> Doh! Answering technical email with a splitting headache during
>> meetings.  Always a sure way to embarrass myself.
>
>Well, that makes two of us w/ headaches this afternoon.  Then
>again, I was just posting out what I'd already written this
>morning, so my disability wasn't so obvious.  Hope both your
>headache and your meeting have passed away by now.

Nah. The headache started at around 6AM, waking me up and it doesn't
seem to want to leave.  That's pretty standard for me.

*bzzt*  Sorry.

>Perhaps I ought to leave it until tomorrow in that case, to give
>Corinna a chance to savour the discussion and veto the patch if
>necessary.

Ok.

At the very least, the removal of const is ok, assuming you can
remove that and not affect the Corinna parts.

cgf
