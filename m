Return-Path: <cygwin-patches-return-8010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12963 invoked by alias); 4 Aug 2014 02:00:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10681 invoked by uid 89); 4 Aug 2014 02:00:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 04 Aug 2014 02:00:46 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7420jVI007283	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sun, 3 Aug 2014 22:00:45 -0400
Received: from [10.10.116.23] ([10.10.116.23])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7420hHP009193	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Sun, 3 Aug 2014 22:00:44 -0400
Message-ID: <1407117639.2942.3.camel@yselkowitz.redhat.com>
Subject: Re: docs: improve package maintainer instructions
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Mon, 04 Aug 2014 02:00:00 -0000
In-Reply-To: <53DCE738.3090406@redhat.com>
References: <53DCE738.3090406@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00005.txt.bz2

On Sat, 2014-08-02 at 07:27 -0600, Eric Blake wrote:
> I noticed that the main link on the cygwin.com left navbar
> (https://cygwin.com/setup.html#submitting) has outdated instructions;
> rather than duplicate things, I'd rather have a link to the more
> up-to-date page
> (https://sourceware.org/cygwin-apps/package-upload.html).  Okay to push?

A few minor nits:

> +  would be 4.5.13-1, etc). Some packages also use a YYMMDD format for
                                                       ^^^^^^
YYYYMMDD


> -boffo-1.0-1.tar.bz2  boffo-1.0-1-src.tar.bz2  setup.hint
> +boffo-1.0-1.tar.xz  boffo-1.0-1-src.tar.z  setup.hint
                                      ^^^^^^
.tar.xz

Corinna will have to give the final ack.


Yaakov

