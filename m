Return-Path: <cygwin-patches-return-8043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2752 invoked by alias); 18 Dec 2014 17:21:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2740 invoked by uid 89); 18 Dec 2014 17:21:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Dec 2014 17:21:04 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBIHL3NH026083	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2014 12:21:03 -0500
Received: from [10.10.116.25] ([10.10.116.25])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBIHL11r002542	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2014 12:21:03 -0500
Message-ID: <54930D04.6030608@cygwin.com>
Date: Thu, 18 Dec 2014 17:21:00 -0000
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] spelling fix for struct passwd
Content-Type: multipart/mixed; boundary="------------040506020804020601080005"
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.
--------------040506020804020601080005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 163

This field is spelled pw_passwd on Linux, and I haven't found a 
different spelling on other platforms (it is not mandated by POSIX). 
Patch attached.

--
Yaakov


--------------040506020804020601080005
Content-Type: text/x-patch;
 name="doc-ntsec-passwd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-ntsec-passwd.patch"
Content-length: 730

2014-12-18  Yaakov Selkowitz  <yselkowitz@...>

	* ntsec.xml (ntsec-logonuser): Fix spelling of pw_passwd field.

Index: ntsec.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/ntsec.xml,v
retrieving revision 1.18
diff -u -p -r1.18 ntsec.xml
--- ntsec.xml	10 Dec 2014 12:35:36 -0000	1.18
+++ ntsec.xml	18 Dec 2014 17:11:32 -0000
@@ -2311,7 +2311,7 @@ example:</para>
     /* Use standard method on non-Cygwin systems. */
     hashed_password = crypt (cleartext_password, salt);
     if (!user_pwd_entry ||
-        strcmp (hashed_password, user_pwd_entry->pw_password))
+        strcmp (hashed_password, user_pwd_entry->pw_passwd))
       error_exit;
 #endif /* CYGWIN */
 

--------------040506020804020601080005--
