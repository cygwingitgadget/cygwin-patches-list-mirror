Return-Path: <cygwin-patches-return-7233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29664 invoked by alias); 31 Mar 2011 18:38:49 -0000
Received: (qmail 29472 invoked by uid 22791); 31 Mar 2011 18:38:46 -0000
X-SWARE-Spam-Status: No, hits=0.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from idcmail-mo2no.shaw.ca (HELO idcmail-mo2no.shaw.ca) (64.59.134.9)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 31 Mar 2011 18:38:38 +0000
Received: from pd5ml1no-ssvc.prod.shaw.ca ([10.0.153.166])  by pd7mo1no-svcs.prod.shaw.ca with ESMTP; 31 Mar 2011 12:38:36 -0600
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=37qdrPIVUooonMxFi2BWZ8DhoCRe+hJcgJuumZcJ4K8= c=1 sm=1 a=jVez_htjv6wA:10 a=BLceEmwcHowA:10 a=8nJEP1OIZ-IA:10 a=wi9kAKA+fiYZnSEx9GZxBw==:17 a=P6N8diKbVpeAN9dHhf0A:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Received: from unknown (HELO localhost.bogomips.com) ([24.86.25.152])  by pd5ml1no-dmz.prod.shaw.ca with ESMTP; 31 Mar 2011 12:38:36 -0600
Received: from [0.0.0.0] (bogomips [127.0.0.1])	by localhost.bogomips.com (8.14.3/8.14.3/Debian-4) with ESMTP id p2VIcZHx009148	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)	for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2011 11:38:36 -0700
Message-ID: <4D94CA2F.8000308@bogomips.com>
Date: Thu, 31 Mar 2011 18:38:00 -0000
From: John Paul Morrison <jmorrison@bogomips.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch for icmp.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00088.txt.bz2


1. OK, so the preferred solution to use the BSD header files?

2. #define _CYGWIN_ICMP_H looks like the right convention

3. AFAIK, you need admin rights in Unix to use raw/icmp sockets, at 
least I thought that was the reason ping and traceroute were setuid.
I think the details are good to document and are certainly helpful for 
porting, but I'm assuming they wouldn't change the header files.
