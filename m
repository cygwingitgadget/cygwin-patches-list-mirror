Return-Path: <cygwin-patches-return-8933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12621 invoked by alias); 28 Nov 2017 08:03:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12601 invoked by uid 89); 28 Nov 2017 08:03:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=ham version=3.3.2 spammy=H*c:ISO-8859-1, beforehand, H*u:6.1, H*UA:6.1
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 08:03:32 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vAS83UgD078517	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 00:03:30 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdMjF5kf; Tue Nov 28 00:03:22 2017
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com>
Date: Tue, 28 Nov 2017 08:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20171128075357.224-1-mark@maxrnd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00063.txt.bz2

Mark Geisert wrote:
> ---
>  winsup/cygwin/fhandler_disk_file.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
> index 5dfcae4d9..2ead9948c 100644
[...]

Oops, I neglected to include an explanatory comment. Issuing simultaneous 
pwrite(s) on one file descriptor from multiple threads, as one might do in a 
forthcoming POSIX aio implementation, sometimes results in garbage status in the 
IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforehand made the issue 
go away.

This is mildly concerning to me because there are many other uses of 
IO_STATUS_BLOCK in the Cygwin DLL that haven't seemed to have needed initialization.

Puzzledly,

..mark
