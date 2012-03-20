Return-Path: <cygwin-patches-return-7623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10431 invoked by alias); 20 Mar 2012 17:48:37 -0000
Received: (qmail 10415 invoked by uid 22791); 20 Mar 2012 17:48:34 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_20,RCVD_IN_DNSWL_NONE,TW_BJ,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 20 Mar 2012 17:48:21 +0000
Received: from fwd17.aul.t-online.de (fwd17.aul.t-online.de )	by mailout03.t-online.de with smtp 	id 1SA3AQ-0003KN-Tb; Tue, 20 Mar 2012 18:48:18 +0100
Received: from [192.168.2.108] (VyUufUZdQhWbE3EjlQjELIeI6vOMdcotKydf4kp09hD5IoDw6gdl+LAwscx5RfUZsv@[79.224.125.199]) by fwd17.t-online.de	with esmtp id 1SA3AL-0vvGjI0; Tue, 20 Mar 2012 18:48:13 +0100
Message-ID: <4F68C2DA.8050909@t-online.de>
Date: Tue, 20 Mar 2012 17:48:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Firefox/10.0.2 SeaMonkey/2.7.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix possible infinite loop in hires_ms::timeGetTime_ns()
Content-Type: multipart/mixed; boundary="------------050609010809050405010101"
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
X-SW-Source: 2012-q1/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------050609010809050405010101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1064

ntdll.h:SharedUserData misses a volatile qualifier. This (at least) may 
result in an infinite loop in hires_ms::timeGetTime_ns(). Fortunately 
this could only happen if LowPart wraps around during the function call.

Generated code:

$ objdump -d -C times.o
...
1160 <hires_ms::timeGetTime_ns()>:
1160: 55                 push   %ebp
1161: 8b 15 0c 00 fe 7f  mov    0x7ffe000c,%edx
1167: 3b 15 10 00 fe 7f  cmp    0x7ffe0010,%edx
116d: 89 e5              mov    %esp,%ebp
116f: a1 08 00 fe 7f     mov    0x7ffe0008,%eax
1174: 75 02              jne    1178 <hires_ms::timeGetTime_ns()+0x18>
1176: 5d                 pop    %ebp
1177: c3                 ret
1178: eb fe              jmp    1178 <hires_ms::timeGetTime_ns()+0x18>
...


This function results in the same code:

LONGLONG hires_ms::timeGetTime_ns ()
{
   LARGE_INTEGER t;
   t.HighPart = SharedUserData.InterruptTime.High1Time;
   t.LowPart = SharedUserData.InterruptTime.LowPart;
   if (t.HighPart == SharedUserData.InterruptTime.High2Time)
     return t.QuadPart;

   for (;;)
     ;
}


Christian


--------------050609010809050405010101
Content-Type: text/x-patch;
 name="volatile-userdata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="volatile-userdata.patch"
Content-length: 900

2012-03-20  Christian Franke  <franke@computer.org>

	* ntdll.h (SharedUserData): Add volatile qualifier. This fixes
	a possible infinite loop in hires_ms::timeGetTime_ns ().

diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index d921867..7eee720 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -1106,9 +1106,10 @@ typedef VOID (APIENTRY *PTIMER_APC_ROUTINE)(PVOID, ULONG, ULONG);
 
 #ifdef __cplusplus
 /* This is the mapping of the KUSER_SHARED_DATA structure into the 32 bit
-   user address space.  We need it here to access the current DismountCount. */
-static KUSER_SHARED_DATA &SharedUserData
-			 = *(volatile PKUSER_SHARED_DATA) 0x7ffe0000;
+   user address space.  We need it here to access the current DismountCount
+   and InterruptTime.  */
+static volatile KUSER_SHARED_DATA &SharedUserData
+	= *(volatile KUSER_SHARED_DATA *) 0x7ffe0000;
 
 extern "C"
 {

--------------050609010809050405010101--
