Return-Path: <cygwin-patches-return-2989-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11077 invoked by alias); 17 Sep 2002 09:48:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11059 invoked from network); 17 Sep 2002 09:48:19 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 17 Sep 2002 02:48:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork Part 2
In-Reply-To: <1032254716.17676.185.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209171135350.297-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00437.txt.bz2



On Tue, 17 Sep 2002, Robert Collins wrote:

> On Sat, 2002-08-17 at 06:32, Thomas Pfaff wrote:
> >
> > Some small fixes in the pthread key handling.
> > @@ -1020,16 +1020,27 @@ pthread_key::~pthread_key ()
> >  int
> >  pthread_key::set (const void *value)
> >  {
> > -  /*the OS function doesn't perform error checking */
> > -  TlsSetValue (dwTlsIndex, (void *) value);
> > +  if (dwTlsIndex == TLS_OUT_OF_INDEXES ||
>
> Not needed. dwTlsIndex is not set by anyone outside the class, AND
> if TlsAlloc fails, then we set the magic to 0, causing a failure on
> creation.
>
> Are you covering the situation where the restoreFromSavedBuffer call
> fails? If so, then we should cause the object to destroy itself in that
> call, thus causing the VALID_OBJECT test to fail for future calls from
> userland.
>
> > +      !TlsSetValue (dwTlsIndex, (void *) value))
>
> Please see the MS documentation on this. They explicitly state that they
> perform minimal checking. Also, this should be an assert, as TlsSetValue
> can only fail if you give it an invalid index, and our index is assigned
> by the OS.
>
> > +  if (dwTlsIndex == TLS_OUT_OF_INDEXES)
>
> Ditto to above.
>
> > +    result = TlsGetValue (dwTlsIndex);
>
> And again.
>
> >
> >  void
> > @@ -1884,8 +1895,8 @@ __pthread_setspecific (pthread_key_t key
> >  {
> >    if (verifyable_object_isvalid (&key, PTHREAD_KEY_MAGIC) != VALID_OBJECT)
> >      return EINVAL;
> > -  (key)->set (value);
> > -  return 0;
> > +
> > +  return (key)->set (value);
>
> Not needed, because of the above lack of changes.
> Yes, what you are suggesting is good general programming practice, but
> these are performance critical functions, and we are checking for a
> situation that can't happen short of someone writing into our memory
> space. If that happens, errors are the least of our problems :}.

Agreed, I missed the point where magic is set to 0 if TlsAlloc has failed.
But i would really appreciate if you would apply the patch for
pthread_key::get that removes the set_errno(0) and preserves the WIN32
LastError.
If you configure gcc to use the the pthreads interface for exceptions then
it makes heavy use of pthread_getspecific to read the actual eh context.
Some people might be very surprised when errno and Win32 LastError is
cleared behind her back (It took me 2 days to find the reason for this
about 2 years ago on mingw).

Thomas


