Return-Path: <cygwin-patches-return-4756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14080 invoked by alias); 14 May 2004 18:05:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14005 invoked from network); 14 May 2004 18:05:53 -0000
Date: Fri, 14 May 2004 18:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040514180553.GB10458@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com> <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com> <20040514042403.GA20769@coe.bosbc.com> <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com> <20040514162017.GA21214@coe.bosbc.com> <Pine.CYG.4.58.0405141205590.3944@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405141205590.3944@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00108.txt.bz2

On Fri, May 14, 2004 at 12:40:35PM -0500, Brian Ford wrote:
>On Fri, 14 May 2004, Christopher Faylor wrote:
>
>> On Fri, May 14, 2004 at 10:59:42AM -0500, Brian Ford wrote:
>> >I'll cook up a muto based solution in the next few minutes now
>> >that I understand your preference.  But, I'd like an opinion on the
>> >question above.
>>
>> Thanks very much for the offer, but please don't bother.
>
>Ok, good.  I got sucked into an unscheduled meeting anyway.
>
>> I took this opportunity to do some of the cleanup that I was talking
>> about.  I also implemented a "close handle on final use" option to mutos
>> so that the event doesn't stay around after the final thread releases
>> it.
>
>That sounds like a nice, but difficult to get right enhancement.
>
>> I need to do a little debugging on what I have but it does try to clean
>> up the windows code slightly.  I even eliminated the thread event
>> synchronization entirely.
>
>I tried to do that but got stuck when I discovered you can't pass the
>return from CreateWindow in one thread to the GetMessage call in another.
>
>I look forward to seeing what you did and learning from it.  Thanks.

Well, maybe I didn't do anything, since that is exactly what I did after
investigating MSDN.  I thought I remembered that this was the case but
I couldn't see anything in MSDN which supported it.  I suppose I should
just have trusted Sergey on this one.

So, nevermind on this wonderful enhancement.

cgf
