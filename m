Return-Path: <cygwin-patches-return-8479-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2589 invoked by alias); 21 Mar 2016 20:41:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1907 invoked by uid 89); 21 Mar 2016 20:41:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=583,7, 5837, Class, HTo:U*cygwin-patches
X-HELO: mail-qk0-f193.google.com
Received: from mail-qk0-f193.google.com (HELO mail-qk0-f193.google.com) (209.85.220.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:41:35 +0000
Received: by mail-qk0-f193.google.com with SMTP id e124so7660164qkc.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:references         :in-reply-to;        bh=ZNySgHAN2f5qNo2/1Si0fS7qoiI4xddKoAYs8ZGmKME=;        b=iGOBYbWg5bJ7vBhENCy82BeskymKhQtSUOuhVQriy5OalEIgIzbgHUcmy6taI0pD0Z         zZanzvsQc0VL+pZ4T3rQGxnLfwqTobz9nurbhve4z/uQo7f2Bb6bU8qez26Cn79pkCPj         YkvKXC/QkTHsJnzWBE5OyxH58UmXjzPkImGvjN0HbZz4YFeAk2ZNh7KzopStlYvFdhDZ         z1wRSLUddiOotfzz2H2EBg3RpiFOp+KHd3h/S1i4Ltt4cF8GTrCmvKczAUNt11xz3fjl         AmS47NGPhoDu1eiE7gOkiZysjS2Vzjc63kRRnv9r/u9sPGV4TXdVJPSEF2QQNepkpSbY         XpLQ==
X-Gm-Message-State: AD7BkJJZjnb1W88qzOAKTFO6sKIZ/4rTPxxZD75+yBi+PAkqlQAG5p3fIjm3WAT6iT+cYg==
X-Received: by 10.55.203.200 with SMTP id u69mr42987390qkl.51.1458592891848;        Mon, 21 Mar 2016 13:41:31 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id d62sm13058572qka.3.2016.03.21.13.41.30        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 13:41:31 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2] Use DnsFree instead of deprecated DnsRecordListFree
Date: Mon, 21 Mar 2016 20:41:00 -0000
Message-Id: <1458592885-15394-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com> <20160321195244.GJ14892@calimero.vinschen.de> <CAOFdcFMbLNOXCNcMYexqqUWa5GS4CyiSgrcjPHuUr7dnnR_ifg@mail.gmail.com> <20160321203437.GN14892@calimero.vinschen.de>
In-Reply-To: <20160321203437.GN14892@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00185.txt.bz2

The latest version of the mingw headers have been updated to make
DnsRecordListFree an alias of DnsFree when targeting Windows XP or later.
Use DnsFree directly, avoiding the wrapper function.

/home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
undefined reference to `DnsFree'

winsup/cygwin/ChangeLog
autoload.cc: Load DnsFree rather then DnsRecordListFree
libc/minires-os-if.cc (cygwin_query): Use DnsFree rather then DnsRecordListFree

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/autoload.cc          | 2 +-
 winsup/cygwin/libc/minires-os-if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 422e2c98..9e6184f 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -583,7 +583,7 @@ LoadDLLfunc (AuthzInitializeContextFromToken, 32, authz)
 LoadDLLfunc (AuthzInitializeResourceManager, 24, authz)
 
 LoadDLLfunc (DnsQuery_A, 24, dnsapi)
-LoadDLLfunc (DnsRecordListFree, 8, dnsapi)
+LoadDLLfunc (DnsFree, 8, dnsapi)
 
 LoadDLLfunc (GetAdaptersAddresses, 20, iphlpapi)
 LoadDLLfunc (GetIfEntry, 4, iphlpapi)
diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 8970e1a..5142e30 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -286,7 +286,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
     rr = rr->pNext;
   }
 
-  DnsRecordListFree(pQueryResultsSet, DnsFreeRecordList);
+  DnsFree(pQueryResultsSet, DnsFreeRecordList);
 
   len = ptr - AnsPtr;
 done:
-- 
2.7.4
