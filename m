Return-Path: <ben@wijen.net>
Received: from 5.mo69.mail-out.ovh.net (5.mo69.mail-out.ovh.net
 [46.105.43.105])
 by sourceware.org (Postfix) with ESMTPS id 5BDC938708B2
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:51:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5BDC938708B2
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player755.ha.ovh.net (unknown [10.108.42.239])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 091BDAC88E
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:51:54 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id B22251A36D546
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:51:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0019c35bfd3-2392-4fa0-bc02-c529b10c724b,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-3-ben@wijen.net>
 <20210118105603.GS59030@calimero.vinschen.de>
 <6de2f124-c5dd-34cb-1914-4eb0454b41d8@wijen.net>
 <20210118130420.GE59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <fed934ea-5942-a80f-bd81-a1a6b03acb24@wijen.net>
Date: Mon, 18 Jan 2021 14:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118130420.GE59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10554748680781711108
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Mon, 18 Jan 2021 13:51:59 -0000

On 18-01-2021 14:04, Corinna Vinschen via Cygwin-patches wrote:
> What about this instead?  It should be better optimizable:
> 
Hmmm:
* _remove_r should still set reent->_errno
* _GLOBAL_REENT isn't threadlocal, what about __getreent()

So maybe:
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 4742c6653..9c498cd46 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1122,35 +1122,28 @@ unlink (const char *ourname)
 }
 
 extern "C" int
-_remove_r (struct _reent *, const char *ourname)
+_remove_r (struct _reent *ptr, const char *ourname)
 {
   path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
 
   if (win32_name.error)
     {
-      set_errno (win32_name.error);
+      ptr->_errno = set_errno (win32_name.error);
       syscall_printf ("%R = remove(%s)",-1, ourname);
       return -1;
     }
 
-  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  if (errno!=0)
+      ptr->_errno = errno;
+  syscall_printf ("%R = remove(%s)", res, ourname);
+  return res;
 }
 
 extern "C" int
 remove (const char *ourname)
 {
-  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
-
-  if (win32_name.error)
-    {
-      set_errno (win32_name.error);
-      syscall_printf ("-1 = remove (%s)", ourname);
-      return -1;
-    }
-
-  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
-  syscall_printf ("%R = remove(%s)", res, ourname);
-  return res;
+  return _remove_r (__getreent (), ourname);
 }
 
 extern "C" pid_t


Ben...

