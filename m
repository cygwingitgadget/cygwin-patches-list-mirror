Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id B1458384404C
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 07:17:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B1458384404C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id BC9okXWpT695cBC9pkP2cn; Thu, 27 Aug 2020 01:17:14 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=I0CVDw5ZAAAA:8
 a=zBVnKYl2S0ZIkKNPMc8A:9 a=YdXdGVBxRxTCRzIkH2Jn:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 3/3] winsup/doc/faq-api.xml(faq.api.timezone): explain time
 zone updates
Date: Thu, 27 Aug 2020 01:17:09 -0600
Message-Id: <20200827071709.18558-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJD6SlCpS3hC+w6YGslaWFNJ8VasZ9Q3y88l14OI34L7zD27J3OZWsMdvWbKFDH4MsnH1jYLgc5NgkLMJUrjvJUK1XJidGYP4BKnD5g1jESXoBcZX0k0
 Os909bYhku2e2LzunBl0mXOPHFnyGO6D7gmv9YqDVAvyx8WetOFTqWtwiI1976HLTnzEAriQ0LHR8uBKDv49QuF8uxLBclgyK3NmNqorTVf7VdLZBJnvmYcQ
 4J6GdptONBVkZXD8UsdqRQ==
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPAM_BODY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 27 Aug 2020 07:17:17 -0000

based on material from tz@IANA.org mailing list sources
---
 winsup/doc/faq-api.xml | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index 829e4d7febd8..6283fb663d77 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -385,13 +385,43 @@ Cygwin version number details, check out the
 </answer></qandaentry>
 
 <qandaentry id="faq.api.timezone">
-<question><para>Why isn't timezone set correctly?</para></question>
+<question><para>Why isn't my time (or zone) set correctly?</para></question>
 <answer>
 
-<para><emphasis role='bold'>(Please note: This section has not yet been updated for the latest net release.)</emphasis>
-</para>
-<para>Did you explicitly call tzset() before checking the value of timezone?
-If not, you must do so.
+<para>Daylight saving (Summer time) and other time zone changes are
+decided on by politicians, and announced by government officials,
+sometimes with short or no notice, so time zone updates are released at
+least a few, and sometimes several, times a year.
+Details of changes are not known until they are announced publicly by
+officials, often in foreign languages.
+Those details then have to be noticed, possibly translated, passed to,
+picked up, and applied by the official <filename>tzdata</filename>
+source package maintainers.
+That information has to be compiled, checked, and released publicly in
+an update to the official <filename>tzdata</filename> source package.
+Then those changes have to be picked up and applied to the Cygwin
+<filename>tzdata</filename> package, which has to be updated, built,
+tested, and released publicly.
+</para>
+<para>Time zone settings are updates to the daylight saving (Summer
+time) rules for dates of changes, hour offsets from UTC of time zones,
+and the geographic regions to which those rules and offsets apply,
+provided in the <filename>tzdata</filename> package included in all
+Cygwin installations.
+Have you run the Cygwin Setup program recently to update at least
+the <filename>tzdata</filename> package?
+</para>
+<para>Are you developing applications using times which may be affected
+by time zones?
+Since the <literal>ctime()</literal>, <literal>localtime()</literal>,
+<literal>mktime()</literal>, and <literal>strftime()</literal> functions
+are required to set time zone information as if by calling
+<literal>tzset()</literal>, there is no need for an explicit
+<literal>tzset()</literal> call before using these functions.
+However, if none of the above functions are called first, applications
+should ensure <literal>tzset()</literal> is called explicitly before
+using any other time functions, or checking or using time zone
+information.
 </para>
 </answer></qandaentry>
 
-- 
2.28.0

