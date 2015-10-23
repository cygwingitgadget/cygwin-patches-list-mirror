Return-Path: <cygwin-patches-return-8264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28046 invoked by alias); 23 Oct 2015 20:00:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28016 invoked by uid 89); 23 Oct 2015 20:00:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 23 Oct 2015 20:00:01 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (Postfix) with ESMTPS id A519A54	for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2015 20:00:00 +0000 (UTC)
Received: from YAAKOV04.redhat.com (ovpn-116-52.rdu2.redhat.com [10.10.116.52])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9NJxwxC027594	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2015 16:00:00 -0400
Message-ID: <1445630415.16064.120.camel@cygwin.com>
Subject: Re: [PATCH] winsup/utils: add CPU cache variables to getconf(1)
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Fri, 23 Oct 2015 20:00:00 -0000
In-Reply-To: <1445535301-15564-1-git-send-email-yselkowi@redhat.com>
References: <1445535301-15564-1-git-send-email-yselkowi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00017.txt.bz2

On Thu, 2015-10-22 at 12:35 -0500, Yaakov Selkowitz wrote:
> * getconf.c (conf_table): Add LEVEL*_CACHE_* variables.
> ---
>  winsup/utils/ChangeLog |  4 ++++
>  winsup/utils/getconf.c | 15 +++++++++++++++
>  2 files changed, 19 insertions(+)

Approved off-list, committed as 505812d.

--
Yaakov

