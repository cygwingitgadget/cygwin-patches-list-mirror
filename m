Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 040313857809
 for <cygwin-patches@cygwin.com>; Wed, 25 Nov 2020 06:49:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 040313857809
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id hocVkbxlCtdldhocWkEF1C; Tue, 24 Nov 2020 23:49:40 -0700
X-Authority-Analysis: v=2.4 cv=INe8tijG c=1 sm=1 tr=0 ts=5fbdfe84
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=KgoiiOJYiJqKa4DpawEA:9 a=OXe0Gg1GMEUA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/2] proc(5) man page
Date: Tue, 24 Nov 2020 23:49:29 -0700
Message-Id: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAZmKkw9rZnOvS4oGK3jUrEddjv3aZVgC9MDSgzGZTneLIfWV+ErVvIJ+SBfaNF+9b6rSz70+W2/ed+Q7a8KzKmEoetvab8/guAjRYgpFkRO73jfRMLf
 AnhS8HLu6hhtaV1+k7E6iC0tCbbo6aez3Lpg2YaYFm2hPs6M+gB7J8gmQZwtSSb0+eDJ97iOCrqbaq2/ERFhe0BHmXvjYBnmq6177YVcmxC13T7I9plRgazL
 +mW7lsMCEljwv672ab+oq+EHV8nuSbItXNoR8QUTFOk=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 25 Nov 2020 06:49:43 -0000

Brian Inglis (2):
  specialnames.xml: add proc(5) Cygwin man page
  winsup/doc/Makefile.in: create man5 dir and install generated proc.5

 winsup/doc/Makefile.in      |    4 +
 winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
 2 files changed, 2098 insertions(+)

-- 
2.29.2

