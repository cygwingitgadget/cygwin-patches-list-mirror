Return-Path: <cygwin-patches-return-2898-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11955 invoked by alias); 30 Aug 2002 22:00:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11900 invoked from network); 30 Aug 2002 22:00:51 -0000
Message-ID: <010e01c25071$1b01bb20$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <000101c24f8e$1a656c40$6132bc3e@BABEL> <20020830151128.I5475@cygbert.vinschen.de> <20020830145127.GD1218@redhat.com> <20020830151232.GA1914@redhat.com> <20020830154922.GB2845@redhat.com>
Subject: Re: Base readv/writev patch
Date: Fri, 30 Aug 2002 15:00:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00346.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> On Fri, Aug 30, 2002 at 11:12:32AM -0400, Christopher Faylor
wrote:
> >On Fri, Aug 30, 2002 at 10:51:27AM -0400, Christopher Faylor
wrote:
> >>On Fri, Aug 30, 2002 at 03:11:28PM +0200, Corinna Vinschen
wrote:
> >>>On Thu, Aug 29, 2002 at 01:06:14AM +0100, Conrad Scott wrote:
> >>>> Attached is the base part of the readv/writev patch I sent
in
> >>>> yesterday, i.e. just the generic syscall.cc and
fhandler_base
> >>>> parts, w/o any of the socket changes.  Otherwise unchanged
from
> >>>> before except for the expunging of those darn new-fangled
C++ cast
> >>>> woojits :-)
>
> I'll be checking this patch in.  I changed a couple of stylistic
things
> for consistency with the rest of the code.
>
> Just as a hint, I really don't like this style of if test:
>
>   if (!(foo == bar && blah != 0))

No problem: I do have trouble with negated conditions, e.g. (!x ||
!y), and I have to put them back into the form "it's not the case
that x && y" every time I read them, so we seem to differ here.
But I know it's not how they're usually written so I can't
complain.

> There does seem to be an issue with zero byte reads, though.
IIRC, you
> are supposed to be able to do this:
>
>   errno = 2;
>   read (0, 0, 0)
>   assert (errno == 2)
>
> i.e., a zero byte read does not check the buffer arguments.
>
> I modified check_iovec_for_* to do this, but I don't know if
this is
> consistent with SUSv3.  It seems to be consistent with linux, at
least.

I'm very glad you caught that Chris, I'm obviously not firing on
all cylinders right now.  It is certainly consistent w/ SUSv3
since readv(2) is defined to be just as per read(2) in such cases,
and an implementation is allowed to have calls such as read
(-1, -1, 0) succeed, i.e. if the length is zero no other error
checking is mandated.  So, thanks for catching this one.

> I've checked this patch in.

Thanks.

// Conrad


