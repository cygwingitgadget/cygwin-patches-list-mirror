Return-Path: <cygwin-patches-return-2878-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31994 invoked by alias); 28 Aug 2002 15:06:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31975 invoked from network); 28 Aug 2002 15:06:25 -0000
Message-ID: <000301c24ea4$dc61b870$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL> <20020828123735.B10870@cygbert.vinschen.de>
Subject: Re: Readv/writev patch
Date: Wed, 28 Aug 2002 08:06:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00326.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
>
> On Tue, Aug 27, 2002 at 04:02:43PM +0100, Conrad Scott wrote:
> >
> > I've tried to reduce the size of the patch by sending in some
> > unrelated parts over the last couple of days but I realize
that
> > this is still quite large.  If you'ld like me to split the
patch
> > up (e.g. into the base fhandler part and the socket part),
give me
> > a call and I'll see if I can find the energy to do so;
London's
>
> Yes, please.  Especially I'm reluctant to introduce your changes
> to the sendto and recvfrom implementation since I know there is
> a good reason to use the WinSock1 calls in the non-blocking case
> even though I don't recall why, right now.  Please skip that
> beautyifing patches and just add the readv/writev functionality.

The only issue here is that the recvmsg / sendmsg implementations
I've put in use the WSARecvFrom and WSASendTo winsock2 calls, in
both the blocking and the non-blocking cases, to avoid copying the
iovec buffers by converting them to WSABUFs, which isn't possible
with the winsock1 recvfrom / sendto calls.  These calls are then
used by the fhandler_socket readv / writev calls so if I use the
winsock1 calls for the non-blocking case, there'll be no advantage
to the readv / writev code except for blocking calls.

I can do this (i.e. make sure that only winsock1 calls are used
for non-blocking calls) but it would be advantageous not to do
that.  Can you recall what the good reasons might be not to do so?
I've done quite a bit of testing with this patch and have yet to
find a problem, tho' that doesn't cover everything.  I'll go and
check the mail archives etc. to see if I can find the issue.

> I've just checked in a patch which adds SIGPIPE handling to
> sendto().  I'd appreciate if you could take this into account.

Will do.

> I also don't like these C++ cast operators since the Plain-C
casts
> are doing quite the same but are way easier to read.  Perhaps
I'm
> just old-fashioned.

I rather prefer the C++ cast operators since they're both clearer
and safer: e.g. using a const_cast guarantees that that all you're
doing is removing the const-ness of something.  I've seen too many
bugs before now where someone's added a cast (just to remove a
const or something simple) and then changed the underlying
object's type elsewhere and the cast still works with no complaint
yet is now not doing the right thing at all.  If you're feeling
determinedly old-fashioned I'll take them out but you will have to
realise that it will be with great pain and suffering on my part
:-)

> And as you said, I think it would be wise to split the
fhandler_base
> from the fhandler_socket part.

Well, the sun's shining again today, so I ought to be able to do
that.

> Other than that it looks like a good patch.

Thanks very much.

I'll resubmit the base class changes now and hold back on the
socket changes until we've agreed what to do about the winsock2 vs
non-blocking issue.

Cheers,

// Conrad


