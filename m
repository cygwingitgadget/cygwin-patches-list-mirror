Return-Path: <cygwin-patches-return-2793-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6455 invoked by alias); 7 Aug 2002 21:04:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6420 invoked from network); 7 Aug 2002 21:04:44 -0000
Date: Wed, 07 Aug 2002 14:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: IsBad*Ptr patch
Message-ID: <20020807210442.GB10258@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <040201c23e37$256b0810$6132bc3e@BABEL> <20020807200131.GA9098@redhat.com> <056501c23e54$031f67c0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056501c23e54$031f67c0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00241.txt.bz2

On Wed, Aug 07, 2002 at 09:50:06PM +0100, Conrad Scott wrote:
>There's nothing explicitly in there (or SUSv3, which is what I'm
>using) but the page only mentions *using* it if the address
>argument is not null.  Also, the code examples in Stevens's "Unix
>Network Programming" for recvmsg(2) simply set the address pointer
>to null and leave the length pointer uninitialised, which would
>make cygwin barf if it were also to check the address length
>pointer.

I don't have this reference.  How can a pointer be uninitialized?

Do they do something like

int *len;
recvmsg(..., NULL, len);

?

That sounds like bad programming to me, but if that is the standard
then ok.

>> >@@ -970,7 +978,7 @@
>> > extern "C" struct hostent *
>> > cygwin_gethostbyaddr (const char *addr, int len, int type)
>> > {
>> >-  if (__check_null_invalid_struct_errno (addr, len))
>> >+  if (__check_invalid_read_ptr_errno (addr, len))
>> >     return NULL;
>>
>> Isn't addr writable?  invalid_struct_errno checks that addr is
>in writable
>> memory.
>
>It can't be writable: it's a const char *, and this is exactly one
>of cases I found by changing the signature of the checking
>functions.  The addr is just a key into the hosts database.

Doh! Answering technical email with a splitting headache during
meetings.  Always a sure way to embarrass myself.

>I hope my sprinkled replies have helped sort things out: I've
>spent a while going through the SUSv3 definitions checking these.
>Most of it falls out from the const / non-const state of the
>arguments though.

Yep.  Sorry for the noise.

I'm not 100% convinced about the len arguments but go ahead and check
this in and we can sort that out later.  I doubt that anyone would ever
complain about your changes ("Wah!  I wanted to get a ENOSYS by passing
a bad length argument and you wouldn't let me!") so this is really a
non-issue.

Hopefully Corinna won't mind since this is technically her code but 
I think you've more than adequately explained things.

cgf
