Return-Path: <cygwin-patches-return-3022-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13208 invoked by alias); 22 Sep 2002 21:45:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13194 invoked from network); 22 Sep 2002 21:45:31 -0000
Date: Sun, 22 Sep 2002 14:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_daemon merge
Message-ID: <20020922214546.GA20133@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00c601c261a5$da1ac200$6132bc3e@BABEL> <20020922004849.GD4163@redhat.com> <00ec01c2626d$e22aac80$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ec01c2626d$e22aac80$6132bc3e@BABEL>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00470.txt.bz2

On Sun, Sep 22, 2002 at 08:25:59PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> On Sat, Sep 21, 2002 at 08:34:06PM +0100, Conrad Scott wrote:
>> >The attached patch is the (small) subset of the cygwin_daemon merge
>that
>> >I need clearance on.
>>
>> Looks ok.  Go ahead and check it in.
>
>Thanks: it's in now.  Sorry for the mangled Makefile formatting: I'd
>forgotten I'd done that.

Btw, I forgot to mention that the ChangeLog dates should all reflect
the checkin time.  I have just changed them to today's date.

Also, maybe you already did this, but for future reference, the ChangeLogs
should reflect changes to the mainline.  If there was a lot of churning
on the branch, it shouldn't be reflected in the mainline ChangeLog,
since the mainline only sees the end result.

cgf
