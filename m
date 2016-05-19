Return-Path: <cygwin-patches-return-8564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11713 invoked by alias); 19 May 2016 00:02:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11700 invoked by uid 89); 19 May 2016 00:02:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=sk:emaila, preview, Redhat, Hx-languages-length:2017
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 19 May 2016 00:02:21 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.1])	by glup.org (Postfix) with ESMTPSA id 68FCE854CE;	Wed, 18 May 2016 20:02:18 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org> <56EADD32.4010802@redhat.com> <56EDD62E.3040309@glup.org> <20160320150034.GE24954@calimero.vinschen.de> <20160329124939.GB3793@calimero.vinschen.de> <b45c2cb3-4c76-7213-cfc7-de4e2af79eb4@glup.org> <20160518192310.GB5252@calimero.vinschen.de>
From: john hood <cgull@glup.org>
Message-ID: <e20dfb4f-1a63-f8e7-0120-02c422bf2a7b@glup.org>
Date: Thu, 19 May 2016 00:02:00 -0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0) Gecko/20100101 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160518192310.GB5252@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SW-Source: 2016-q2/txt/msg00039.txt.bz2

On 5/18/16 3:23 PM, Corinna Vinschen wrote:
> Hi John,
> 
> On May  8 16:43, john hood wrote:
>> On 3/29/16 8:49 AM, Corinna Vinschen wrote:
>>> John, ping?
>>
>> Sorry it took so long to reply, but I finally got around to cleaning up
>> the patchset, I've mailed it separately.
> 
> I don't see the patchset anywhere.  Did I miss your mail or did it
> fail to make it to this list?!?

It never made it to the list.  Some aspect of my network's email config
(I still haven't figured out what) caused email sent directly by my
workstation to be dropped by the sourceware.org mail server.  I changed
it to use my mail server instead and that worked.

>> I was pretty frustrated at my
>> slow Windows machine and the friction in dealing with the project,

> What friction?  Was there anything I or others did to alienate you?
> If there's some problem, please also feel free to discuss on the
> #cygwin-developers IRC channel @Freenode.  You're apparently lurking
> anyway.

The slow Windows machine is probably the larger part of that.  It's a
netbook-class machine.  It's very slow; development on it was rather
unpleasant.  I just set up a VM with a Windows 10 preview on a fast
machine-- it's around four times faster.

But also, working with the email-and-patches style of work that you have
here is really considerably more work than working with projects on
GitHub (I'm a maintainer of a project there) or GitLab.  The email
configuration issue above is a good example.  It really is easier for
both contributors and maintainers.  Assuming you have an account,
contributing a change is something like this: push a branch ("fork") to
the website's shared repo, go to its web view, enter your message for
the pull request, click send, and done.   I know Cygwin/Redhat are
unlikely to move to GitHub, but GitLab offers the same basic workflow,
and I would guess 90% of the functionality of GitHub.  I don't want to
over-emphasize this, but it is significant.

regards,

  --jh
