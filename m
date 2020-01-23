Return-Path: <cygwin-patches-return-9996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92459 invoked by alias); 23 Jan 2020 17:08:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92450 invoked by uid 89); 23 Jan 2020 17:08:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: =?ISO-8859-1?Q?No, score=-1.3 required=5.0 tests=AWL,BAYES_00,BODY_8BITS,GARBLED_BODY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.1 spammy==c3=a2=e2?=
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 17:08:25 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id ufxuiZycTRnrKufxviT8MF; Thu, 23 Jan 2020 10:08:24 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] fhandler_proc.cc:format_proc_cpuinfo add rdpru flag
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200123090626.58604-1-Brian.Inglis@SystematicSW.ab.ca> <20200123124425.GB263143@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <a84c0054-518d-291a-c1b3-de8f40d0bc15@SystematicSw.ab.ca>
Date: Thu, 23 Jan 2020 17:08:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123124425.GB263143@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00102.txt

On 2020-01-23 05:44, Corinna Vinschen wrote:
> On Jan 23 02:06, Brian Inglis wrote:
>> rdpru flag is cpuid xfn 80000008 ebx bit 4 added in linux 5.5;
>> see AMD64 Architecture ProgrammerÃ¢ÂÂs Manual Volume 3:
>                                    ^^^^^^^^^
> This came over already broken.  No idea if that's a problem of
> your MUA or of the mailing list software.  I fixed it to an
> ordinary quote char locally.

Sorry, didn't notice that sneaky quote from the PDF title in UTF-8 "Ã¢â¬â¢".
Message source shows it's composed and sent in UTF-8 with:
	Content-Transfer-Encoding: 8bit
by:
	X-Mailer: git-send-email 2.21.0
but without encoding or charset headers, so added git [sendemail] *Encoding
config settings to avoid future issues by adding header (tested):
	Content-Type: text/plain; charset=UTF-8

--
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
