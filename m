Return-Path: <cygwin-patches-return-7942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3664 invoked by alias); 8 Jan 2014 18:02:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3646 invoked by uid 89); 8 Jan 2014 18:02:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mout.perfora.net
Received: from mout.perfora.net (HELO mout.perfora.net) (74.208.4.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 18:02:55 +0000
Received: from JamesJPC (host-68-169-174-134.VABOLT1.epbfi.com [68.169.174.134])	by mrelay.perfora.net (node=mrus2) with ESMTP (Nemesis)	id 0MS5go-1VqcO91ITa-00SgCb; Wed, 08 Jan 2014 13:02:52 -0500
From: "James Johnston" <JamesJ@motionview3d.com>
To: <cygwin-patches@cygwin.com>
References: <037b01cf00fc$11014c10$3303e430$@motionview3d.com> <20131225041237.GA6930@ednor.casa.cgf.cx>
In-Reply-To: <20131225041237.GA6930@ednor.casa.cgf.cx>
Subject: RE: Patch to optionally disable overlapped pipes
Date: Wed, 08 Jan 2014 18:02:00 -0000
Message-ID: <07dc01cf0c9b$93dea560$bb9bf020$@motionview3d.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00015.txt.bz2

> -----Original Message-----
> From: Christopher Faylor
> Sent: Wednesday, December 25, 2013 04:13
>
> On Tue, Dec 24, 2013 at 11:01:21PM -0000, James Johnston wrote:
> >Hi,
> >
> >As I have recently mentioned on the main Cygwin mailing list, Cygwin by
> >default creates FILE_FLAG_OVERLAPPED named pipes for the standard file
> >handles (stdin/stdout/stderr).  These overlapped pipes require all
> >programs using ReadFile/WriteFile to use overlapped I/O when using the
> pipes.
> 
> Thanks for the patch but Cygwin has been using overlapped I/O with pipes
> for many years.  They are a requirement for proper operation with signals.
> We try to be very sparing when adding new options and we're not going to
> add an option to make things work less reliably.

Alright, so what is the solution to my problems (outlined on the main cygwin
list) if not this patch?  I have been using it for a few weeks with no ill
effects.  It fixed all the problems I was having.  Signals work fine, as far
as I can tell.  I think this is going to be something that will benefit
other users.  Can I modify the patch to make it acceptable?  An analysis of
why I think the patch is harmless is below...

The function I modified is fhandler_pipe::create(fhandler_pipe**, unsigned,
int).  This function is a thin wrapper around a more specific
fhandler_pipe::create(LPSECURITY_ATTRIBUTES, PHANDLE, PHANDLE, DWORD, const
char*, DWORD open_mode) with default values for some of the parameters for
that more specific function, and it passes FILE_FLAG_OVERLAPPED by default.
My change involved optionally removing FILE_FLAG_OVERLAPPED from the
default.

Critically, my change does NOT affect any code that uses the
fhandler_pipe::create overload that takes 6 parameters.  If anyone still
wants an overlapped pipe, they can still pass FILE_FLAG_OVERLAPPED to the
create function that takes 6 parameters.  And as it turns out, Cygwin
already does this.  I searched, and checked each place fhandler_pipe::create
is called:

JamesJ at JamesJ-PC /d/AppData/Local/Temp/cygwin-snapshot-20131219-1
$ grep -r "fhandler_pipe::create" .
<snip changelogs and comments>

./winsup/cygwin/fhandler_fifo.cc:  fhandler_pipe::create (sa_buf, (r), (w),
0, fnpipe (), open_mode)
./winsup/cygwin/fhandler_tty.cc:  res = fhandler_pipe::create (&sec_none,
&get_io_handle (), &to_master,
./winsup/cygwin/miscfuncs.cc:  int ret = fhandler_pipe::create (sa, hr, hw,
0, NULL,
./winsup/cygwin/sigproc.cc:  DWORD err = fhandler_pipe::create (sa,
&my_readsig, &my_sendsig,
./winsup/cygwin/tty.cc:  return fhandler_pipe::create (&sec_none, &r, &w,
^--- all the above use 6 parameter overload: they may or may not specify
overlapped pipe today, and my change does NOT affect this code in ANY way.

./winsup/cygwin/pipe.cc:  int res = fhandler_pipe::create (fhs, psize,
mode);
^--- the pipe_worker function uses 3 parameter overload, so it will be
affected by the new pipe_nooverlap flag and may not get an overlapped pipe.
pipe_worker is a static function and is used by the POSIX _pipe, pipe, and
pipe2 functions.

From the above, we can see that the ONLY code that is affected by my change
is the pipe_worker function, which is used by the POSIX functions for
creating a pipe.  And from further grepping, I couldn't find any places
where Cygwin was using the POSIX pipe functions for purposes other than
implementing other POSIX functions and in libc.

Some counterpoints:

 * From the above search, signal handling code in places like sigproc.cc and
miscfuncs.cc are clearly unaffected, because they use the 6 parameter
overload, which I didn't modify.  If you pass FILE_FLAG_OVERLAPPED to that
function, it will still work and give you an overlapped pipe.

 * Just to test your hypothesis that I broke signals, I copied a few sample
programs off the Internet that use simple signal handling (e.g. custom
Ctrl+C handler, handler for user signal sent from kill).  Everything worked
as expected, nothing looks broken.  If signal handling is broken, I have yet
to find out how!

 * From a practical standpoint, I've been using this for a few weeks now
since I sent the original message.  I haven't had any problems.  And the
.NET programs I was calling work fine now, whereas they did not previously.
It has only benefitted me, with no problems.  I suspect it would benefit
other users as well.

 * Suppose someone does create a non-overlapped pipe, and then tries to do
overlapped I/O on it.  The Win32 API documentation says this should work,
just that the operation will complete synchronously instead of
asynchronously.  Note that this is a situation that has to be considered
anyway when doing asynchronous I/O in Win32: ReadFile/WriteFile says that
the operation may or may not complete synchronously on an asynchronous file
handle.  It is *not* undefined behavior to do overlapped I/O on a
non-overlapped file handle - it is 100% supported - it will just be
synchronous.  In fact, there is an MSKB article about it:
http://support.microsoft.com/kb/156932/en-us

 * I am not a POSIX expert so I don't know every every single API call that
might possibly want to use asynchronous overlapped I/O on a Win32 file
handle, such as the ones returned by pipe/pipe2.  But the obvious would be
POSIX asynchronous I/O.  But Cygwin doesn't even implement these API calls;
all the aio functions in aio.c just return an error code.  Obviously, they
are not widely used in the wild.  If Cygwin did implement POSIX asynchronous
I/O in the future, it would seem that overlapped pipes would then be
required, and the pipe_nooverlap option might be useful for these rare
situations.

 * Why allow the pipe_byte option but not the pipe_nooverlap option?  Both
are required to properly support calling non-Cygwin programs.  If it is
really an issue to add a new CYGWIN flag, I suggest one of the following:
        * Combine the two flags into one, to be used by users who invoke
non-Cygwin programs.
        * Always assume pipe_nooverlap is set, and remove the flag - since
it appears that there won't be any breaking changes anyway.  It can be added
later if POSIX async I/O is implemented.

Best regards,

James Johnston
