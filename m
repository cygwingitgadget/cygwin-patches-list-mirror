Return-Path: <cygwin-patches-return-2795-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12293 invoked by alias); 7 Aug 2002 21:17:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12279 invoked from network); 7 Aug 2002 21:17:59 -0000
Message-ID: <05d101c23e57$b9237220$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <040201c23e37$256b0810$6132bc3e@BABEL> <20020807200131.GA9098@redhat.com> <056501c23e54$031f67c0$6132bc3e@BABEL> <20020807210442.GB10258@redhat.com>
Subject: Re: IsBad*Ptr patch
Date: Wed, 07 Aug 2002 14:17:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00243.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
>
> On Wed, Aug 07, 2002 at 09:50:06PM +0100, Conrad Scott wrote:
> >
> >There's nothing explicitly in there (or SUSv3, which is what
I'm
> >using) but the page only mentions *using* it if the address
> >argument is not null.  Also, the code examples in Stevens's
"Unix
> >Network Programming" for recvmsg(2) simply set the address
pointer
> >to null and leave the length pointer uninitialised, which would
> >make cygwin barf if it were also to check the address length
> >pointer.
>
> I don't have this reference.  How can a pointer be
uninitialized?
>
> Do they do something like
>
> int *len;
> recvmsg(..., NULL, len);
>
> ?
>
> That sounds like bad programming to me, but if that is the
standard
> then ok.

Sorry, I changed system call half-way through the explanation: I
agree w/ you: no-one should do what the obvious interpretation of
my comments would suggest :-)

What I meant to say was that the recvmsg(2) and sendmsg(2)
functions, which are just slightly generalised versions of the
sendto(2) and recvfrom(2) functions I was discussing, take a
msghdr struct that contains a `socklen_t *' and a `sockaddr *',
and in some of the code examples in the Stevens book, he simply
puts a NULL in the `sockaddr *' and leaves the `socklen_t *' to
fend for itself.

> Doh! Answering technical email with a splitting headache during
> meetings.  Always a sure way to embarrass myself.

Well, that makes two of us w/ headaches this afternoon.  Then
again, I was just posting out what I'd already written this
morning, so my disability wasn't so obvious.  Hope both your
headache and your meeting have passed away by now.

> I'm not 100% convinced about the len arguments but go ahead and
check
> this in and we can sort that out later.  I doubt that anyone
would ever
> complain about your changes ("Wah!  I wanted to get a ENOSYS by
passing
> a bad length argument and you wouldn't let me!") so this is
really a
> non-issue.

I suspect I know what I'd be tempted to reply if someone did try
that . . .

> Hopefully Corinna won't mind since this is technically her code
but
> I think you've more than adequately explained things.

Perhaps I ought to leave it until tomorrow in that case, to give
Corinna a chance to savour the discussion and veto the patch if
necessary.

Thanks for the feedback,

// Conrad


