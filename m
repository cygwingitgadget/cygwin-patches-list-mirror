Return-Path: <cygwin-patches-return-9505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81575 invoked by alias); 21 Jul 2019 15:40:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81565 invoked by uid 89); 21 Jul 2019 15:40:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Anything, funds, H*f:sk:619bf05, visibility
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 15:40:46 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id pDx4hsfFisAGkpDx5hybGG; Sun, 21 Jul 2019 09:40:44 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
To: cygwin-patches@cygwin.com
References: <20190718200026.1377-1-kbrown@cornell.edu> <20190719082845.GO3772@calimero.vinschen.de> <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu> <e97cff22-2083-b5ec-1dac-31a34b0c86c3@cornell.edu> <619bf054-ae39-75af-eb12-e9b3b6115555@SystematicSw.ab.ca> <29f31335-dc95-3ea2-c883-f5774d49b7e2@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <7992b043-d694-5ce2-cfdd-466c13d7f6bb@SystematicSw.ab.ca>
Date: Sun, 21 Jul 2019 15:40:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29f31335-dc95-3ea2-c883-f5774d49b7e2@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00025.txt.bz2

On 2019-07-21 08:25, Ken Brown wrote:
> On 7/21/2019 3:15 AM, Brian Inglis wrote:
>> Anything beginning is or to followed by a lower case letter may be used by the
>> (library) implementation and may be considered reserved: best to interpose an
>> underscore as systems with better language support inc. BSDs are adding classes.
> 
> I assume you're referring to the POSIX name space rules, as in Section 2.2.2 of 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html.  I 
> don't see how that's related to the present discussion (identifiers used in 
> classes internal to Cygwin).

Software hygiene for 9899 (see 7.1.4 Future Library Directions), POSIX, and C++
(anything in the std namespace) conformance: 9899 and others are normative
references in both POSIX and C++.

"Also, POSIX.1-2017 defines symbols that are not permitted by other standards to
appear in those headers without some control on the visibility of those symbols."

Normative References -
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap01.html#tag_01_03 -
includes FORTRAN, 646 ASCII and 10646 UTF8 BMP, 8601 dates/times, and 4217
currencies/funds!

So we can't use anything that is currently or might be used in the future by any
compiler or library.

Builds break unexpectedly, and sometimes more widely than you might think, when
a header included perhaps indirectly, declares or defines something you have
improperly used.

BTDT Got The T-Shirt - structure member name used in a number of structures in
app headers included in and used in almost all sources, toasted by a macro
definition in a std header required in almost all those sources - as a core dev
I got to do the cleanup! ;^>

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
