Return-Path: <cygwin-patches-return-2732-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24028 invoked by alias); 26 Jul 2002 14:59:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24014 invoked from network); 26 Jul 2002 14:59:44 -0000
Date: Fri, 26 Jul 2002 07:59:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
Message-ID: <20020726145955.GD25444@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <016901c2347c$b19f2060$cd6007d5@BRAMSCHE> <017c01c23494$a66d99c0$cd6007d5@BRAMSCHE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017c01c23494$a66d99c0$cd6007d5@BRAMSCHE>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00180.txt.bz2

On Fri, Jul 26, 2002 at 01:07:37PM +0200, Ralf Habacker wrote:
>> > On Thu, Jul 25, 2002 at 09:43:16PM +0200, Ralf Habacker wrote:
>> > >> I do prefer feature-centric ifdefs, but I don't think that adding this
>> > >> particular definition of HANDLE to the windows headers makes sense.
>> > >
>> > >I think too, but you have another solution yet. :-)
>> >
>> > Not my yob.
>> >
>> Why not, you have rich experience in progamming and so on
>>
>To avoid misunderstandings, I only want to say, that I like your
>experience in finding solutions and that you have probably a better
>overview than I .-)

I also get to choose the programming projects that I work on, the last I
checked.

I have politely suggested a couple of alternatives.  Robert Collins has
given you another suggestion.

I don't claim to understand your problem fully but it doesn't seem
insurmountable to me.  You're right that I have a lot of experience in
programming and have probably solved problems like this many times.
Maybe as a hint, I should offer the fact that I've never had to resort
to modifying system headers to fix problems like this.

If I was doing this, I'd isolate all of the Windows calls in a separate
file and use native Windows headers.  Or, I'd create wrapper include
files.

That's about the limit of the amount of debugging of your problem that
I'm willing to give.

I was kind of hoping that I wouldn't have to raise the off-topic flag
but helping people port their projects is clearly not on-topic for this
mailing list.

And, please no arguments about this.  This is it.  Move discussions
off-list please or to cygwin@cygwin, please.

cgf
