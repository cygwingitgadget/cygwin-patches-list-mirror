Return-Path: <cygwin-patches-return-8183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10666 invoked by alias); 17 Jun 2015 12:37:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10601 invoked by uid 89); 17 Jun 2015 12:37:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout05.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:25 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.55816A02.0011,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1200_1299, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E000399CB; Wed, 17 Jun 2015 13:37:14 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/5] Generate cygwin-api manpages
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00084.txt.bz2

This patch set changes the DocBook source XML for the Cygwin API reference to 
use refentry elements, and also generates man pages from that.

Again, note that after this, the chunked html now has a page for each function, 
rather than one containing all functions.

Jon TURNEY (5):
  winsup/doc: Rename cygwin.xsl as html.xsl
  winsup/doc: Generate ANSI rather than K&R style function prototypes
  winsup/doc: Convert cygwin-api function documentation to refentry
    elements
  winsup/doc: Make and install cygwin-api function manpages
  winsup/doc: Add man.xsl customization stylesheet

 winsup/doc/ChangeLog                |  28 ++++++
 winsup/doc/Makefile.in              |  31 ++++---
 winsup/doc/cygwin-api.xml           |   6 +-
 winsup/doc/fo.xsl                   |   3 +
 winsup/doc/{cygwin.xsl => html.xsl} |   5 +-
 winsup/doc/logon-funcs.xml          |  59 ++++++++++---
 winsup/doc/man.xsl                  |  13 +++
 winsup/doc/misc-funcs.xml           |  81 +++++++++++++----
 winsup/doc/path.xml                 | 172 +++++++++++++++++++++++++++---------
 9 files changed, 318 insertions(+), 80 deletions(-)
 rename winsup/doc/{cygwin.xsl => html.xsl} (85%)
 create mode 100644 winsup/doc/man.xsl

-- 
2.1.4
