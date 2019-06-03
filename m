Return-Path: <cygwin-patches-return-9430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35924 invoked by alias); 3 Jun 2019 20:18:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35915 invoked by uid 89); 3 Jun 2019 20:18:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=tuesday, Tuesday, calgary, Calgary
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 20:18:26 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id XtPSheuJ9GusjXtPUhYPJX; Mon, 03 Jun 2019 14:18:24 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] cygcheck: expand common_apps list
To: cygwin-patches@cygwin.com
References: <20190523170532.64113-1-yselkowi@redhat.com> <20190603193519.GP3437@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <f3e248e5-856a-3570-b595-ed0ea3c33124@SystematicSw.ab.ca>
Date: Mon, 03 Jun 2019 20:18:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603193519.GP3437@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00137.txt.bz2

On 2019-06-03 13:35, Corinna Vinschen wrote:
> On May 23 13:05, Yaakov Selkowitz wrote:
>> An increasing number of tools are being included in Windows which have the
>> same names as those included in Cygwin packages.  Indicating which one is
>> first in PATH can be helpful in diagnosing behavioural discrepencies
>> between them.
>> Also, fix the alphabetization of ssh.
> on second thought you don't have to wait for Brian's reply.  Just
> push this.  If Brian has some more input, you can easily add another
> patch, right?

Haven't upgraded or bounced anything since then. Maybe after next Tuesday.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
