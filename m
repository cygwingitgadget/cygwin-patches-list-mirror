Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta22-sa.btinternet.com [213.120.69.28])
	by sourceware.org (Postfix) with ESMTPS id 0B9A73858412
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 13:14:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0B9A73858412
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20230713131429.GDKZ29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 14:14:29 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067FEB0ED4A6C8
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhg
	vghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067FEB0ED4A6C8; Thu, 13 Jul 2023 14:14:29 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: pthread: Take note of schedparam in pthread_create
Date: Thu, 13 Jul 2023 14:14:14 +0100
Message-Id: <20230713131414.3013-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Take note of schedparam in any pthread_attr_t passed to pthread_create.

postcreate() (racily, after the thread is actually created), sets the
scheduling priority if it's inherited, but precreate() doesn't store any
scheduling priority explicitly set via a non-default attr to create, so
schedparam.sched_priority has the default value of 0.

(I think this is another long-standing bug exposed by 4b51e4c1.  Now we
don't lie about the actual thread priority, it's apparent it's not
really being set in this case.)

Fixes testcase priority2.
---
 winsup/cygwin/thread.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index f614e01c4..afddf4282 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -457,6 +457,7 @@ pthread::precreate (pthread_attr *newattr)
       attr.joinable = newattr->joinable;
       attr.contentionscope = newattr->contentionscope;
       attr.inheritsched = newattr->inheritsched;
+      attr.schedparam = newattr->schedparam;
       attr.stackaddr = newattr->stackaddr;
       attr.stacksize = newattr->stacksize;
       attr.guardsize = newattr->guardsize;
-- 
2.39.0

