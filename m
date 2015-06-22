Return-Path: <cygwin-patches-return-8201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124748 invoked by alias); 22 Jun 2015 14:40:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124732 invoked by uid 89); 22 Jun 2015 14:40:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0206.bt.lon5.cpcloud.co.uk
Received: from rgout0206.bt.lon5.cpcloud.co.uk (HELO rgout0206.bt.lon5.cpcloud.co.uk) (65.20.0.205) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:39:59 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.55881E3C.00A6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.153616:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_900_999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_1000_LESS, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5581A14B00BE55CE; Mon, 22 Jun 2015 15:39:56 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/5] More cygwin-doc stuff
Date: Mon, 22 Jun 2015 14:40:00 -0000
Message-Id: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00102.txt.bz2

intro.1 and intro.3 man pages for Cygwin
Cygwin User's Guide and Cygwin API reference .info
A few documentation related cleanups.

Jon TURNEY (5):
  winsup/doc: Create info pages from cygwin documentation
  winsup/doc: Add intro man pages from cygwin-doc
  winsup/doc: Remove 'Usage' prefix from synopses
  winsup/doc: Use xidepend to generate the source list for FAQ targets
    as well
  winsup/doc: Update ancient README about building documentation

 winsup/doc/ChangeLog         |  26 ++++++
 winsup/doc/Makefile.in       |  40 +++++++--
 winsup/doc/README            |  23 +----
 winsup/doc/cygwin-api.xml    |   3 +
 winsup/doc/cygwin-ug-net.xml |   3 +
 winsup/doc/intro.xml         | 196 +++++++++++++++++++++++++++++++++++++++++++
 winsup/doc/ntsec.xml         |  18 +++-
 winsup/doc/utils.xml         |  88 +++++++++----------
 8 files changed, 321 insertions(+), 76 deletions(-)
 create mode 100644 winsup/doc/intro.xml

-- 
2.1.4
