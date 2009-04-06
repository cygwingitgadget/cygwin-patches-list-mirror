Return-Path: <cygwin-patches-return-6484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18556 invoked by alias); 6 Apr 2009 22:31:19 -0000
Received: (qmail 18542 invoked by uid 22791); 6 Apr 2009 22:31:18 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 06 Apr 2009 22:31:12 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by out1.messagingengine.com (Postfix) with ESMTP id 04EDC3127A2 	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2009 18:31:10 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])   by compute1.internal (MEProxy); Mon, 06 Apr 2009 18:31:10 -0400
Received: by web8.messagingengine.com (Postfix, from userid 99) 	id D9DEFBC9F6; Mon,  6 Apr 2009 18:31:09 -0400 (EDT)
Message-Id: <1239057069.29689.1309282315@webmail.messagingengine.com>
From: "Charles Wilson" <cygwin@cwilson.fastmail.fm>
To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: Re: [PATCH] fstat() problem in libc/rexec.cc
Date: Mon, 06 Apr 2009 22:31:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00026.txt.bz2

Corinna Vinschen wrote:
>On Apr  6 13:20, Earl Chew wrote:
>> The current implementation of rexec() uses fstat() and it seems
>> to pick up the wrong values for st_mode. As a consequence
>> the code keeps complaining about the permissions for ~/.netrc
>> and won't complete successfully.
>>
>> I don't know enough about the how the re-mapping of stat/stat64
>> works within cygwin1.dll itself, but changing to fstat64()
>> like libc/iruserok.c resolves the problem.
>
> That's exactly the right thing to do.  The mapping from fstat to fstat64
> only works for applications and libs linked against Cygwin, not within
> Cygwin itself.  So the call to fstat in rexec calls the old fstat
> function which uses the old backward compatible style struct stat with
> different member sizes.  This explains that the mode bits are not
> correct.  I really thought I had catched them all, but this slipped
> through my cracks, apparently :}

I think this should also fix the (long-standing) problem documented in
the rexecd section of /usr/share/doc/Cygwin/inetutils*README:

  I verified that the REXEC_USER/REXEC_PASS variables work, but
  cygwin's rcmd() implementation is problematic. It complained that my
  ~/.netrc file was readable by others, and refused to use it; however,
  the permissions were 0600.  I did not track this down further.

--
Chuck


