Return-Path: <cygwin-patches-return-9735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103255 invoked by alias); 5 Oct 2019 16:12:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103245 invoked by uid 89); 5 Oct 2019 16:12:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=helped, browser, H*f:sk:875zl3l, H*i:sk:875zl3l
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 05 Oct 2019 16:11:59 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id Gmeyi8x01UIS2GmezinJDl; Sat, 05 Oct 2019 10:11:57 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
To: cygwin-patches@cygwin.com
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca> <5b5874ac-4d98-1415-90fe-66e5fb79b398@SystematicSw.ab.ca> <875zl3ln5l.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <28ce0a39-7b0a-afa2-91a1-8b796448f70c@SystematicSw.ab.ca>
Date: Sat, 05 Oct 2019 16:12:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <875zl3ln5l.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00006.txt.bz2

On 2019-10-05 00:30, ASSI wrote:
> Brian Inglis writes:
>> For informal comparison, attached are Cygwin, WSL, and test release cpuinfo
>> output, with diffs against the test release output, and the Windows registry
>> CentralProcessor dump (be careful not to double click on Windows systems!)
> The easiest way to prevent that problem would have been to give that
> file a .txt extension, no?

Could have stripped the header line to disable it doing anything too, and both
would have helped with org milters.
I've had most file types: graphics, PDF, text, etc. treated like HTML, opening
in browser tabs for so long, I just thought of mentioning it right before sending.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
