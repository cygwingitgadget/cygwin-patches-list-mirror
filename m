Return-Path: <cygwin-patches-return-6654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4715 invoked by alias); 29 Sep 2009 19:18:35 -0000
Received: (qmail 4690 invoked by uid 22791); 29 Sep 2009 19:18:34 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta14.emeryville.ca.mail.comcast.net (HELO QMTA14.emeryville.ca.mail.comcast.net) (76.96.27.212)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 29 Sep 2009 19:18:28 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA14.emeryville.ca.mail.comcast.net with comcast 	id mfNW1c0071HpZEsAEjJUVA; Tue, 29 Sep 2009 19:18:28 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id mjJS1c0080Lg2Gw8ajJTPE; Tue, 29 Sep 2009 19:18:28 +0000
Message-ID: <4AC25D6C.4010106@byu.net>
Date: Tue, 29 Sep 2009 19:18:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de>  <20090923164127.GB3172@ednor.casa.cgf.cx>  <4ABC39A1.1060702@byu.net>  <20090925151114.GA23857@ednor.casa.cgf.cx>  <4ABD5A4A.9060603@byu.net> <20090926145748.GA8697@ednor.casa.cgf.cx>
In-Reply-To: <20090926145748.GA8697@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------010305070004040702090406"
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
X-SW-Source: 2009-q3/txt/msg00108.txt.bz2

This is a multi-part message in MIME format.
--------------010305070004040702090406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 763

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/26/2009 8:57 AM:
>> But how does it look now?
> 
> It looks good.  Thanks.  Please check in.

I missed one corner case in my testing; how about this followup?

2009-09-29  Eric Blake  <ebb9@byu.net>

	* syscalls.cc (rename): Fix regression on rename("dir","d/").

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrCXWsACgkQ84KuGfSFAYAM1gCgy1EXKJouKOh4WBCAKsnYhd1z
SfoAnibntBW3fCJxo1mG/XFAcfO5HyCU
=QLdB
-----END PGP SIGNATURE-----

--------------010305070004040702090406
Content-Type: text/plain;
 name="cygwin.patch27"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch27"
Content-length: 785

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 67dddf3..fa257a7 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1759,18 +1759,10 @@ rename (const char *oldpath, const char *newpath)
       set_errno (EROFS);
       goto out;
     }
-  if (new_dir_requested)
+  if (new_dir_requested && !(newpc.exists () ? newpc.isdir () : oldpc.isdir ()))
     {
-      if (!newpc.exists())
-        {
-          set_errno (ENOENT);
-          goto out;
-        }
-      if (!newpc.isdir ())
-        {
-          set_errno (ENOTDIR);
-          goto out;
-        }
+      set_errno (newpc.exists () ? ENOTDIR : ENOENT);
+      goto out;
     }
   if (newpc.exists () && (oldpc.isdir () ? !newpc.isdir () : newpc.isdir ()))
     {
-- 
1.6.5.rc1


--------------010305070004040702090406--
