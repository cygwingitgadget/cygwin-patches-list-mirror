Return-Path: <cygwin-patches-return-3811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16286 invoked by alias); 14 Apr 2003 18:04:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16277 invoked from network); 14 Apr 2003 18:04:19 -0000
Date: Mon, 14 Apr 2003 18:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] enable -finline-functions optimization
Message-ID: <20030414180421.GB31904@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0304091020470.272-200000@algeria.intern.net> <20030409154807.GD5879@redhat.com> <3E9A6F15.6060506@gmx.net> <20030414140539.GA28133@redhat.com> <3E9AC616.8040905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9AC616.8040905@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00038.txt.bz2

On Mon, Apr 14, 2003 at 04:30:46PM +0200, Thomas Pfaff wrote:
>Christopher Faylor wrote:
>>On Mon, Apr 14, 2003 at 10:19:33AM +0200, Thomas Pfaff wrote:
>>
>>>According to
>>>http://gcc.gnu.org/onlinedocs/gcc-3.2.1/gcc/Function-Attributes.html
>>>__attribute__((used)) should do the trick, but it doesn't seem to work.
>>
>>Look at exceptions.cc: unused_sig_wrapper.
>
>Look at my patch: unused_sig_wrapper is removed when the code is 
>compiled with -finline-functions.
>
>I tried
>static void unused_sig_wrapper () __attribute__((const, used, noinline));
>
>and __attribute__((used)) should prevent the removal, but it didn't.

Ok.  In that case the final answer is that I'm not going to sacrifice
correct code to gcc bugs.  The attribute stuff used to be sufficient to
cause the functions to be kept.  At one point, aliasing the function
also kept the function around, if you want to try that.  I don't mind
hiding stuff in a macro.  I just don't want to have to comment every
should-be-static function in cygwin with a "I know it looks like it
should be static but it can't be really."

cgf
