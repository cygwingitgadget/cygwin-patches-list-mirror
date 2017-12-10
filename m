Return-Path: <cygwin-patches-return-8963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6323 invoked by alias); 10 Dec 2017 18:50:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3721 invoked by uid 89); 10 Dec 2017 18:50:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=scrolling, oversight, HTo:U*cygwin-patches
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 10 Dec 2017 18:50:08 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id vBAIo5rN007732	for <cygwin-patches@cygwin.com>; Sun, 10 Dec 2017 13:50:06 -0500
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id vBAIo4dc027420	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 10 Dec 2017 13:50:05 -0500
Subject: Re: [PATCH setup v4 6/6] Display area and location of official mirrors
To: cygwin-patches@cygwin.com
References: <20171210174930.9960-1-kbrown@cornell.edu> <20171210174930.9960-7-kbrown@cornell.edu> <ff235587-4c67-14f1-5395-fbe36388575a@SystematicSw.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <a8e545d2-bb4b-885b-c39c-7a7cc96a7990@cornell.edu>
Date: Sun, 10 Dec 2017 18:50:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ff235587-4c67-14f1-5395-fbe36388575a@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00093.txt.bz2

On 12/10/2017 1:40 PM, Brian Inglis wrote:
> On 2017-12-10 10:49, Ken Brown wrote:
>> Mirrors from mirrors.lst have area and location info, which we now
>> display and add to the sort key.
> You didn't increase the list box width - are the hosts visible without scrolling?

No, that was an oversight.  I'll fix that locally and use it in future 
versions (or in the commit, if this version is accepted).

Ken
