Return-Path: <cygwin-patches-return-4943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 918 invoked by alias); 10 Sep 2004 20:48:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 908 invoked from network); 10 Sep 2004 20:48:51 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Fri, 10 Sep 2004 20:48:00 -0000
In-Reply-To: 
       from MAILER-DAEMON@curl.com (Sep 10,  4:46pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040910204850.AFD08E538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00095.txt.bz2

On Sep 10, 11:55am, byrnes@curl.com ("Bob Byrnes") wrote:
-- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
>
>              ...  I don't use sftp much, but we pump *enormous* amounts
> of data through sshd otherwise, so it's odd that I haven't noticed any
> performance impact.

Interesting.  The problem seems to affect *only* sftp, and (as Corinna
noted) only inbound transfers.  Outbound sftp works fine, as do scp
transfers in both directions, and data sent through ssh in general.

This explains why I haven't noticed the problem; I generally use scp
instead of sftp, because the latter requires SSH protocol 2, and I need
to deal with a variety of machines, some of which still use the older
SSH protocol 1.

> I guess it's possible that my patch interacts badly with some other
> recent submissions; I did most of my testing with an earlier snapshot.
> 
-- End of excerpt from "Bob Byrnes"

I can reproduce the problem with the earlier snapshot too, so it isn't
caused by anything recent.

I'll do some stracing to see what sftp is doing (that scp and ssh are not).

--
Bob
