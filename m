Return-Path: <cygwin-patches-return-9743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12791 invoked by alias); 7 Oct 2019 16:23:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12696 invoked by uid 89); 7 Oct 2019 16:23:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:23:55 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVndisFXN; Mon, 07 Oct 2019 10:23:53 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 00/10] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, feature flags
Date: Mon, 07 Oct 2019 16:23:00 -0000
Message-Id: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00014.txt.bz2

*   fix cache size return code handling and make AMD/Intel code common
*   fix cpuid level count as number of non-zero leafs excluding sub-leafs
*   fix AMD physical cores count documented as core_info low byte + 1
*   round cpu MHz to correct Windows and match Linux cpuinfo
*   add bogomips which has been cpu MHz*2 since Pentium MMX
*   add microcode from Windows registry Update Revision REG_BINARY
*   feature test print macro makes cpuid feature, bit, and flag text
    comparison and checking easier;
    handle as common former Intel only feature flags also supported on AMD;
    change order and some flag names to agree with current Linux
*   add 99 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid calls
*   comment out flags not reported by Linux in cpuinfo although some flags
    may not be used by Linux
*   or model extension bits into high model bits instead of adding
    arithmetically like family extension bits

 winsup/cygwin/fhandler_proc.cc | 737 +++++++++++++++++++--------------
 1 file changed, 434 insertions(+), 303 deletions(-)

-- 
2.21.0
