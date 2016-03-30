Return-Path: <cygwin-patches-return-8514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119178 invoked by alias); 30 Mar 2016 19:04:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119151 invoked by uid 89); 30 Mar 2016 19:04:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*yselkowitz, H*M:cygwin, H*F:U*yselkowitz, implications
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 19:04:13 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (Postfix) with ESMTPS id 789E164458	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 19:04:12 +0000 (UTC)
Received: from [10.10.116.17] (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2UJ4BWD018794	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 15:04:12 -0400
Subject: Re: [PATCH 4/6] forkables: Protect fork against dll-, exe-updates.
To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1459364024-24891-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56FC232D.4090006@cygwin.com>
Date: Wed, 30 Mar 2016 19:04:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459364024-24891-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00220.txt.bz2

On 2016-03-30 13:53, Michael Haubenwallner wrote:
> To support in-cygwin package managers, the fork() implementation must
> not rely on .exe and .dll files to stay in their original location, as
> the package manager's job is to replace these files.  Instead, we use
> the hardlinks to the original binaries in /var/run/cygfork/ to create
> the child process during fork, and let the main.exe.local file enable
> the "DotLocal Dll Redirection" feature for dlls.
>
> The (probably few) users that need an update-safe fork manually have to
> create the /var/run/cygfork/ directory for now, using:
> mkdir --mode=a=rwxt /var/run/cygfork

Have the security implications of this been considered?

-- 
Yaakov
