Return-Path: <cygwin-patches-return-9226-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95971 invoked by alias); 24 Mar 2019 02:23:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95961 invoked by uid 89); 24 Mar 2019 02:23:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 24 Mar 2019 02:23:04 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id 7smrhAgebLdsa7smshvL6y; Sat, 23 Mar 2019 20:23:02 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 0/2] default ps -W process start time to boot time when unavailable
Date: Sun, 24 Mar 2019 02:23:00 -0000
Message-Id: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00036.txt.bz2

non-elevated users can not access system startup process start times,
defaulting to time_t 0, displaying as Dec 31/Jan 1 depending on time zone,
so instead use system boot time, which is within seconds of correct,
to avoid WMI overhead getting correct system startup process start time

Brian Inglis (2):
  default ps -W process start time to system boot time when inaccessible, 0, -1
  get and convert boot time once and use as needed

 winsup/utils/ps.cc | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.17.0
