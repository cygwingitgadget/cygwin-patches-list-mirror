Return-Path: <cygwin-patches-return-2668-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16163 invoked by alias); 19 Jul 2002 08:51:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16149 invoked from network); 19 Jul 2002 08:51:20 -0000
X-Originating-IP: [194.128.229.100]
From: "Andy Younger" <andylyounger@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: /dev/dsp
Date: Fri, 19 Jul 2002 01:51:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1338UJj1Nsjw6u1qzW00015e7e@hotmail.com>
X-OriginalArrivalTime: 19 Jul 2002 08:51:18.0926 (UTC) FILETIME=[72EAD2E0:01C22F01]
X-SW-Source: 2002-q3/txt/msg00116.txt.bz2

I stopped work on /dev/dsp as I did not require it to do any more. I have a 
couple of outstanding patches to apply (a compatibility fix or 2 and some 
work in decreasing latency (fixes Rocks & Diamonds)). I will see about 
sorting them out.

Read / Write support would be cool, as would /dev/mixer support if your 
feeling brave :-)

Andy.

>From: Corinna Vinschen <cygwin-patches@cygwin.com>
>To: cygwin-patches@cygwin.com
>Subject: Re: /dev/dsp
>Date: Fri, 19 Jul 2002 10:27:47 +0200
>
>On Fri, Jul 19, 2002 at 10:06:12AM +0200, Jacek Trzcinski wrote:
> > 1) Who is really interested - excluding Nicholas :-) - /dev/dsp works in
> > read mode. It will prevent any possible future work to be useless.
>
>Even if other developers aren't that interested, perhaps, I know
>that some users in the cygwin mailing list are interested.
>
> > 2) Do You know whether the author of /dev/dsp (Andy Younger) or other
> > people work or are going to work to solve the problem. I can not
> > guarantee to finish any posiible work from my side
> > in predictable moment in time (a lot of work concerned with my job) so
> > if nobody is going to develop /dev/dsp I could step by step do something
> > to solve /dev/dsp reading problem.
>
>Go ahead!  Andy Younger disappeared months ago for some unknown
>reason so there's not anybody working on that.  And you're not in a
>hurry.  It's all voluntarily!
>
>Corinna
>
>--
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Developer                                mailto:cygwin@cygwin.com
>Red Hat, Inc.




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx
