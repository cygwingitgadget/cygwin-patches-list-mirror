Return-Path: <cygwin-patches-return-8592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22819 invoked by alias); 5 Jul 2016 10:08:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22799 invoked by uid 89); 5 Jul 2016 10:08:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=HX-CTCH-RefID:1,fgs, Improve, HX-CTCH-RefID:0.000,reip, HX-CTCH-RefID:sk:0001.0A
X-HELO: rgout0405.bt.lon5.cpcloud.co.uk
Received: from rgout0405.bt.lon5.cpcloud.co.uk (HELO rgout0405.bt.lon5.cpcloud.co.uk) (65.20.0.218) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jul 2016 10:08:11 +0000
X-OWM-Source-IP: 86.179.112.53 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090206.577B8708.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.7.4.165416:17:27.888,ip=86.179.112.53,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODYTEXTP_SIZE_400_LESS, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_300_399, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[53.112.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, NO_URI_FOUND, NO_CTA_URI_FOUND, BODY_SIZE_1000_LESS, BODY_SIZE_2000_LESS, MULTIPLE_RCPTS_RND, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS, LEGITIMATE_NEGATE
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.112.53) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57764D230097E73F; Tue, 5 Jul 2016 11:08:08 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Small documentation fixes
Date: Tue, 05 Jul 2016 10:08:00 -0000
Message-Id: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00000.txt.bz2

Jon Turney (3):
  Use <example> tag at same level as <para>, not inside it
  Use <filename> tag, not <pathname> tag
  Improve description of Cygwin ldd utility

 winsup/doc/utils.xml | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

-- 
2.8.3
