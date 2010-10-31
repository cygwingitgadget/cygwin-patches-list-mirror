Return-Path: <cygwin-patches-return-7127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15493 invoked by alias); 31 Oct 2010 00:37:44 -0000
Received: (qmail 15475 invoked by uid 22791); 31 Oct 2010 00:37:43 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ey0-f171.google.com (HELO mail-ey0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 31 Oct 2010 00:37:37 +0000
Received: by eyg5 with SMTP id 5so2691218eyg.2        for <cygwin-patches@cygwin.com>; Sat, 30 Oct 2010 17:37:35 -0700 (PDT)
Received: by 10.213.34.9 with SMTP id j9mr949712ebd.75.1288485455061;        Sat, 30 Oct 2010 17:37:35 -0700 (PDT)
Received: from localhost (ppp85-141-233-145.pppoe.mtu-net.ru [85.141.233.145])        by mx.google.com with ESMTPS id v56sm2948271eeh.14.2010.10.30.17.37.33        (version=TLSv1/SSLv3 cipher=RC4-MD5);        Sat, 30 Oct 2010 17:37:34 -0700 (PDT)
Date: Sun, 31 Oct 2010 00:37:00 -0000
From: Dmitry Potapov <dpotapov@gmail.com>
To: cygwin-patches@cygwin.com
Subject: "regtool -m set" writes 2 extra bytes at the end
Message-ID: <20101031003731.GA30070@dpotapov.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00006.txt.bz2

Hi,

The easiest way to demonstrate the problem is to run the following shell
script:

---- >8 ---
regtool -m set /HKEY_LOCAL_MACHINE/SOFTWARE/Test 1234
expected="31 00 32 00 33 00 34 00 00 00 00 00"
actual="`regtool get -b /HKEY_LOCAL_MACHINE/SOFTWARE/Test`"

if [ "$actual" != "$expected" ]; then
	echo FAILED
else
	echo OK
fi
---- >8 ---

The patch is below.

--- >8 ---
Index: regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.30
diff -u -r1.30 regtool.cc
--- regtool.cc	28 Aug 2010 11:22:37 -0000	1.30
+++ regtool.cc	30 Oct 2010 22:56:47 -0000
@@ -711,7 +711,7 @@
 	n += mbstowcs ((wchar_t *) data + n, argv[i], max_n - n) + 1;
       ((wchar_t *)data)[n] = L'\0';
       rv = RegSetValueExW (key, value, 0, REG_MULTI_SZ, (const BYTE *) data,
-			   (max_n + 1) * sizeof (wchar_t));
+			   (n + 1) * sizeof (wchar_t));
       break;
     case REG_AUTO:
       rv = ERROR_SUCCESS;
--- >8 ---


Dmitry
