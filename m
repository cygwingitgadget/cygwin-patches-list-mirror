Return-Path: <>
Received: from mda.extendcp.co.uk (unknown [80.90.192.197])
	by sourceware.org (Postfix) with ESMTPS id B1CB83858CDB
	for <cygwin-patches@cygwin.com>; Sat, 10 Sep 2022 18:20:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B1CB83858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=mda.extendcp.co.uk
Authentication-Results: sourceware.org; spf=none smtp.helo=mda.extendcp.co.uk
Received: from mail by mda.extendcp.co.uk with local (Exim 4.94.2)
	id 1oX55V-00Dzuk-8u
	for cygwin-patches@cygwin.com; Sat, 10 Sep 2022 19:20:17 +0100
X-Failed-Recipients: eotcband@gmail.com
Auto-Submitted: auto-replied
From: Mail Delivery System <Mailer-Daemon@mda.extendcp.co.uk>
To: cygwin-patches@cygwin.com
References: <202209110220138711160@cygwin.com>
Content-Type: multipart/report; report-type=delivery-status; boundary=1662834017-eximdsn-622678352
MIME-Version: 1.0
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1oX55V-00Dzuk-8u@mda.extendcp.co.uk>
Date: Sat, 10 Sep 2022 19:20:17 +0100
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,KAM_COUK,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--1662834017-eximdsn-622678352
Content-type: text/plain; charset=us-ascii

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  eotcband@gmail.com
    (ultimately generated from Webmaster@eotc.co.uk)
    

--1662834017-eximdsn-622678352
Content-type: message/delivery-status

Reporting-MTA: dns; mda.extendcp.co.uk

Action: failed
Final-Recipient: rfc822;Webmaster@eotc.co.uk
Status: 5.0.0

--1662834017-eximdsn-622678352
Content-type: text/rfc822-headers

Return-path: <cygwin-patches@cygwin.com>
Received: from mail by mda.extendcp.co.uk with spamvirus-scanned (Exim 4.94.2)
	id 1oX55U-00Dzu4-6y
	for Webmaster@eotc.co.uk; Sat, 10 Sep 2022 19:20:17 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on scan7.hi.local
X-Spam-Flag: YES
X-Spam-Level: ******************
X-Spam-Status: Yes, score=18.4 required=7.0 tests=CMCL_1,
	FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HTML_IMAGE_ONLY_04,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,MPART_ALT_DIFF,
	PDS_TONAME_EQ_TOLOCAL_FREEM_FORGE,RCVD_IN_VALIDITY_RPBL,RDNS_NONE,
	SPF_HELO_FAIL,T_OBFU_JPG_ATTACH,T_SCC_BODY_TEXT_LINE autolearn=disabled
	version=3.4.0
X-Spam-Report: 
	*  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
	*      https://senderscore.org/blocklistlookup/
	*      [115.226.168.247 listed in bl.score.senderscore.com]
	*  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in digit
	*      (alnb7891[at]21cn.com)
	*  0.0 SPF_HELO_FAIL SPF: HELO does not match SPF record (fail)
	*      [SPF failed: Please see http://www.openspf.net/Why?s=helo;id=cygwin.com;ip=115.226.168.247;r=scan7.hi.local]
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.7 MPART_ALT_DIFF BODY: HTML and text parts are different
	*  0.0 T_OBFU_JPG_ATTACH BODY: JPG attachment with generic MIME type
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.3 HTML_IMAGE_ONLY_04 BODY: HTML: images with 0-400 bytes of words
	*   10 CMCL_1 Cloudmark Authority detected spam
	*  1.3 RDNS_NONE Delivered to internal network by a host with no rDNS
	*  0.6 HTML_MIME_NO_HTML_TAG HTML-only message, but there is no HTML tag
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  2.5 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
	*  1.3 PDS_TONAME_EQ_TOLOCAL_FREEM_FORGE Forged replyto and
	*      __PDS_TONAME_EQ_TOLOCAL
X-Spam-CMAuthority: v=2.4 cv=CPXv4TnD c=0 sm=1 tr=0 ts=631cd561
	p=TLbLnxVyYxFkqrjO2L0A:9 a=PCK+PfzFzHJtzAM8Hxm1Ug==:17 a=_l4uJm6h9gAA:10
	a=xOM3xZuef0cA:10 a=9DvhAHx2yrWFMPxQWpQA:9 a=tWMloKG_feIIU6U4h_QA:9
	a=lqcHg5cX4UMA:10 a=mFyHDrcPJccA:10
Received: from [115.226.168.247] (helo=cygwin.com)
	by mda.extendcp.co.uk with esmtp (Exim 4.94.2)
	id 1oX55R-00DzrQ-Dg
	for Webmaster@eotc.co.uk; Sat, 10 Sep 2022 19:20:16 +0100
X-GUID: EAEF8CD5-9FF3-47F4-AE2A-AA30601446E8
X-Has-Attach: yes
From: "30591" <cygwin-patches@cygwin.com>
Subject: [SPAM] Looking for agents
To: "Webmaster" <Webmaster@eotc.co.uk>
Content-Type: multipart/mixed; charset=GB2312; boundary="----=_981_NextPart912335004343_=----"
MIME-Version: 1.0
Reply-To: alnb7891@21cn.com
Date: Sun, 11 Sep 2022 02:20:17 +0800
Message-Id: <202209110220138711160@cygwin.com>
X-Mailer: Foxmail 7, 2, 5, 140[cn]
X-Spam-Prev-Subject: Looking for agents
X-Exim-DSN-Information: Due to administrative limits only headers are returned


--1662834017-eximdsn-622678352--
