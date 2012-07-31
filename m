Return-Path: <cygwin-patches-return-7689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4911 invoked by alias); 31 Jul 2012 21:01:23 -0000
Received: (qmail 4895 invoked by uid 22791); 31 Jul 2012 21:01:21 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_05,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 31 Jul 2012 21:01:03 +0000
Received: (qmail 77732 invoked by uid 13447); 31 Jul 2012 21:01:02 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.210.206.56])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 31 Jul 2012 21:01:02 -0000
Message-ID: <5018478E.5080308@etr-usa.com>
Date: Tue, 31 Jul 2012 21:01:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: rebaseall info out of date
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00010.txt.bz2

This paragraph in the rebase package README:

> Note that rebaseall is only a stop-gap measure.  Eventually the rebase
> functionality will be added to Cygwin's setup.exe, so that rebasing will
> happen automatically.

...should be rewritten.  I propose: "You should not need to run 
rebaseall by hand.  setup.exe has done so automatically at the end of 
each installation since Mumble 2012."  (May?  April?)

A similar thing is going on in FAQ item 4.44.  I think that FAQ item 
should be split in two, with all the rebasing related stuff answering a 
new FAQ item, "Why does Cygwin need rebasing?", refocused on talking 
about what setup.exe/rebaseall now does automatically and why.  FAQ item 
4.44 will then talk about the remaining reasons fork() can fail, and 
their possible fixes.

And while I'm proposing work for other people :) is there a better 
reason program usage info is in the README instead of man pages, besides 
lack of time or interest?  In trying to answer the question "Why do we 
need rebasing?" for myself, I first tried "man rebase".  (Yes, I did 
eventually answer the question to my satisfaction.)
