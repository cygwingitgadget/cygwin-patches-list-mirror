Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 644273857C40
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 20:11:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 644273857C40
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id AIoDkEgGn695cAIoXkGDry; Mon, 24 Aug 2020 14:11:33 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=I0CVDw5ZAAAA:8
 a=2vgJobJ0UVLQsd_972UA:9 a=YdXdGVBxRxTCRzIkH2Jn:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] winsup/doc/faq-api.xml(faq.api.timezone): explain time
 zone updates
Date: Mon, 24 Aug 2020 14:11:00 -0600
Message-Id: <20200824201058.4916-3-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCvei/JrKpdpBAWHGjWGcK46sYG5tkXNLYkKLlV3Ahzc9a01ExhCDAtEY3BOsudxBTAarAiEk2dQ0rjvlAvkYJ7GVmp5rE+SjgHOBkQO2sCmauTyQlWs
 SaufNgd927ExED9s4TcCi8716e4KoIY36QonhN2Nke9FvCDiNIFESP0mANiQtZEMlGdQXDkYvcruLKKLcSHpR2M7wQt9g7rRokn+r/RSR9glLVGr8m1Q7A/5
 6Ne12VSR32E4xDf6WnLw7g==
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 24 Aug 2020 20:11:34 -0000

based on material from tz@IANA.org mailing list sources
---
 winsup/doc/faq-api.xml | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index f51eeac48835..029f5ce5f580 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -385,13 +385,34 @@ Cygwin version number details, check out the
 </answer></qandaentry>
 
 <qandaentry id="faq.api.timezone">
-<question><para>Why isn't timezone set correctly?</para></question>
+<question><para>Why isn't time zone set correctly?</para></question>
 <answer>
 
-<para><emphasis role='bold'>(Please note: This section has not yet been updated for the latest net release.)</emphasis>
-</para>
-<para>Did you explicitly call tzset() before checking the value of timezone?
+<para>Did you explicitly call tzset() before checking the value of time zone?
 If not, you must do so.
+Time zone settings are updated by changes to the tzdata package included in all
+Cygwin installations.
+Have you run the Cygwin Setup program recently to update at least the
+<filename>tzdata</filename>
+package to include the latest current daylight saving (summer time) rules
+for dates of changes, hour offsets from UTC of time zones, and the
+geographic regions to which those rules and offsets apply.
+</para>
+<para>These changes are decided on by politicians, and announced
+by government officials, sometimes with short or no notice, so
+<filename>tzdata</filename>
+package updates are released at least a few, and sometimes several,
+times a year.
+As details of changes are not known until they are announced publicly by
+officials, often in foreign languages, and those details then have to be
+noticed, possibly translated, passed to, and picked up by the official
+<filename>tzdata</filename>
+source package maintainers, subsequently released in an update to the
+<filename>tzdata</filename>
+source package, and then those changes have to be picked up on and applied
+to the Cygwin
+<filename>tzdata</filename>
+package, which has to be updated, built, tested, and released publicly.
 </para>
 </answer></qandaentry>
 
-- 
2.28.0

