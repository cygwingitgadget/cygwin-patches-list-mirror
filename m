Return-Path: <cygwin-patches-return-8508-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80025 invoked by alias); 30 Mar 2016 18:54:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80012 invoked by uid 89); 30 Mar 2016 18:54:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=Protect, cygwindevelopers, haubi, Hx-languages-length:385
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 18:53:56 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFW-0002EU-VZ; Wed, 30 Mar 2016 20:53:52 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFV-000255-Er; Wed, 30 Mar 2016 20:53:50 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:53:49 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 0/6] Protect fork() against dll- and exe-updates.
Date: Wed, 30 Mar 2016 18:54:00 -0000
Message-Id: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00214.txt.bz2

Hi,

this is the updated and split series of patches to use hardlinks
for creating the child process by fork(), in reply to
https://cygwin.com/ml/cygwin-developers/2016-01/msg00002.html
https://cygwin.com/ml/cygwin-developers/2016-03/msg00005.html
http://thread.gmane.org/gmane.os.cygwin.devel/1378

Thanks for review!
/haubi/
