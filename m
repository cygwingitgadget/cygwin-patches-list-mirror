Return-Path: <cygwin-patches-return-8619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75076 invoked by alias); 31 Aug 2016 18:07:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75040 invoked by uid 89); 31 Aug 2016 18:07:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, you!, H*r:smtp
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 18:07:25 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9uz-0004eD-14; Wed, 31 Aug 2016 20:07:21 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9ux-0006vs-F4; Wed, 31 Aug 2016 20:07:20 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 31 Aug 2016 20:07:19 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 0/4] dlopen: improving the search algorithm
Date: Wed, 31 Aug 2016 18:07:00 -0000
Message-Id: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q3/txt/msg00027.txt.bz2

Hi Corinna,

based on the discussion on -developers list [1][2], here's a reworked
set of patches for dlopen, split along these features and fixes.

[1] https://cygwin.com/ml/cygwin-developers/2016-06/msg00000.html
[2] https://cygwin.com/ml/cygwin-developers/2016-08/msg00000.html

*) Switch to pathfinder class for path search iteration, without any
deliberate change in behaviour, but with the pathfinder::criterion
interface to allow for more generic use eventually.

*) Fix search order to search all basenames per one directory
rather than searching all directories per one basename.

*) For dlopen ("/path/lib/libz.so"), search "/path/bin/" first when
the executable calling is located in "/path/bin/".  This is for [3].
[3] https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html

*) Consequently, dlopen ("libAPP.so") without an explicit path
should search the executable's directory first, like the Windows
loader does for linked dlls.

Topics dropped for now:

*) Extra GetModuleHandleEx is not that necessary to me, as it[4]
turns out that LoadLibrary detects a dll as already loaded even
if the underlying dll file has been replaced (renamed actually).
[4] https://cygwin.com/ml/cygwin-developers/2016-08/msg00023.html

*) Add PATH environment variable to list of searchdirs should not
be necessary to me when the executable dir is added.

Thank you!
/haubi/
