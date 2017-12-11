Return-Path: <cygwin-patches-return-8964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114621 invoked by alias); 11 Dec 2017 05:06:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114611 invoked by uid 89); 11 Dec 2017 05:06:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=calgary, Calgary, alberta, Alberta
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Dec 2017 05:06:13 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id OGI6ejYvFp2osOGI7eCm42; Sun, 10 Dec 2017 22:06:11 -0700
X-Authority-Analysis: v=2.2 cv=KLEqNBNo c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=N659UExz7-8A:10 a=MxMv7HAkMpoZtxNmY1gA:9 a=pILNOxqGKmIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH setup v4 6/6] Display area and location of official mirrors
To: cygwin-patches@cygwin.com
References: <20171210174930.9960-1-kbrown@cornell.edu> <20171210174930.9960-7-kbrown@cornell.edu> <ff235587-4c67-14f1-5395-fbe36388575a@SystematicSw.ab.ca> <a8e545d2-bb4b-885b-c39c-7a7cc96a7990@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <12db3e6b-cb75-4949-9d8e-ae6bb5d254fa@SystematicSw.ab.ca>
Date: Mon, 11 Dec 2017 05:06:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <a8e545d2-bb4b-885b-c39c-7a7cc96a7990@cornell.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPX6oIuEJj677s6h0poLRMgr2M3oV/HBOjDfg+yGhRL7r6s9l+cpmaG14d1naxxBgF8IDd6DX/rvbzF05XtIg6QtC7csogKvev0LlUCBy6TdIM72w0p8 dnHmGUab82Ab/gMiQNSywqsTgzR2hBiyql5bFf1D61kcekPI1fk9KJmN5xTnzFsgPW44cB675HVmcUV3mhsn8Qpq4zQtAef0TnA=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00094.txt.bz2

On 2017-12-10 11:50, Ken Brown wrote:
> On 12/10/2017 1:40 PM, Brian Inglis wrote:
>> On 2017-12-10 10:49, Ken Brown wrote:
>>> Mirrors from mirrors.lst have area and location info, which we now
>>> display and add to the sort key.
>> You didn't increase the list box width - are the hosts visible without scrolling?
> 
> No, that was an oversight.  I'll fix that locally and use it in future versions
> (or in the commit, if this version is accepted).

You could cherry pick my patch against res.rc as a start to tweak your layouts
and tests.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
