Return-Path: <cygwin-patches-return-3024-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19582 invoked by alias); 23 Sep 2002 00:26:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19565 invoked from network); 23 Sep 2002 00:26:10 -0000
Date: Sun, 22 Sep 2002 17:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_daemon merge
Message-ID: <20020923002626.GB21327@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00c601c261a5$da1ac200$6132bc3e@BABEL> <20020922004849.GD4163@redhat.com> <00ec01c2626d$e22aac80$6132bc3e@BABEL> <20020922214546.GA20133@redhat.com> <017201c26283$ac658f50$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017201c26283$ac658f50$6132bc3e@BABEL>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00472.txt.bz2

On Sun, Sep 22, 2002 at 11:01:58PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> Btw, I forgot to mention that the ChangeLog dates should all reflect
>> the checkin time.  I have just changed them to today's date.
>>
>>Also, maybe you already did this, but for future reference, the
>>ChangeLogs should reflect changes to the mainline.  If there was a lot
>>of churning on the branch, it shouldn't be reflected in the mainline
>>ChangeLog, since the mainline only sees the end result.
>
>Thanks for patching the dates for me and sorry for the bother.

No problem.  It's not like the rules are actually written down anywhere.
As you can see, I only remember some of this when I actually see stuff
checked in.  FWIW, much of what I do in Cygwin comes from being told the
rules in gdb or gcc when I screwed something up over there.

The "use the date of checkin" is a case in point.

>I just followed the example of one of the previous merges that I found
>in the archives, but I did wonder whether I'd done the right thing with
>the ChangeLog (I just copied across all the entries from the branch w/o
>altering them).  I'll go through it some point in the next couple of
>days and see if I can slim it down to better reflect the final result,
>since there certainly was quite a lot of churn at one point. I'll aim to
>do more frequent merges in future now that I've got the hang of it; that
>should make the process rather easier too.

I really don't think it is worth your time to clean this up.

Is there any reason why you can't continue development on the mainline
now?

cgf
