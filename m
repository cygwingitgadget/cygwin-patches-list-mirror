Return-Path: <cygwin-patches-return-1663-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6322 invoked by alias); 7 Jan 2002 22:17:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6273 invoked from network); 7 Jan 2002 22:17:54 -0000
Date: Mon, 07 Jan 2002 14:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: getsem cleanup
Message-ID: <20020107221750.GA11086@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <013601c19784$1f95c1f0$0200a8c0@lifelesswks> <20020107164140.GA4029@redhat.com> <01dc01c197c8$314603d0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01dc01c197c8$314603d0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00020.txt.bz2

On Tue, Jan 08, 2002 at 09:11:00AM +1100, Robert Collins wrote:
>
>===
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>
>> If I'm reading the patch correctly, it changes the behavior of cygwin
>so
>> that cygwin will output an error in the case of a failing
>OpenSemaphore.
>> That's not right.  The current behavior is correct.  The only time you
>> should see an error is when the process is creating a semaphore for
>> itself.  It should always be able to do that.
>>
>> I'll clean up the code in getsem a little to make this more obvious.
>
>Ok. I thought there was a bug because the error line has
>p ? "open" : "create" :}

That's a holdover from earlier code.

>Te error line only goes to strace in any event...

system_printf goes to the screen.

cgf
